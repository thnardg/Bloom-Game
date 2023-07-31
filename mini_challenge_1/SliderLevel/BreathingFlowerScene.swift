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
        // Fade-out da música inicial e fade-in da música da fase 1:
        sliderSound.run(.changeVolume(to: 0.1, duration: 0))
         SoundDesign.shared.fadeOutMusic(duration: 2.0) {
            SoundDesign.shared.fadeInMusic(filename: "medo.mp3", duration: 3.0)
        }
        
        // Criação da flor:
        for i in 0..<4 {
            let medoAsset = SKSpriteNode(imageNamed: "medo")
            medoAsset.position = CGPoint(x: frame.midX, y: frame.midY)
            shapeGroup.addChild(medoAsset) // Junta as 4 pétalas em 1 só grupo
            shapeGroup.setScale(0.25)
            shape.append(medoAsset)
            
            if i == 1 || i == 3 {
                medoAsset.zRotation = CGFloat.pi / 2 // Gira os nodes 1 e 3 (pétalas horizontais)
            }
        }
        addChild(shapeGroup)
        
        // Movimentos das pétalas:
        let wait = SKAction.wait(forDuration: 2)
        
        let moveUp = SKAction.moveBy(x: 0, y: 60, duration: 4.0)
        let moveDown = SKAction.moveBy(x: 0, y: -60, duration: 4.0)
        let moveLeft = SKAction.moveBy(x: -60, y: 0, duration: 4.0)
        let moveRight = SKAction.moveBy(x: 60, y: 0, duration: 4.0)
        
        // Sequência de movimentos das pétalas:
        let sequence1 = SKAction.sequence([moveUp, wait, moveDown])
        let sequence2 = SKAction.sequence([moveRight, wait, moveLeft])
        let sequence3 = SKAction.sequence([moveDown, wait, moveUp])
        let sequence4 = SKAction.sequence([moveLeft, wait, moveRight])
        
        // Movimento de rotacionar a flor:
        let rotate45 = SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 4.0)
        let scaleUp = SKAction.scale(by: 2.0, duration: 4.0)
        let rotateMinus45 = SKAction.rotate(byAngle: CGFloat.pi / -2, duration: 4.0)
        let scaleDown = SKAction.scale(by: 0.5, duration: 4.0)
        
        // Sequência de rotação da flor:
        let openFlower = SKAction.group([rotate45, scaleUp])
        let closeFlower = SKAction.group([rotateMinus45, scaleDown])
        let sequence5 = SKAction.sequence([openFlower, wait, closeFlower])
        
        // Sequência de repetição das pétalas:
        shape[0].run(SKAction.repeatForever(sequence1))
        shape[1].run(SKAction.repeatForever(sequence2))
        shape[2].run(SKAction.repeatForever(sequence3))
        shape[3].run(SKAction.repeatForever(sequence4))
        
        // Sequência do grupo
        shapeGroup.run(SKAction.repeatForever(sequence5))
        
        // ------- Slider -------
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.center = CGPoint(x: view.frame.size.width - 60, y: view.frame.size.height / 2)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
        slider.minimumTrackTintColor = .white // Altera a cor do slider
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 55
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        view.addSubview(slider)
        
        // Adiciona os nodes de ondas sonoras:
        audioWaveUp.size = CGSize(width: 30, height: 30)
        audioWaveDown.size = CGSize(width: 30, height: 30)
        audioWaveUp.position = CGPoint(x: frame.maxX - 60, y: frame.maxY - 60)
        audioWaveDown.position = CGPoint(x: frame.maxX - 60, y: frame.minY + 60)
        self.addChild(audioWaveUp)
        self.addChild(audioWaveDown)
        
    }
    
    // Muda o tamanho da forma e o tom do som de acordo com o valor do slider:
    @objc func sliderChanged(_ sender : UISlider) {
        if isLocked { return }
        shapeGroup.setScale(CGFloat(sender.value / sender.maximumValue))
        
        let rate = sender.value / 50
        sliderSound.run(SKAction.changePlaybackRate(to: Float(Double(rate)), duration: 0))
        
        // Adiciona um efeito de brilho quando o valor do slider fica entre 70 e 85:
        if sender.value >= 70 && sender.value <= 85 {
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
    
    // Quando o player solta o slider na posição certa:
    @objc func sliderReleased(sender: UISlider) {
        
        if sender.value >= 70 && sender.value <= 85 && !isLocked {
            isLocked = true
            slider.removeFromSuperview()
            audioWaveUp.removeFromParent()
            audioWaveDown.removeFromParent()
            sliderSound.removeFromParent()

            // Remove todas as animações
            shapeGroup.removeAllActions()
            shape[0].removeAllActions()
            shape[1].removeAllActions()
            shape[2].removeAllActions()
            shape[3].removeAllActions()
            
            // Reposiciona as pétalas:
            shape[0].run(SKAction.moveTo(y: 60, duration: 1.0))
            shape[1].run(SKAction.moveTo(x: 60, duration: 1.0))
            shape[2].run(SKAction.moveTo(y: -60, duration: 1.0))
            shape[3].run(SKAction.moveTo(x: -60, duration: 1.0))
            
            // Rotaciona a flor pra posição final:
            let endSequence = SKAction.sequence([.rotate(toAngle: CGFloat.pi / 2, duration: 1.0), .wait(forDuration: 0.5), .scale(by: 1.1, duration: 1.0), .scale(by: 0.95, duration: 1.0), .fadeOut(withDuration: 0.8)])
            
            shapeGroup.run(endSequence, completion: {

                let level01 = SKScene(fileNamed: "Level01Scene")
                self.view?.presentScene(level01)
            })
        }
    }
}
