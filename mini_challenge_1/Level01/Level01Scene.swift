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
        createButtons()
        
        
        
        cameraNode = SKCameraNode() // defining custom camera as level camera
        self.camera = cameraNode // defining custom camera as level camera
        if let camera = cameraNode{
            addChild(camera) // adding camera to scene
        }
        self.addChild(player) // adding player to scene
        
        
        
        //to hide the joystick
        jumpButton.isHidden = true
        
    }
    
    
    
    
    func createButtons(){
      
        returnButton = SkButtonNode(image: SKSpriteNode(imageNamed: "pause"), label: SKLabelNode()) // creating return button (returns to game start)
        
        returnButton.image?.size = CGSize(width: 30, height: 30)
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
      
        let moveSpeed = xAxisValue * player.speed
        

       let joystickThreshold: CGFloat = 0.1 // Define a threshold value to consider the joystick is being used

       // If the joystick values are beyond the threshold, consider the joystick is being used
       if abs(xAxisValue) > joystickThreshold{
           isUsingJoystick = true
           
       } else {
           isUsingJoystick = false
           player.run(.repeatForever(.animate(with: (player.textureSheet), timePerFrame: player.animationFrameTime)))
       }
        
       // If the joystick is being used, update the player's position
       if isUsingJoystick {
           
           let run = SKAction.run {
               player.position.x += moveSpeed
           }
           player.run(.sequence([.wait(forDuration: player.animationFrameTime), run]))
           
           
           
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
            returnButton?.position.x = camera.position.x - 350
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
            let gameScene = SKScene(fileNamed: "SettingScene")
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



/*
class Level01Scene: SKScene, SKPhysicsContactDelegate { // first platformer level
    // defining buttons
   
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    

    let joystickBack = SKSpriteNode(imageNamed: "JoyBack")
    let joystickButton = SKSpriteNode(imageNamed: "JoyButton")
    
    //to know when it's being used
    var joystickInUse = false
    
    //to calculate the velocity X and Y though
    var velocityX: CGFloat = 0.0
    var velocityY: CGFloat = 0.0
    
    var joystickTouch: UITouch? // Optional UITouch to store the initial joystick touch
  
    //var hud = Hud()
    
    // defining level camera
    var cameraNode: SKCameraNode?
    
    

    override func didMove(to view: SKView) { // loaded when reaching the level
        
        
        
        cameraNode = SKCameraNode() // defining custom camera as level camera
        self.camera = cameraNode // defining custom camera as level camera
        if let camera = cameraNode{
            addChild(camera) // adding camera to scene
        }
        self.addChild(player) // adding player to scene
        
        
        createButtons()
        //to hide the joystick
        joystickBack.isHidden = false
        joystickButton.isHidden = false
        jumpButton?.isHidden = true
        
        //adding them to the view
        self.addChild(joystickBack)
        self.addChild(joystickButton)
        
        
        
        
    }
    
    func touchMoved(touch: UITouch) {
        //get the location of the touch
        let location = touch.location(in: self)
        
        //if joystick is in use we can calculate the scope between the initial touch and final touch
        if joystickInUse {
            //get the vector of the Joystick label to not let the Joystick Button out of the scope
            let vector = CGVector(dx: location.x - joystickBack.position.x, dy: location.y - joystickBack.position.y)
            
            //calculating the angle of the joystickBack
            let angle = atan2(vector.dy, vector.dx)
            
            //distance of the angle from the center of the joystickback
            let distanceFromCenter = CGFloat(joystickBack.frame.size.height/2)
            
            //calculating the distance from the center
            let distanceX = CGFloat(sin(angle - distanceFromCenter))
            let distanceY = CGFloat(cos(angle - distanceFromCenter))
            
            //adding the joystick button at the point we calculated that the user touched
            if joystickBack.frame.contains(location) {
                joystickButton.position = location
            } else {
                //if out of bounds, it gets back to the center of the joystickBack
                joystickButton.position = CGPoint(x: joystickBack.position.x - distanceX, y: joystickBack.position.y - distanceY)
            }
            
            //telling the velocity we want to put according to the point of the joystickButton is inside the JoystickBack
            //velocityX = (joystickButton.position.x - joystickBack.position.x) / 25
            velocityX = (joystickButton.position.x - joystickBack.position.x)/20
            //velocityY = (joystickButton.position.y - joystickBack.position.y) / 5
        }
    }
    func movementOver() {
        //knowing the joystickBack position center
        let moveBack = SKAction.move(to: CGPoint(x: joystickBack.position.x, y: joystickBack.position.y), duration: TimeInterval(floatLiteral: 0.1))
        
        //adding animation while returning back to the center
        moveBack.timingMode = .linear
        
        //moving to the center and letting the velocity and joystickInUse to the initial stage
        joystickButton.run(moveBack)
        velocityX = 0
        velocityY = 0
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
    
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        ///
        ///
        
        
        // updating the position of the player according to the joystick
        player.position.x += velocityX
        
        
        //to change the face side of the player according to the joystick and movimentation
        if velocityX < 0 {
            player.xScale = -1
            
            
        }
        if velocityX > 0 {
            player.xScale = 1
            
        }
       

        if let camera = cameraNode{ // safe unwrapping the camera node
            camera.run(.group([.moveTo(x: player.position.x, duration: 0.25), .moveTo(y: player.position.y, duration: 0)]))
            
            
            jumpButton?.position.x = camera.position.x  + 280
            jumpButton?.position.y = player.position.y - 50
            returnButton?.position.x = camera.position.x - 0
            returnButton?.position.y = player.position.y + 150
            
            
            joystickBack.position.x = camera.position.x - 200
            joystickBack.position.y = player.position.y - 80
            joystickButton.position.x = camera.position.x - 200
            joystickButton.position.y = player.position.y - 80
            
          
            
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self // setting the world physics
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //getting location and putting the joystick at this location
            let location = touch.location(in: self)
            
            // Verificar se o toque inicial está dentro do joystickButton e não temos nenhum joystickTouch em andamento
            if joystickButton.frame.contains(location)  {
                joystickTouch = touch
                joystickInUse = true
            }
        }
        // safe unwrapping button nodes
        
        guard let jumpButton = jumpButton else { return }
        guard let returnButton = returnButton else { return }
        //see the first touche
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
    let zerar = UITouch()
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if var joystickTouch = joystickTouch, touch == joystickTouch {
                joystickTouch = zerar
                movementOver()
                joystickInUse = false
            }
        }
        guard let touch = touches.first else { return }
        
       
        
        //returning to false when u touch out the button and the player will stop to run
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let joystickTouch = joystickTouch, touch == joystickTouch {
                touchMoved(touch: touch)
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if var joystickTouch = joystickTouch, touch == joystickTouch {
                joystickTouch = zerar
                movementOver()
                joystickInUse = false
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) { // on contact detection
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "player"{
            player.jumped = 1 // resetting the jump count so that the player can jump again
        }
    }
}
*/
