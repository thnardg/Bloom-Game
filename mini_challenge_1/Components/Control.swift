//
//  Components.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import Foundation

var player = PlayerNode() // a global player variable that can be used in any level
var checkpoint = Checkpoint()// a global checkpoint variable that can be used in any level

var musicIsOn: Bool = true
var sfx: Bool = true
var alreadyPlayed: Bool = UserDefaults.standard.bool(forKey: "Data")
var isReturningToScene = false
var checkCount = UserDefaults.standard.integer(forKey: "check")
