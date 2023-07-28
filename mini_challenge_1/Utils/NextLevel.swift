//
//  NextLevel.swift
//  mini_challenge_1
//
//  Created by Jairo Júnior on 28/07/23.
//

import Foundation
import SpriteKit


class NextLevel: SKSpriteNode{
    
    init(_ position: CGPoint){
        super.init(texture: .init(imageNamed: "O2"), color: .clear, size: CGSize(width: 50, height: 50))
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
                name = "nextLevel"
    }
    
}

