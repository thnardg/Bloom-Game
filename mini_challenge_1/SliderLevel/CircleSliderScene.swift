//
//  CircleSliderScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import SpriteKit
import GameplayKit

class CircleSliderScene: SKScene {
    
    var slider: UISlider!
    var shapeNode: SKSpriteNode!
    var isShaking = false
    var isLocked = false
    
    override func didMove(to view: SKView) {
        shapeNode = SKSpriteNode(imageNamed: "O")
        shapeNode.size = CGSize(width: 100, height: 100)
        shapeNode.addGlow()
        shapeNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(shapeNode)
        
        //Slider:
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        // Slider horizontal: slider.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 50)
        slider.center = CGPoint(x: view.frame.size.width - 60, y: view.frame.size.height / 2)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2) // Rotaciona o slider em 90º
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 55 // Meio do slider
        slider.isContinuous = true // Atualiza o valor enquanto o slider se move
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        view.addSubview(slider)
    }
    
    // Animação de shake
    func shakeCamera(layer:SKSpriteNode, duration:Float) {
        
        if layer.action(forKey: "shake") != nil {return}

    let amplitudeX:Float = 6;
    let amplitudeY:Float = 3;
    let numberOfShakes = duration / 0.04;
    var actionsArray:[SKAction] = [];
    for _ in 1...Int(numberOfShakes) {
        let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
        let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
        let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02);
        shakeAction.timingMode = SKActionTimingMode.easeOut;
        actionsArray.append(shakeAction);
        actionsArray.append(shakeAction.reversed());
    }

    let actionSeq = SKAction.sequence(actionsArray);
    layer.run(actionSeq, withKey: "shake");
}
    
    // Muda o tamanho da forma de acordo com o valor do slider
    @objc func sliderChanged(sender: UISlider) {
        if isLocked {return}
        let scale = CGFloat(sender.value / 50)
        shapeNode.setScale(scale)
        
        if sender.value >= 70 && sender.value <= 75 {
            shakeCamera(layer: shapeNode, duration: 5)
            isShaking = true
        } else {
            shapeNode.removeAllActions()
            isShaking = false
        }
    }
        
    @objc func sliderReleased(sender: UISlider) {
        if sender.value >= 70 && sender.value <= 75 && !isLocked {
            let label = SKLabelNode(text: "acertou")
            label.position = CGPoint(x: shapeNode.position.x, y: shapeNode.position.y + shapeNode.size.height/2 + 20)
            addChild(label)
            
            isLocked = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let gameScene = SKScene(fileNamed: "GameScene")
        self.view?.presentScene(gameScene)
        slider.removeFromSuperview()
    }
}
