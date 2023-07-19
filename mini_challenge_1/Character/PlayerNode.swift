
import Foundation
import GameplayKit
import SpriteKit

var player = PlayerNode()

class PlayerNode: SKSpriteNode {
    let textureSheet = [SKTexture(imageNamed: "im1"),
                        SKTexture(imageNamed: "im2"),
                        SKTexture(imageNamed: "im3"),
                        SKTexture(imageNamed: "im4"),
                        SKTexture(imageNamed: "im5"),
                        SKTexture(imageNamed: "im6"),
                        SKTexture(imageNamed: "im7"),
                        SKTexture(imageNamed: "im8")
    ]
    var jumpLimit = 2
    var jumped = 0
    var animationFrameTime = 0.6
    var state: GKStateMachine?
    
    init() {
        let texture = SKTexture(imageNamed: "im1")
        let size = CGSize(width: 70, height: 150)
        let speed = 5.0
        super.init(texture: texture, color: .clear, size: size)
        self.speed = speed
        
        configurePhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.isDynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        
        
        body.categoryBitMask = 1
        body.collisionBitMask = 2
        body.contactTestBitMask = 1
        
        physicsBody = body
        name = "player"
    }
}
