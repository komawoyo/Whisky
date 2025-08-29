//
//  Bottle.swift
//  WhiskyKit
//
//  This file is part of Whisky.
//
//  Whisky is free software: you can redistribute it and/or modify it under the terms
//  of the GNU General Public License as published by the Free Software Foundation,
//  either version 3 of the License, or (at your option) any later version.
//
//  Whisky is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
//  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//  See the GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along with Whisky.
//  If not, see https://www.gnu.org/licenses/.
//

import Foundation
import SwiftUI
import os.log

// swiftlint:disable:next todo
// TODO: Should not be unchecked!
public final class Bottle: ObservableObject, Equatable, Hashable, Identifiable, Comparable, @unchecked Sendable {
    public let url: URL
    private let metadataURL: URL
    @Published public var settings: BottleSettings {
        didSet { saveSettings() }
    }
    @Published public var programs: [Program] = [] {
        didSet {
            // Invalidate cache when programs change
            cachedPinnedPrograms = nil
            lastProgramsUpdate = nil
        }
    }
    @Published public var inFlight: Bool = false
    public var isAvailable: Bool = false

    // Performance optimization: Cache pinned programs to avoid repeated computation
    private var cachedPinnedPrograms: [(pin: PinnedProgram, program: Program, id: String)]?
    private var lastProgramsUpdate: Date?

    /// All pins with their associated programs
    public var pinnedPrograms: [(pin: PinnedProgram, program: Program, id: String)] { // swiftlint:disable:this large_tuple
        // Performance optimization: Cache computation to avoid repeated file system checks
        let currentTime = Date()
        if let cached = cachedPinnedPrograms,
           let lastUpdate = lastProgramsUpdate,
           currentTime.timeIntervalSince(lastUpdate) < 2.0 { // Cache for 2 seconds
            return cached
        }

        let result = settings.pins.compactMap { pin -> (PinnedProgram, Program, String)? in
            let exists = FileManager.default.fileExists(atPath: pin.url?.path(percentEncoded: false) ?? "")
            guard let program = programs.first(where: { $0.url == pin.url && exists }) else { return nil }
            return (pin, program, "\(pin.name)//\(program.url)")
        }

        cachedPinnedPrograms = result
        lastProgramsUpdate = currentTime
        return result
    }

    public init(bottleUrl: URL, inFlight: Bool = false, isAvailable: Bool = false) {
        let metadataURL = bottleUrl.appending(path: "Metadata").appendingPathExtension("plist")
        self.url = bottleUrl
        self.inFlight = inFlight
        self.isAvailable = isAvailable
        self.metadataURL = metadataURL

        do {
            self.settings = try BottleSettings.decode(from: metadataURL)
        } catch {
            Logger.wineKit.error(
              "Failed to load settings for bottle `\(metadataURL.path(percentEncoded: false))`: \(error)"
            )
            self.settings = BottleSettings()
        }

        // Get rid of duplicates and pins that reference removed files
        var found: Set<URL> = []
        self.settings.pins = self.settings.pins.filter { pin in
            guard let url = pin.url else { return false }
            guard !found.contains(url) else { return false }
            found.insert(url)
            let urlPath = url.path(percentEncoded: false)
            let volume: URL?
            do {
                volume = try url.resourceValues(forKeys: [.volumeURLKey]).volume ?? nil
            } catch {
                volume = nil
            }
            let legallyRemoved = pin.removable && volume == nil
            return FileManager.default.fileExists(atPath: urlPath) || legallyRemoved
        }
    }

    /// Encode and save the bottle settings
    private func saveSettings() {
        do {
            try settings.encode(to: self.metadataURL)
        } catch {
            Logger.wineKit.error(
                "Failed to encode settings for bottle `\(self.metadataURL.path(percentEncoded: false))`: \(error)"
            )
        }
    }

    // MARK: - Equatable

    public static func == (lhs: Bottle, rhs: Bottle) -> Bool {
        return lhs.url == rhs.url
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(url)
    }

    // MARK: - Identifiable

    public var id: URL {
        self.url
    }

    // MARK: - Comparable

    public static func < (lhs: Bottle, rhs: Bottle) -> Bool {
        lhs.settings.name.lowercased() < rhs.settings.name.lowercased()
    }
}

public extension Sequence where Iterator.Element == Program {
    /// Filter all pinned programs
    var pinned: [Program] {
        return self.filter({ $0.pinned })
    }

    /// Filter all unpinned programs
    var unpinned: [Program] {
        return self.filter({ !$0.pinned })
    }
}
