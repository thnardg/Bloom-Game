//
//  UserDefaultsExtension.swift
//  mini_challenge_1
//
//  Created by Enrique Carvalho on 24/07/23.
//

import Foundation
import SpriteKit

extension UserDefaults { // extension of UserDefaults for resetting it
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

extension SKNode { // func used maily for debug purposes, but also very useful for condition definitions
    func isChild(of parentNode: SKNode) -> Bool {
        return self.parent === parentNode
    }
}
