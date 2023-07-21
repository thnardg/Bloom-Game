import Foundation
import SpriteKit
import GameplayKit

class JumpState: GKState{
    weak var gameScene: GameScene?
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
    }
    
    override func didEnter(from previousState: GKState?) {
        let direction = (player.xScale == -1 ? (player.speed ) * -10 : (player.speed ) * 10)
        let height = (player.size.height * 0.88) * 2
        
        if player.jumped <= player.jumpLimit {
            if player.jumped == 2{
                player.physicsBody?.isResting = true
            }
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: height))
            player.jumped += 1
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass{
//        case is IdleState.Type:
//            return true
        default:
            return true
        }
    }
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}

