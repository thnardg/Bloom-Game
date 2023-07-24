//
//  UserDefaultsExtension.swift
//  mini_challenge_1
//
//  Created by Enrique Carvalho on 24/07/23.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
