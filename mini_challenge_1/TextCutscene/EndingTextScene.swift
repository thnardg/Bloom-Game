import SpriteKit
import GameplayKit

class EndingTextScene: SKScene {
    
    private var label: SKLabelNode!
    private var cutsceneText = [NSLocalizedString("Overcome", comment: ""), NSLocalizedString("Voice", comment: "")]
    private var currentTextIndex = 0
    
    override func didMove(to view: SKView) {
        
        // Music and sfx for the conclusion of the demo:
        SoundDesign.shared.fadeOutMusic(duration: 1.0) {
            SoundDesign.shared.fadeInMusic(filename: "happiness.mp3", duration: 2.0)
        }
        SoundDesign.shared.fadeOutSoundEffect(duration: 2.0) {
            SoundDesign.shared.playSoundEffect(filename: "humming.mp3")
        }
        
        self.backgroundColor = .black

        // Adds the final cutscene text
        label = SKLabelNode(fontNamed: "Sora")
        label.fontSize = 18
        label.text = cutsceneText[currentTextIndex]
        label.fontColor = SKColor.white
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(label)
        fadeLabelIn()
    }
    
    // Creates a fade-in effect for the text
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
        // Skips the text if the player taps the screen
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
