import SpriteKit
import Foundation

class SkButtonNode:  SKNode { //class to create buttons
    var image:SKSpriteNode? //image of the button
    var label:SKLabelNode? //label of the button
    
    
    init(image:SKSpriteNode?, label:SKLabelNode?) { //getting the information of the button
        self.image = image //getting image of the button
        self.label = label //getting the label of the button
        
        super.init() //doing the super init

        
        if let image = image {
            addChild(image) //adding the image of the button to the scene
        }
                
        if let label = label { //configuring the label of the buttton
            label.fontName = "Sora"
            label.fontSize = 20
            label.position = CGPoint(x: 0, y: -10)
            image?.addChild(label) //adding the label to the label
        }
    }
    
    required init?(coder aDecoder: NSCoder) { //required init
        super.init(coder: aDecoder)
        
    }
}
