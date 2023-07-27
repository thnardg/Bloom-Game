////
////  IdleState.swift
////  SKStateTest
////
////  Created by Enrique Carvalho on 17/07/23.
////
//
//import Foundation
//import GameplayKit
//
//class IdleState: GKState{
//    weak var gameScene: Level01Scene?
////    var direction: Direction
////
//    init(gameScene: Level01Scene) {
//        self.gameScene = gameScene
//    }
//    
//    override func didEnter(from previousState: GKState?) {
//        player.removeAllActions()
//        player.texture = SKTexture(imageNamed: "im1")
//    }
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        switch stateClass{
//        default:
//            return true
//        }
//    }
//}
//
