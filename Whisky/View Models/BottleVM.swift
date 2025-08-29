//
//  BottleVM.swift
//  Whisky
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
import SemanticVersion
import WhiskyKit

// Swift 6.0: Use proper actor isolation instead of @unchecked Sendable
@MainActor
final class BottleVM: ObservableObject {
    @MainActor static let shared = BottleVM()

    var bottlesList = BottleData()
    @Published var bottles: [Bottle] = []

    // Performance optimization: Cache bottle data to avoid unnecessary reloads
    private var lastLoadTime: Date?
    private let cacheValidityInterval: TimeInterval = 5.0 // 5 seconds
    private var cachedActiveCount: Int?

    @MainActor
    func loadBottles(forceReload: Bool = false) {
        // Performance optimization: Use caching to avoid unnecessary file system operations
        if !forceReload,
           let lastLoad = lastLoadTime,
           Date().timeIntervalSince(lastLoad) < cacheValidityInterval {
            return // Use cached data
        }

        bottles = bottlesList.loadBottles()
        lastLoadTime = Date()
        // Invalidate cached count when bottles change
        cachedActiveCount = nil
    }

    func countActive() -> Int {
        // Performance optimization: Cache active count to avoid repeated filtering
        if let cached = cachedActiveCount {
            return cached
        }

        let count = bottles.filter { $0.isAvailable == true }.count
        cachedActiveCount = count
        return count
    }

    func createNewBottle(bottleName: String, winVersion: WinVersion, bottleURL: URL) -> URL {
        let newBottleDir = bottleURL.appending(path: UUID().uuidString)

        Task.detached {
            var bottleId: Bottle?
            do {
                try FileManager.default.createDirectory(atPath: newBottleDir.path(percentEncoded: false),
                                                        withIntermediateDirectories: true)
                let bottle = Bottle(bottleUrl: newBottleDir, inFlight: true)
                bottleId = bottle

                await MainActor.run {
                    self.bottles.append(bottle)
                }

                bottle.settings.windowsVersion = winVersion
                bottle.settings.name = bottleName
                try await Wine.changeWinVersion(bottle: bottle, win: winVersion)
                let wineVer = try await Wine.wineVersion()
                bottle.settings.wineVersion = SemanticVersion(wineVer) ?? SemanticVersion(0, 0, 0)
                // Add record
                await MainActor.run {
                    self.bottlesList.paths.append(newBottleDir)
                    self.loadBottles()
                }
            } catch {
                print("Failed to create new bottle: \(error)")
                if let bottle = bottleId {
                    await MainActor.run {
                        if let index = self.bottles.firstIndex(of: bottle) {
                            self.bottles.remove(at: index)
                        }
                    }
                }
            }
        }
        return newBottleDir
    }
}
