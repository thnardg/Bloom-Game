//
//  DeadState.swift
//  SKStateTest
//
//  Created by Enrique Carvalho on 19/07/23.
//

import Foundation
import SpriteKit
import GameplayKit

class DeadState: GKState{
    weak var gameScene: GameScene?
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
    override func willExit(to nextState: GKState) {
        
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass{
        case is IdleState.Type:
            return true
        default:
            return false
        }
    }
    override func update(deltaTime seconds: TimeInterval) {
        let respawn = SKAction.run {
//            self.gameScene?.player.position.y = 0
//            self.gameScene?.player.position.x = 0
        }
        gameScene?.scene?.run(.sequence([.fadeOut(withDuration: 0.1), respawn, .fadeIn(withDuration: 0.1)]))
            
    }
}
