//
//  Components.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import Foundation

var musicIsOn: Bool = true
var sfx: Bool = true
var alreadyPlayed: Bool = UserDefaults.standard.bool(forKey: "Data")
var isReturningToScene = false
var checkCount = UserDefaults.standard.integer(forKey: "check")
