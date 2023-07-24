import SpriteKit
import GameplayKit

class IntroTextScene: SKScene {
    
    private var label: SKLabelNode!
    private var cutsceneText = ["Você é um grão", "No vazio você vê uma luz", "O que ela quer te dizer?"]
    private var currentTextIndex = 0
    
    override func didMove(to view: SKView) {
//        UserDefaults.resetDefaults()
        
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
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        let waitAction2 = SKAction.wait(forDuration: 2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let fadeSequence = SKAction.sequence([waitAction, fadeInAction, waitAction2, fadeOutAction])
        label.run(fadeSequence) {
            self.currentTextIndex += 1
            if self.currentTextIndex < self.cutsceneText.count {
                self.label.text = self.cutsceneText[self.currentTextIndex]
                self.fadeLabelIn()
            } else {
                let circleGlowScene = SKScene(fileNamed: "CircleGlowScene")
                self.view?.presentScene(circleGlowScene)
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
                let circleGlowScene = SKScene(fileNamed: "CircleGlowScene")
                self.view?.presentScene(circleGlowScene)
            }
        } else {
                let circleGlowScene = SKScene(fileNamed: "CircleGlowScene")
                self.view?.presentScene(circleGlowScene)
            }
    }
}
