import SpriteKit
import GameplayKit

class EndingTextScene: SKScene {
    
    private var label: SKLabelNode!
    private var cutsceneText = ["Você superou o seu medo", "De quem é essa voz?"]
    private var currentTextIndex = 0
    
    override func didMove(to view: SKView) {
        
        // Músicas e efeitos pra concluir o jogo:
        SoundDesign.shared.fadeOutMusic(duration: 1.0) {
            SoundDesign.shared.fadeInMusic(filename: "happiness.mp3", duration: 2.0)
        }
        SoundDesign.shared.fadeOutSoundEffect(duration: 2.0) {
            SoundDesign.shared.playSoundEffect(filename: "humming.mp3")
        }
        
        self.backgroundColor = .black

        label = SKLabelNode(fontNamed: "Helvetica-Bold")
        label.fontSize = 18
        label.text = cutsceneText[currentTextIndex]
        label.fontColor = SKColor.white
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(label)
        fadeLabelIn()
    }
    
    // Cria um efeito de fade in no texto depois de 1 segundo de tela preta
    private func fadeLabelIn() {
        label.alpha = 0
        let waitAction = SKAction.wait(forDuration: 1)
        let fadeInAction = SKAction.fadeIn(withDuration: 3.0)
        let waitAction2 = SKAction.wait(forDuration: 2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 3.0)
        let fadeSequence = SKAction.sequence([waitAction, fadeInAction, waitAction2, fadeOutAction])
        label.run(fadeSequence) {
            self.currentTextIndex += 1
            if self.currentTextIndex < self.cutsceneText.count {
                self.label.text = self.cutsceneText[self.currentTextIndex]
                self.fadeLabelIn()
            } else {
                let yellowCircleScene = SKScene(fileNamed: "YellowCircleScene")
                self.view?.presentScene(yellowCircleScene)
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentTextIndex < cutsceneText.count {
            label.removeAllActions()
            currentTextIndex += 1
            if currentTextIndex < cutsceneText.count {
                label.text = cutsceneText[currentTextIndex]
                fadeLabelIn()
            } else {
                let yellowCircleScene = SKScene(fileNamed: "YellowCircleScene")
                self.view?.presentScene(yellowCircleScene)
            }
        } else {
                let yellowCircleScene = SKScene(fileNamed: "YellowCircleScene")
                self.view?.presentScene(yellowCircleScene)
            }
    }
}
