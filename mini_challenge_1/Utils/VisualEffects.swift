//
//  VisualEffects.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import SpriteKit

// Cria um efeito de brilho para ser aplicado em qualquer SKSpriteNode.
extension SKSpriteNode {
    func addGlow(radius: Float = 30) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        let effect = SKSpriteNode(texture: texture)
        effect.color = .white
        effect.size = self.size
        effect.colorBlendFactor = 1
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}
