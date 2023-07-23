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
import GameController



class Level01Scene: SKScene, SKPhysicsContactDelegate { // first platformer level
    // defining buttons
    var virtualController: GCVirtualController?
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    var playerPosx: CGFloat = 0
    
    var isUsingJoystick = false
    
    // defining level camera
    var cameraNode: SKCameraNode?
    
    override func didMove(to view: SKView) { // loaded when reaching the level
        
        connectVirtualController()
        cameraNode = SKCameraNode() // defining custom camera as level camera
        self.camera = cameraNode // defining custom camera as level camera
        if let camera = cameraNode{
            addChild(camera) // adding camera to scene
        }
        self.addChild(player) // adding player to scene
        
        
        createButtons()
        //to hide the joystick
        jumpButton.isHidden = true
    }
    
    
    
    
    func createButtons(){
      
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "return")) // creating return button (returns to game start)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        jumpButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 500, height: 500)), label: .init(text: "Up")) // creating jump button for the player character
        
        if let button = jumpButton{
            addChild(button) // adding it to the scene's node tree
        }
        
    }
    
    func jumpCharacter() {
        //player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        
        let height = (player.size.height * 0.88) * 2
        
        if player.jumped <= player.jumpLimit {
            if player.jumped == 2{
                player.physicsBody?.isResting = true
            }
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: height))
            player.jumped += 1
        }
    }
    
    func connectVirtualController(){
        let controlerConfig = GCVirtualController.Configuration()
        controlerConfig.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controlerConfig)
        controller.connect()
        virtualController = controller
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        
      
        guard let controller = virtualController?.controller else {
           return
       }
        

       // Check if the player is using the virtual joystick
       let xAxisValue = CGFloat(controller.extendedGamepad?.leftThumbstick.xAxis.value ?? 0.0)

       let joystickThreshold: CGFloat = 0.1 // Define a threshold value to consider the joystick is being used

       // If the joystick values are beyond the threshold, consider the joystick is being used
       if abs(xAxisValue) > joystickThreshold{
           isUsingJoystick = true
       } else {
           isUsingJoystick = false
       }

       // If the joystick is being used, update the player's position
       if isUsingJoystick {
           let moveSpeed: CGFloat = 5.0 // Player movement speed
           player.position.x += xAxisValue * moveSpeed
           
           if xAxisValue < 0{
               player.xScale = -1
           }
           if xAxisValue > 0{
               player.xScale = 1
           }
           
       }
        

        if let camera = cameraNode{ // safe unwrapping the camera node
            camera.run(.group([.moveTo(x: player.position.x, duration: 0.25), .moveTo(y: player.position.y, duration: 0)]))
            
            
            jumpButton?.position.x = camera.position.x  + 280
            jumpButton?.position.y = player.position.y - 50
            returnButton?.position.x = camera.position.x - 0
            returnButton?.position.y = player.position.y + 150
            
            
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self // setting the world physics
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        
        
        let touchLocation = touch.location(in: self)
        
        if jumpButton.contains(touchLocation) {
            jumpCharacter()
        }
        
        else if returnButton.contains(touchLocation){ // if clicking the return button
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerPosx = CGFloat(0)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) { // on contact detection
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "player"{
            player.jumped = 1 // resetting the jump count so that the player can jump again
        }
    }
}
