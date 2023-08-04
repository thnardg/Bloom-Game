//
//  DoubleJumpNode.swift
//  mini_challenge_1
//
//  Created by Enrique Carvalho on 24/07/23.
//

import Foundation
import SpriteKit

class DoubleJumpNode: SKSpriteNode{ // class used for double jump node definition, inherits from SKSpriteNode
    let key = "doubleJumpKey" // UserDefaults key
    
    var hasAcquired: Bool { // a boolean for whether the character has acquired the double jump, stored and retrieved from UserDefaults
        get{
            UserDefaults.standard.bool(forKey: key)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ position: CGPoint){ // the class initializer with the node's position parameter
        super.init(texture: SKTexture(imageNamed: "double_jumpbig"), color: .clear, size: CGSize(width: 50, height: 50)) // initializing the superclass
        self.position = position // setting the node's position for the one in the parameter
        
        configurePhysics() // configuring it as a physics body for contact recognition
    }
    
    required init?(coder aDecoder: NSCoder) { // superclass required init
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhysics(){
        let body = SKPhysicsBody(rectangleOf: self.size)
                body.isDynamic = false // Set to false so that the checkpoint doesn't move due to physics interactions
                body.affectedByGravity = false // Set to false since the checkpoint doesn't need gravity
                body.allowsRotation = false // Set to false so that the checkpoint doesn't rotate

                body.categoryBitMask = 4 // Choose a unique bitmask for checkpoints, different from player and ground
                body.collisionBitMask = 0 // No need for collision detection with other bodies
                body.contactTestBitMask = 1 // Detect contacts with the player

                physicsBody = body // attaching the body as the node's
                name = "doubleJump" // naming the node itself
    }
    
}
