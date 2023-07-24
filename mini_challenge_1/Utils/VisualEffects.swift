
import SpriteKit

// Cria um efeito de brilho para ser aplicado em qualquer SKSpriteNode.
extension SKSpriteNode {
    func addGlow(radius: Float) {
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
    
    func removeGlow() {
            for child in children {
                if let effectNode = child as? SKEffectNode {
                    effectNode.removeFromParent()
                }
            }
        }
}
