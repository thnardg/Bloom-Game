import SpriteKit

class HeadphoneScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Background color
        self.backgroundColor = .black
        
        // Headphone node:
        let headphone = SKSpriteNode(imageNamed: "phone")
        headphone.size = CGSize(width: 80, height: 80)
        headphone.alpha = 0
        headphone.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 40)
        self.addChild(headphone)
        
        // Headphone text warning:
        let avisoHeadphones = SKLabelNode(text: NSLocalizedString("Headphone", comment: ""))
        avisoHeadphones.fontName = "Sora"
        avisoHeadphones.fontSize = 18
        avisoHeadphones.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        avisoHeadphones.alpha = 0
        self.addChild(avisoHeadphones)
        
        // Fade-in and Fade-out effects
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let sequenceAction = SKAction.sequence([fadeInAction, SKAction.wait(forDuration: 1.0), fadeOutAction])
        
        // Sequence action:
        headphone.run(sequenceAction)
        avisoHeadphones.run(sequenceAction, completion: {
            // Goes to the next scene
            let introTextScene = SKScene(fileNamed: player.playerCheckpoint != CGPoint(x: 0.0, y: 0.0) ? "Level01Scene" : "IntroTextScene")
            self.view?.presentScene(introTextScene)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let introTextScene = SKScene(fileNamed: player.playerCheckpoint != CGPoint(x: 0.0, y: 0.0) ? "Level01Scene" : "IntroTextScene")
            self.view?.presentScene(introTextScene)
        // Changes from intro song to the level main theme song and the storm sfx
        SoundDesign.shared.stopSoundEffect()
        SoundDesign.shared.stopBackgroundMusic()
        SoundDesign.shared.playSoundEffect(filename: "storm.mp3")
        SoundDesign.shared.fadeInMusic(filename: "medo.mp3", duration: 3.0)
    }
}
