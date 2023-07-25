import SpriteKit

class HeadphoneScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Cor do background.
        self.backgroundColor = .black
        
        // Node Headphone:
        let headphone = SKSpriteNode(imageNamed: "headphone")
        headphone.size = CGSize(width: 60, height: 60)
        headphone.alpha = 0
        headphone.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50)
        self.addChild(headphone)
        
        // Texto Headphone:
        let avisoHeadphones = SKLabelNode(text: "Esse jogo fica melhor com fones de ouvido")
        avisoHeadphones.fontName = "Helvetica-Bold"
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
            let introTextScene = SKScene(fileNamed: "IntroTextScene")
            self.view?.presentScene(introTextScene)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if alreadyPlayed == true {
            let introTextScene = SKScene(fileNamed: "Level01Scene")
            self.view?.presentScene(introTextScene)
            SoundDesign.shared.playSoundEffect(filename: "storm.mp3")
            SoundDesign.shared.playBackgroundMusic(filename: "medo.mp3")
            
        }else{
            let introTextScene = SKScene(fileNamed: "IntroTextScene")
            self.view?.presentScene(introTextScene)
        }
    }
}
