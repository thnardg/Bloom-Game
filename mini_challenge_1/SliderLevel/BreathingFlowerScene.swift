import SpriteKit

class BreathingFlowerScene: SKScene {
    let shapeGroup = SKNode()
    let sliderSound = SKAudioNode(fileNamed: "radio.mp3")
    let audioWaveUp = SKSpriteNode(imageNamed: "highwave")
    let audioWaveDown = SKSpriteNode(imageNamed: "lowwave")
    
    var shape: [SKSpriteNode] = []
    var slider: UISlider!
    var isLocked = false
    var isAnimationRunning = true
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.addChild(sliderSound)
        // Intro song Fade-out and fade-in the level 1 main theme song:
        sliderSound.run(.changeVolume(to: 0.1, duration: 0))
         SoundDesign.shared.fadeOutMusic(duration: 2.0) {
            SoundDesign.shared.fadeInMusic(filename: "medo.mp3", duration: 3.0)
        }
        
        // Generates a flower with 4 shape nodes
        for i in 0..<4 {
            let medoAsset = SKSpriteNode(imageNamed: "medo")
            medoAsset.position = CGPoint(x: frame.midX, y: frame.midY)
            shapeGroup.addChild(medoAsset) // Combine the 4 petals into one group
            shapeGroup.setScale(0.25)
            shape.append(medoAsset)
            
            if i == 1 || i == 3 {
                medoAsset.zRotation = CGFloat.pi / 2 // Rotate nodes 1 and 3 (horizontal petals)
            }
        }
        addChild(shapeGroup)
        
        // Moves the petals
        let wait = SKAction.wait(forDuration: 2)
        
        let moveUp = SKAction.moveBy(x: 0, y: 60, duration: 4.0)
        let moveDown = SKAction.moveBy(x: 0, y: -60, duration: 4.0)
        let moveLeft = SKAction.moveBy(x: -60, y: 0, duration: 4.0)
        let moveRight = SKAction.moveBy(x: 60, y: 0, duration: 4.0)
        
        // Petal animation sequence (moving outwards and inwards)
        let sequence1 = SKAction.sequence([moveUp, wait, moveDown])
        let sequence2 = SKAction.sequence([moveRight, wait, moveLeft])
        let sequence3 = SKAction.sequence([moveDown, wait, moveUp])
        let sequence4 = SKAction.sequence([moveLeft, wait, moveRight])
        
        // Flower rotation movement
        let rotate45 = SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 4.0)
        let scaleUp = SKAction.scale(by: 2.0, duration: 4.0)
        let rotateMinus45 = SKAction.rotate(byAngle: CGFloat.pi / -2, duration: 4.0)
        let scaleDown = SKAction.scale(by: 0.5, duration: 4.0)
        
        // Flower rotation sequence
        let openFlower = SKAction.group([rotate45, scaleUp])
        let closeFlower = SKAction.group([rotateMinus45, scaleDown])
        let sequence5 = SKAction.sequence([openFlower, wait, closeFlower])
        
        // Determines how long will the animations repeat
        shape[0].run(SKAction.repeatForever(sequence1))
        shape[1].run(SKAction.repeatForever(sequence2))
        shape[2].run(SKAction.repeatForever(sequence3))
        shape[3].run(SKAction.repeatForever(sequence4))
        
        // Group sequence
        shapeGroup.run(SKAction.repeatForever(sequence5))
        
        // ------- UI Slider -------
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.center = CGPoint(x: view.frame.size.width - 60, y: view.frame.size.height / 2)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
        slider.minimumTrackTintColor = .white // changes the color of the slider to white
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.minimumValue = 10 // min value so the shape doesnt get too small on the screen
        slider.maximumValue = 100
        slider.value = 55 // defines the middle of the slider
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        view.addSubview(slider)
        
        // Audio wave nodes:
        audioWaveUp.size = CGSize(width: 30, height: 30)
        audioWaveDown.size = CGSize(width: 30, height: 30)
        audioWaveUp.position = CGPoint(x: frame.maxX - 60, y: frame.maxY - 60)
        audioWaveDown.position = CGPoint(x: frame.maxX - 60, y: frame.minY + 60)
        self.addChild(audioWaveUp)
        self.addChild(audioWaveDown)
        
    }
    
    // Changes the shape size and the sound rate according to the slider value:
    @objc func sliderChanged(_ sender : UISlider) {
        if isLocked { return }
        shapeGroup.setScale(CGFloat(sender.value / sender.maximumValue))
        
        let rate = sender.value / 50
        sliderSound.run(SKAction.changePlaybackRate(to: Float(Double(rate)), duration: 0))
        
        // adds glow effect:
        if sender.value >= 85 && sender.value <= 100 {
            shape[0].addGlow(radius: 2)
            shape[1].addGlow(radius: 2)
            shape[2].addGlow(radius: 2)
            shape[3].addGlow(radius: 2)
        } else {
            shape[0].removeGlow()
            shape[1].removeGlow()
            shape[2].removeGlow()
            shape[3].removeGlow()
        }
    }
    
    // Animations for when the slider is released at the correct position:
    @objc func sliderReleased(sender: UISlider) {
        
        if sender.value >= 85 && sender.value <= 100 && !isLocked {
            isLocked = true
            slider.removeFromSuperview()
            audioWaveUp.removeFromParent()
            audioWaveDown.removeFromParent()
            sliderSound.removeFromParent()

            // Remove all animations
            shapeGroup.removeAllActions()
            shape[0].removeAllActions()
            shape[1].removeAllActions()
            shape[2].removeAllActions()
            shape[3].removeAllActions()
            
            // Reposition the petals to form the correct shape:
            shape[0].run(SKAction.moveTo(y: 60, duration: 1.0))
            shape[1].run(SKAction.moveTo(x: 60, duration: 1.0))
            shape[2].run(SKAction.moveTo(y: -60, duration: 1.0))
            shape[3].run(SKAction.moveTo(x: -60, duration: 1.0))
            
            // Rotate the flower to the correct position:
            let endSequence = SKAction.sequence([.rotate(toAngle: CGFloat.pi / 2, duration: 1.0), .wait(forDuration: 0.5), .scale(by: 1.1, duration: 1.0), .scale(by: 0.95, duration: 1.0), .fadeOut(withDuration: 0.8)])
            
            shapeGroup.run(endSequence, completion: {

                let level01 = SKScene(fileNamed: "Level01Scene")
                self.view?.presentScene(level01)
            })
        }
    }
}
