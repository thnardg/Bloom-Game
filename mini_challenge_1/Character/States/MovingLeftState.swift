import Foundation
import SpriteKit
import GameplayKit

class MovingLeftState: GKState{
    weak var gameScene: GameScene?
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
    }
    
    override func didEnter(from previousState: GKState?) {
        player.xScale = -1
        player.run(.repeatForever(.animate(with: (player.textureSheet), timePerFrame: player.animationFrameTime )))
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass{
        case is IdleState.Type:
            return true
        case is JumpState.Type:
            return true
        default:
            return false
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let run = SKAction.run {
            player.position.x -= player.speed
        }
        player.run(.sequence([.wait(forDuration: player.animationFrameTime), run]))
    }
}

