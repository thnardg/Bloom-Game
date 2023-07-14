//
//  CircleGlowScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 13/07/23.
//

import SpriteKit
import GameplayKit

// Cria um efeito de brilho para ser aplicado em qualquer SKSpriteNode. Mudar para a pasta utils?
extension SKSpriteNode {
    func addGlow(radius: Float = 30) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        let effect = SKSpriteNode(texture: texture)
        effect.color = .cyan // Mudar para .self.color
        effect.size = self.size
        effect.colorBlendFactor = 1
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}

class CircleGlowScene: SKScene {
    
    override func didMove(to view: SKView) {
        let circle = SKSpriteNode(imageNamed: "O") // Node da forma inicial
        circle.size = CGSize(width: 100, height: 100)
        circle.position = CGPoint(x: frame.midX, y: frame.midY)
        circle.addGlow()
        addChild(circle)
        
        // Animação breathing:
        let scaleUp = SKAction.scale(to: 1.0, duration: 3.5)
        let scaleDown = SKAction.scale(to: 0.5, duration: 3.5)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        let repeatForever = SKAction.repeatForever(sequence)
        
        shakeCamera(layer: circle, duration: 5)
        circle.run(repeatForever)
    }
    
    // Animação de shake
    func shakeCamera(layer:SKSpriteNode, duration:Float) {

        let amplitudeX:Float = 10;
        let amplitudeY:Float = 6;
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
        layer.run(actionSeq);
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let circleSliderScene = SKScene(fileNamed: "CircleSliderScene")
        self.view?.presentScene(circleSliderScene)
    }
}

