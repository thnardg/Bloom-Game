import SpriteKit
import Foundation

class SkButtonNode:  SKNode {
    var image:SKSpriteNode?
    var label:SKLabelNode?
    
    
    init(image:SKSpriteNode?, label:SKLabelNode?) {
        self.image = image
        self.label = label
        
        super.init()

        
        if let image = image {
            addChild(image)
        }
                
        if let label = label {
            label.fontSize = 25
            label.position = CGPoint(x: 0, y: -10)
            image?.addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
