import SpriteKit
import GameplayKit

class GameStartScene: SKScene {
    
    override func didMove(to view: SKView) {

        // Background:
        self.backgroundColor = .black
        
        // Icon
        let icon = SKSpriteNode(imageNamed: "bloom_openning.png")
        icon.size = CGSize(width: 100, height: 100)
        icon.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(icon)
        
        // Fade-in and Fade-out
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        let sequenceAction = SKAction.sequence([fadeInAction, SKAction.wait(forDuration: 0.3), fadeOutAction, SKAction.wait(forDuration: 0.3)])
        
        // Sequence action for the animation:
        icon.run(sequenceAction, completion: {
            if let skView = self.view {
                skView.presentScene(SKScene(fileNamed: "GameScene")!, transition: SKTransition.fade(withDuration: 0.8))
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(SKScene(fileNamed: "GameScene")!, transition: SKTransition.fade(withDuration: 0.8))
    }
}
