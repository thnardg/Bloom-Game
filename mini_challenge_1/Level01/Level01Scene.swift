//
//  Level01Scene.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//
import UIKit

import Foundation
import SpriteKit
import GameplayKit

class Level01Scene: GameScene, SKPhysicsContactDelegate { // first platformer level
    // defining buttons
   
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    var moveLeftButton: SkButtonNode!
    var moveRightButton: SkButtonNode!
    var isMovingLeft = false
    var isMovingRight = false
    
 
    
    // defining level camera
    var cameraNode: SKCameraNode?

    override func didMove(to view: SKView) { // loaded when reaching the level
        createButtons()
        
        cameraNode = SKCameraNode() // defining custom camera as level camera
        self.camera = cameraNode // defining custom camera as level camera
        if let camera = cameraNode{
            addChild(camera) // adding camera to scene
        }
        self.addChild(player) // adding player to scene
        

    }
    
   

    
    func createButtons(){
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "return")) // creating return button (returns to game start)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        jumpButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Up")) // creating jump button for the player character
        
        if let button = jumpButton{
            addChild(button) // adding it to the scene's node tree
            
        }
        moveLeftButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Left"))
        
        if let button = moveLeftButton{
            addChild(button) // adding it to the scene's node tree
            
        }
        
        moveRightButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Right"))
        if let button = moveRightButton{
            addChild(button) // adding it to the scene's node tree
            
        }
        
    }
    
    func jumpCharacter() {
        //player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        let direction = (player.xScale == -1 ? (player.speed ) * -10 : (player.speed ) * 10)
        let height = (player.size.height * 0.88) * 2
        
        if player.jumped <= player.jumpLimit {
            if player.jumped == 2{
                player.physicsBody?.isResting = true
            }
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: height))
            player.jumped += 1
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        
        //adding the speed that the player will run/walk
        let characterSpeed: CGFloat = 5.0
        
        if isMovingLeft {
            player.position.x -= characterSpeed
        } else if isMovingRight {
            player.position.x += characterSpeed
        }
        

        if let camera = cameraNode{ // safe unwrapping the camera node
            camera.run(.group([.moveTo(x: player.position.x, duration: 0.25), .moveTo(y: player.position.y, duration: 0)]))
            
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
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // safe unwrapping button nodes
        guard let moveLeftButton = moveLeftButton else { return }
        guard let moveRightButton = moveRightButton else { return }
        guard let jumpButton = jumpButton else { return }
        guard let returnButton = returnButton else { return }
        //see the first touche
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        //moving player buttons being activated to move/jump/return to the first scene
        if moveLeftButton.contains(touchLocation) {
            isMovingLeft = true
            player.xScale = -1
            
        } else if moveRightButton.contains(touchLocation) {
            isMovingRight = true
            player.xScale = 1
            
        } else if jumpButton.contains(touchLocation) {
            jumpCharacter()
        }
        
        else if returnButton.contains(touchLocation){ // if clicking the return button
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        //returning to false when u touch out the button and the player will stop to run
        if moveLeftButton.contains(touchLocation) {
            isMovingLeft = false
            
        } else if moveRightButton.contains(touchLocation) {
            isMovingRight = false
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) { // on contact detection
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "player"{
            player.jumped = 1 // resetting the jump count so that the player can jump again
        }
    }
}
