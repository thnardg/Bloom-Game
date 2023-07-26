//
//  Checkpoints.swift
//  SKStateTest
//
//  Created by Enrique Carvalho on 21/07/23.
//

import Foundation
import SpriteKit

var checkpoint = Checkpoint()

class Checkpoint: SKSpriteNode{ // create checkpoint node
    let locationsKey = "locations"
    let checkLocKey = "checkpointLoc" // Userdef. Keys

    var locations: [CGPoint] // locations where checkpoints will appear, initialized in retrieve()'s first run
    
    init() { // initializing the node
        let color: UIColor = .red // defining one's color
        let size = CGSize(width: 50, height: 200) // its size
        
        locations = [] // initializing an empty array for locations
        super.init(texture: nil, color: color, size: size) // initializing SKSpriteNode
        self.locations = retrieve() // inserting locations into the array
        
        save() // saving it to UserDefs.
        
        self.position = locations.first! // changing its initial position
        configurePhysics() // configuring its contact
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCheckpoint(){ // run after the contact detection between player and checkpoint
        player.playerCheckpoint = locations.first
        if locations.count > 1{
            locations.remove(at: 0)
        }
        self.position = locations.first!
        save()
        
    }
    
    private func configurePhysics(){
        let body = SKPhysicsBody(rectangleOf: size)
                body.isDynamic = false // Set to false so that the checkpoint doesn't move due to physics interactions
                body.affectedByGravity = false // Set to false since the checkpoint doesn't need gravity
                body.allowsRotation = false // Set to false so that the checkpoint doesn't rotate

                body.categoryBitMask = 4 // Choose a unique bitmask for checkpoints, different from player and ground
                body.collisionBitMask = 0 // No need for collision detection with other bodies
                body.contactTestBitMask = 1 // Detect contacts with the player

                physicsBody = body
                name = "checkpoint"
    }
    func save(){
        if let encodedData = try? JSONEncoder().encode(locations) {
            UserDefaults.standard.set(encodedData, forKey: locationsKey)
        }
    }
    
    func retrieve() -> [CGPoint]{
        if let data = UserDefaults.standard.data(forKey: locationsKey),
            let savedItems = try? JSONDecoder().decode([CGPoint].self, from: data){
            return savedItems
        }
        else {return [
            CGPoint(x: 556.577, y: -364.928),
            CGPoint(x: 7575, y: -265.93),
            CGPoint(x: 10077.53, y: -175.077),
            CGPoint(x: 16824.793, y: 427.281)
        ]}
    }
}
