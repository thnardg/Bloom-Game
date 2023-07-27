import SpriteKit
import GameplayKit

class YellowCircleScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        SoundDesign.shared.playSoundEffect(filename: "humming.mp3")

        let circle = SKSpriteNode(imageNamed: "O2") // Node da forma inicial
        circle.size = CGSize(width: 150, height: 150)
        circle.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(circle)
        
        // Animação breathing:
        let scaleUp = SKAction.scale(to: 1.0, duration: 3.5)
        let scaleDown = SKAction.scale(to: 0.5, duration: 3.5)
        let wait = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([scaleDown, scaleUp, wait, scaleDown, scaleUp, wait])
        
        circle.run(sequence, completion: {
            // Próxima cena:
            let gameScene = SKScene(fileNamed: "GameScene")
            self.view?.presentScene(gameScene)
        })
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let gameScene = SKScene(fileNamed: "GameScene")
        self.view?.presentScene(gameScene)
    }
}
