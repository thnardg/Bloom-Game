import SpriteKit

class HeadphoneScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Cor do background.
        self.backgroundColor = .black
        
        // Node Headphone:
        let headphone = SKSpriteNode(imageNamed: "phone")
        headphone.size = CGSize(width: 80, height: 80)
        headphone.alpha = 0
        headphone.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 40)
        self.addChild(headphone)
        
        // Texto Headphone:
        let avisoHeadphones = SKLabelNode(text: NSLocalizedString("Headphone", comment: ""))
        avisoHeadphones.fontName = "Sora"
        avisoHeadphones.fontSize = 18
        avisoHeadphones.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        avisoHeadphones.alpha = 0
        self.addChild(avisoHeadphones)
        
        // Fade-in e Fade-out
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let sequenceAction = SKAction.sequence([fadeInAction, SKAction.wait(forDuration: 1.0), fadeOutAction])
        
        // Animação:
        headphone.run(sequenceAction)
        avisoHeadphones.run(sequenceAction, completion: {
            // Próxima cena:
            let introTextScene = SKScene(fileNamed: player.playerCheckpoint != CGPoint(x: 0.0, y: 0.0) ? "Level01Scene" : "IntroTextScene")
            self.view?.presentScene(introTextScene)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let introTextScene = SKScene(fileNamed: player.playerCheckpoint != CGPoint(x: 0.0, y: 0.0) ? "Level01Scene" : "IntroTextScene")
            self.view?.presentScene(introTextScene)
        SoundDesign.shared.stopSoundEffect()
        SoundDesign.shared.stopBackgroundMusic()
        SoundDesign.shared.playSoundEffect(filename: "storm.mp3")
        SoundDesign.shared.fadeInMusic(filename: "medo.mp3", duration: 3.0)
    }
}
