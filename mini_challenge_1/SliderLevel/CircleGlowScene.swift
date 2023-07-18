//
//  CircleGlowScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 13/07/23.
//

import SpriteKit
import GameplayKit

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
        
        circle.run(repeatForever)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let circleSliderScene = SKScene(fileNamed: "CircleSliderScene")
        self.view?.presentScene(circleSliderScene)
    }
}
