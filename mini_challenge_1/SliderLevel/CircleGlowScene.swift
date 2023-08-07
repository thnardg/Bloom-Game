import SpriteKit
import GameplayKit

class CircleGlowScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        
        // Storm sound effect
        SoundDesign.shared.playSoundEffect(filename: "storm.mp3")
        
        

        let circle = SKSpriteNode(imageNamed: "O1") // Initial shape node
        circle.size = CGSize(width: 150, height: 150)
        circle.position = CGPoint(x: frame.midX, y: frame.midY)
        circle.addGlow(radius: 10)
        addChild(circle)
        
        // breathing animation:
        let scaleUp = SKAction.scale(to: 1.0, duration: 3.5)
        let scaleDown = SKAction.scale(to: 0.5, duration: 3.5)
        let wait = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([scaleDown, scaleUp, wait, scaleDown, scaleUp, wait])
        
        circle.run(sequence, completion: {
            // Goes to next scene aftr the animation completion
            let breathingFlowerScene = SKScene(fileNamed: "BreathingFlowerScene")
            self.view?.presentScene(breathingFlowerScene)
        })
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let breathingFlowerScene = SKScene(fileNamed: "BreathingFlowerScene")
        self.view?.presentScene(breathingFlowerScene)
    }
}
