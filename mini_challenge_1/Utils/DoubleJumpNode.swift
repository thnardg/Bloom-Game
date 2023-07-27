//
//  DoubleJumpNode.swift
//  mini_challenge_1
//
//  Created by Enrique Carvalho on 24/07/23.
//

import Foundation
import SpriteKit

class DoubleJumpNode: SKSpriteNode{
    let key = "doubleJumpKey"
    
    var hasAcquired: Bool {
        get{
            UserDefaults.standard.bool(forKey: key)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ position: CGPoint){
        super.init(texture: nil, color: .yellow, size: CGSize(width: 50, height: 50))
        self.position = position
        
        configurePhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhysics(){
        let body = SKPhysicsBody(rectangleOf: size)
                body.isDynamic = false // Set to false so that the checkpoint doesn't move due to physics interactions
                body.affectedByGravity = false // Set to false since the checkpoint doesn't need gravity
                body.allowsRotation = false // Set to false so that the checkpoint doesn't rotate

                body.categoryBitMask = 4 // Choose a unique bitmask for checkpoints, different from player and ground
                body.collisionBitMask = 0 // No need for collision detection with other bodies
                body.contactTestBitMask = 1 // Detect contacts with the player

                physicsBody = body
                name = "doubleJump"
    }
    
}
