import Foundation
import GameplayKit

enum Direction{
    case left
    case right
}

class MovingRightState: GKState{
    weak var gameScene: GameScene?

    init(gameScene: GameScene) {
        self.gameScene = gameScene
    }
    
    override func didEnter(from previousState: GKState?) {
        player.xScale = 1
        player.run(.repeatForever(.animate(with: (player.textureSheet), timePerFrame: player.animationFrameTime)))
    }
    override func willExit(to nextState: GKState) {
        
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    override func update(deltaTime seconds: TimeInterval) {
        let run = SKAction.run {
            player.position.x += player.speed
        }
        player.run(.sequence([.wait(forDuration: player.animationFrameTime ), run]))
    }
}
