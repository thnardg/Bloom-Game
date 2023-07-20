//
//  Level01Scene.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import Foundation
import SpriteKit
import GameplayKit

class Level01Scene: GameScene, SKPhysicsContactDelegate { // first platformer level
    // defining buttons
    var moveLeftButton: SkButtonNode?
    var moveRightButton: SkButtonNode?
    var jumpButton: SkButtonNode?
    var returnButton: SkButtonNode?
    
    // defining level camera
    var cameraNode: SKCameraNode?
    
    // defining state machine
    var state: GKStateMachine?
//    let shape = SKSpriteNode(color: .white, size: CGSize(width: 50, height: 100)) // debugging
    
    override func didMove(to view: SKView) { // loaded when reaching the level
        createMoveButtons() // self-explanatory
        cameraNode = SKCameraNode() // defining custom camera as level camera
        self.camera = cameraNode // defining custom camera as level camera
        if let camera = cameraNode{
            addChild(camera) // adding camera to scene
        }
        self.addChild(player) // adding player to scene
        
//        addChild(shape) // debugging
        
    }
    
    func createMoveButtons() { // creating and customizing move buttons
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "return")) // creating return button (returns to game start)
       
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        jumpButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Up")) // creating jump button for the player character
       
        if let button = jumpButton{
            addChild(button) // adding it to the scene's node tree
        }
        
        moveLeftButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Left")) // creating the move left button for the player character
        
        if let button = moveLeftButton{
            addChild(button) // adding it to the scene's node tree
        }
        
        moveRightButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Right")) // creating the move right button for the player character
        
        if let button = moveRightButton{
            addChild(button) // adding it to the scene's node tree
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        state?.update(deltaTime: currentTime) // calling the character's state machine update func
        
//        shape.position = player.position // debugging
//        print(state?.currentState)
        
        if let camera = cameraNode{ // safe unwrapping the camera node
            camera.run(.group([.moveTo(x: player.position.x, duration: 0.5), .moveTo(y: player.position.y, duration: 0)]))
            
            // fixing buttons to the camera
        moveLeftButton?.position.x = camera.position.x - 300
        moveLeftButton?.position.y = player.position.y - 100
        moveRightButton?.position.x = camera.position.x - 200
        moveRightButton?.position.y = player.position.y - 100
        jumpButton?.position.x = camera.position.x  + 300
        jumpButton?.position.y = player.position.y - 100
        returnButton?.position.x = camera.position.x - 0
        returnButton?.position.y = player.position.y + 150
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self // setting the world physics
        
        state = GKStateMachine(states: [DeadState(gameScene: self), IdleState(gameScene: self), JumpState(gameScene: self), MovingLeftState(gameScene: self), MovingRightState(gameScene: self)]) // defining states for the character
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self) // defining touch position
        
        // safe unwrapping button nodes
        guard let moveLeftButton = moveLeftButton else { return }
        guard let moveRightButton = moveRightButton else { return }
        guard let jumpButton = jumpButton else { return }
        guard let returnButton = returnButton else { return }
        
        
        
        if moveLeftButton.contains(touchLocation) { // if clicking left button
            
            state?.enter(MovingLeftState.self) // changing the player's state to match the button pressed
            player.xScale = -1 // making the player face the desired direction
            
        } else if moveRightButton.contains(touchLocation) { // if clicking right button
            
            state?.enter(MovingRightState.self) // changing the player's state to match the button pressed
            player.xScale = 1 // making the player face the desired direction
            
        } else if jumpButton.contains(touchLocation) { // if clicking the jump button
            state?.enter(JumpState.self) // changing the player's state to match the button pressed
            
        } else if returnButton.contains(touchLocation){ // if clicking the return button
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state?.enter(IdleState.self) // changing player character's state to idle when ending touch
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) { // on contact detection
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "player"{
            player.jumped = 1 // resetting the jump count so that the player can jump again
        }
    }
}
