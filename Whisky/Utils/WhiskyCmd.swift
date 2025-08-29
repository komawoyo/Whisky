//
//  WhiskyCmd.swift
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
import AppKit

class WhiskyCmd {
    static func install() async {
        let whiskyCmdURL = Bundle.main.url(forResource: "WhiskyCmd", withExtension: nil)

        if let whiskyCmdURL = whiskyCmdURL {
            // swiftlint:disable line_length
            let script = """
            do shell script "ln -fs \(whiskyCmdURL.path(percentEncoded: false)) /usr/local/bin/whisky" with administrator privileges
            """
            // swiftlint:enable line_length

            // Swift 6.0: Handle AppleScript execution with proper QoS management
            await withCheckedContinuation { continuation in
                DispatchQueue.global(qos: .userInitiated).async {
                    var error: NSDictionary?
                    var result: NSAppleEventDescriptor?

                    if let appleScript = NSAppleScript(source: script) {
                        result = appleScript.executeAndReturnError(&error)
                    }

                    Task { @MainActor in
                        if let error = error {
                            print(error)
                            if let description = error["NSAppleScriptErrorMessage"] as? String {
                                let alert = NSAlert()
                                alert.messageText = String(localized: "alert.message")
                                alert.informativeText = String(localized: "alert.info")
                                    + description
                                alert.alertStyle = .critical
                                alert.addButton(withTitle: String(localized: "button.ok"))
                                alert.runModal()
                            }
                        }
                        continuation.resume()
                    }
                }
            }
        }
    }
}
