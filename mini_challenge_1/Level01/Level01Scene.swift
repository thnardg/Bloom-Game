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

var isReturningToScene = false

class Level01Scene: SKScene, SKPhysicsContactDelegate { // first platformer level
    let onboardingKey = "usr_onboarding"
    
    // defining buttons
    var virtualController: GCVirtualController?
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    
    let thunder = SKAudioNode(fileNamed: "thunder.mp3") // Trovões
    
    var playerPosx: CGFloat = 0
    
    var isUsingJoystick = false
    
     let rainEmitter = SKEmitterNode(fileNamed: "Rain.sks")!
    
    var moveSpeed:Double = 0.0
    
    // defining level camera
    var cameraNode: SKCameraNode?
    
    var doubleJumpNode = DoubleJumpNode(CGPoint(x: 16824.793, y: 427.281))
    
    var canJump = true
    
    var notOnboarding: Bool{
            get{
                UserDefaults.standard.bool(forKey: onboardingKey)
            }
            set{
                UserDefaults.standard.setValue(newValue, forKey: onboardingKey)
            }
        }
    
    override func didMove(to view: SKView) { // loaded when reaching the level
        
        if isReturningToScene == false{
            if let playerCheckpoint = player.playerCheckpoint{
                player.position = playerCheckpoint
            }
        } else {
            isReturningToScene = false
        }
        
        //connectVirtualController()
        
        
        
        cameraNode = SKCameraNode() // defining custom camera as level camera
        
        cameraNode?.position = player.position
        if let camera = cameraNode{
            camera.name = "cameraNode"
            self.addChild(camera) // adding camera to scene
        }
        self.camera = cameraNode // defining custom camera as level camera
        
        createButtons()
        
        if !notOnboarding{
            onboarding()
        } else {
            connectVirtualController()
        }

        //to hide the jump button
        jumpButton.isHidden = true
        
        
        //adding rain to the scene
        rainEmitter.particlePositionRange.dx = self.frame.width * 3
        
        
        
        
        
        self.addChild(rainEmitter) //adding rain to scene
        self.addChild(player) // adding player to scene
        self.addChild(doubleJumpNode) // adding the node to scene
        self.addChild(checkpoint) // adding checkpoints to scene
        
        
        
        
        
        
        
        
        // Adicionar o efeito sonoro de trovão:
        
        self.addChild(thunder)
        /*
           let lightningAction = SKAction.run {
               self.lightning()
           }
         */
        
           let changeVolumeAction = SKAction.changeVolume(to: 0.2, duration: 0)
           let waitAction = SKAction.wait(forDuration: 25.0)
           let sequenceAction = SKAction.sequence([changeVolumeAction, /*lightningAction,*/ waitAction])
           let repeatAction = SKAction.repeatForever(sequenceAction)

           thunder.run(repeatAction)
        
        
        
    }
    
    func onboarding(){
        let onboarding = SKLabelNode(text: NSLocalizedString("Onboarding", comment: ""))
        onboarding.position = CGPoint(x: 0, y: frame.maxY - 80)
        onboarding.fontName = "Sora"
        onboarding.fontSize = 14
        onboarding.alpha = 0
        cameraNode?.addChild(onboarding)
        
        let waitAction = SKAction.wait(forDuration: 7)
        let fadeInOutAction = SKAction.sequence([.fadeIn(withDuration: 1), .wait(forDuration: 4), .fadeOut(withDuration: 1)])
        
        onboarding.run((.sequence([waitAction, fadeInOutAction])))
        
        setValueFalseForSomeSeconds() //calling the function that stops the player movimentation for 5 seconds
        
        //making the light animation
        let light = SKSpriteNode(imageNamed: "O2")
        light.size = CGSize(width: 50, height: 50)
        light.position = CGPoint(x: 50, y: -300)
        addChild(light)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: 750, y: 400), control: CGPoint(x: 500, y: -100))
        let moveAction1 = SKAction.moveBy(x: 50, y: -30, duration: 3)
        let moveAction = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 4)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction1, moveAction, remove])
        light.run(sequence)
    }
    
    
    // All Functions
    func setValueFalseForSomeSeconds() {//this function is for block the player to run or walk for 5 seconds
        //it is for the time to the ball goes out of the screen
            canJump = false //he cant jump too
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] timer in
                //after 5 seconds everything works like its to be
                self?.canJump = true
                self?.connectVirtualController()
            }
        }
        
    func createButtons(){
      
        returnButton = SkButtonNode(image: SKSpriteNode(imageNamed: "pause"), label: SKLabelNode()) // creating return button (returns to game start)
        returnButton.image?.size = CGSize(width: 30, height: 30)
        
        if let button = returnButton{
            button.position.x = player.position.x - 350
            button.position.y = player.position.y + 150
            addChild(button) // adding return button to scene's node tree
        }
        
        jumpButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 500, height: 500)), label: .init(text: "Up")) // creating jump button for the player character
        
        if let button = jumpButton{
            button.position.x = player.position.x + 280
            button.position.y = player.position.y
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
    
    func cameraBounds() {
        let leftBoundary = 63.308
        
        if let camera = cameraNode{
            if player.position.x < leftBoundary{
                cameraNode?.position.x = 63.308
                cameraNode?.position.y = player.position.y
                returnButton.position.x = -286.692
                returnButton.position.y = player.position.y + 150
                jumpButton.position = CGPoint(x: camera.position.x + 280 , y: camera.position.y - 50)
            } else {
                camera.run(.group([.moveTo(x: player.position.x, duration: 0.25), .moveTo(y: player.position.y, duration: 4)]))
                returnButton?.run(.group([.moveTo(x: player.position.x - 350, duration: 0.25), .moveTo(y: player.position.y + 150, duration: 4)]))
                jumpButton?.run(.group([.moveTo(x: player.position.x + 280, duration: 0.25), .moveTo(y: player.position.y, duration: 4)]))
            }
        }
    }
    
    //effects
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        /// Camera position setup
        cameraBounds()
        
        
        ///rain settings
        rainEmitter.position.x = camera?.position.x ?? player.position.x
        rainEmitter.position.y = (camera?.position.y ?? player.position.y) + 190
        
        /// Controller Settings
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value ?? 0))
        guard let controller = virtualController?.controller else {
           return
       }

       // Check if the player is using the virtual joystick
        let xAxisValue = CGFloat(controller.extendedGamepad?.leftThumbstick.xAxis.value ?? 0.0)
        moveSpeed = xAxisValue * player.speed
        

       let joystickThreshold: CGFloat = 0.1 // Define a threshold value to consider the joystick is being used

        
       // If the joystick values are beyond the threshold, consider the joystick is being used
       if abs(xAxisValue) > joystickThreshold{
           isUsingJoystick = true
//           player.removeAction(forKey: "idle")
//           player.run(.repeatForever(.sequence([.scale(to: 1.2, duration: 1), .scale(to: 0.8, duration: 1)])), withKey: "idle")
       } else {
           isUsingJoystick = false
//           player.scale(to: CGSize(width: 50, height: 100))
//           player.removeAction(forKey: "walk")
           player.run(.repeatForever(.animate(with: (player.textureSheet), timePerFrame: player.animationFrameTime / 1.5)), withKey: "walk")
           
           
       }
        
        /// Controller
       // If the joystick is being used, update the player's position
       if isUsingJoystick {
           let run = SKAction.run {
               player.position.x += self.moveSpeed
           }
           
           player.run(.sequence([.wait(forDuration: player.animationFrameTime), run]))
//           player.run(.repeatForever(.animate(with: (player.textureSheet), timePerFrame: player.animationFrameTime / 1.5)), withKey: "walk")
           
           if xAxisValue < 0{
               player.xScale = -1
//               print(isUsingJoystick)
           }
           if xAxisValue > 0{
               player.xScale = 1
           }
       } ///End of controller settings
        
        
        /// Double Jump removal if acquired
        if doubleJumpNode.hasAcquired {
            doubleJumpNode.removeFromParent()
        }
        
        
        /// Death
        if player.position.y < -1280 {
            let blackScreen = SKSpriteNode(color: .black, size: CGSize(width: 1334, height: 750)) // setting the black fade
            blackScreen.alpha = 0 // setting the alpha to 0 to allow fade in
            blackScreen.zPosition = 1 // putting it "on top" of the characeter
            player.addChild(blackScreen) // adding it as a child to player
            
            let fadeInBlack = SKAction.fadeIn(withDuration: 3)
            let fadeOutBlack = SKAction.fadeOut(withDuration: 3)
            let removeBlackScreen = SKAction.run{
                blackScreen.removeFromParent()
            }
            
            let respawn = SKAction.run { // defining the respawn action
                if let playerCheckpoint = player.playerCheckpoint{
                    player.position = playerCheckpoint
                    self.camera?.position = playerCheckpoint
                    player.physicsBody?.isResting = true
                } else {
                    player.position = CGPoint(x: 0, y: -200)
                    self.camera?.position = player.position
                    player.physicsBody?.isResting = true
                }
            }
            
            let fadeOutRemove = SKAction.sequence([fadeOutBlack, removeBlackScreen])
            
            blackScreen.run(.sequence([fadeInBlack, respawn, fadeOutRemove]))
        } /// End of Death settings
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self // setting the world physics
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if jumpButton.contains(touchLocation) {
            if canJump{
                jumpCharacter()
            }
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
        // Sort the node names alphabetically to create a unique identifier for the contact
        let nodeNames = [contact.bodyA.node?.name, contact.bodyB.node?.name].compactMap { $0 }.sorted()
        let contactIdentifier = "\(nodeNames[0])-\(nodeNames[1])"
        print(contactIdentifier)

        // Handle the unique contact events
        switch contactIdentifier {
        case "checkpoint-player":
            if checkpoint.locations.first == CGPoint(x: 556.577, y: -364.928){
                notOnboarding = true
                print("nao vai amis")
            }
            checkpoint.updateCheckpoint()
            checkpoint.removeFromParent()
            addChild(checkpoint)
        case "ground-player":
            player.jumped = 1
        case "doubleJump-player":
            doubleJumpNode.hasAcquired = true
            player.jumpLimit = 2
        default:
            break
        }
    }
}




