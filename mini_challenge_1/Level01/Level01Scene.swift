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
var checkCount = UserDefaults.standard.integer(forKey: "check")

class Level01Scene: SKScene, SKPhysicsContactDelegate { // first platformer level
    let onboardingKey = "usr_onboarding"
    
    // defining buttons
    var virtualController: GCVirtualController?
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    
    var playerPosx: CGFloat = 0
    
    var isUsingJoystick = false
    
     let rainEmitter = SKEmitterNode(fileNamed: "Rain.sks")!
    
    var moveSpeed:Double = 0.0
    
    // defining level camera
    var cameraNode: SKCameraNode?
    
    var doubleJumpNode = DoubleJumpNode(CGPoint(x: 16824.793, y: 427.281))
    
    var canTouch = true
    
    var notOnboarding: Bool{
        get{
            UserDefaults.standard.bool(forKey: onboardingKey)
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: onboardingKey)
        }
    }
    
    var nextLevel = NextLevel(CGPoint(x: 18574.99, y: 2134.626))

    //Pedras Flutuantes 01
    let rock1 = SKSpriteNode(imageNamed: "rock1")
    let rock2 = SKSpriteNode(imageNamed: "rock2")
    let rock3 = SKSpriteNode(imageNamed: "rock1")
    let rock4 = SKSpriteNode(imageNamed: "rock2")
    let rock5 = SKSpriteNode(imageNamed: "rock1")
    let rock5_1 = SKSpriteNode(imageNamed: "rock2")
    let rock6 = SKSpriteNode(imageNamed: "rock2")
    let rock6_1 = SKSpriteNode(imageNamed: "rock1")
    let rock7 = SKSpriteNode(imageNamed: "rock1")
    let rock8 = SKSpriteNode(imageNamed: "rock2")
    
    //Pedras Flutuantes 02
    let stone1 = SKSpriteNode(imageNamed: "stone1")
    let stone2 = SKSpriteNode(imageNamed: "stone2")
    let stone3 = SKSpriteNode(imageNamed: "stone1")
    let stone4 = SKSpriteNode(imageNamed: "stone2")
    let stone5 = SKSpriteNode(imageNamed: "stone1")
    let stone6 = SKSpriteNode(imageNamed: "stone2")
    let stone7 = SKSpriteNode(imageNamed: "stone1")
    
    //Montanhas
    let mount1 = SKSpriteNode(imageNamed: "mount1")
    let mount2 = SKSpriteNode(imageNamed: "mount2")
    let mount3 = SKSpriteNode(imageNamed: "mount1")
    
    let parallaxSpeed1x: CGFloat = 0.8
    let parallaxSpeed2x: CGFloat = 0.9
    let parallaxSpeed3x: CGFloat = 0.98
    
    let parallaxSpeed1y: CGFloat = 0.6
    let parallaxSpeed2y: CGFloat = 0.8
    let parallaxSpeed3y: CGFloat = 1.0

    
    
    
    // All Functions
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
    
    func firstMove(){
        let move = SKAction.moveTo(x: 150, duration: 17)
        let moveAction = SKAction.run{
            let movePlayer = SKAction.repeatForever(.animate(with: player.textureSheet, timePerFrame: 0.4))
            player.run(movePlayer)
            if let moveAction = player.action(forKey: "walk"){
                moveAction.speed = self.moveSpeed
            }
        }
        let playerRemoveAction = SKAction.run {
            self.moveSpeed = 0
            player.removeAllActions()
            self.stopWalkingAnimation()
            self.idleAnimation()
        }
        player.run(.sequence([
            .group([move, moveAction]), playerRemoveAction]), withKey: "sequence")
        
    }
    
    func setValueFalseForSomeSeconds() {//this function is for block the player to run or walk for 5 seconds
        //it is for the time to the ball goes out of the screen
            canTouch = false //he cant jump too
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] timer in
                //after 5 seconds everything works like its to be
                self?.canTouch = true
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
        let jump = SKAction.animate(with: player.jumpTextureSheet, timePerFrame: player.animationFrameTime / 6)
        let fall = SKAction.animate(with: [player.fallTextureSheet], timePerFrame: player.animationFrameTime / 6)
        
        let height = (player.size.height * 0.88) * 2
        
        if player.jumped <= player.jumpLimit {
            if player.jumped == 2{
                player.physicsBody?.isResting = true
            }
            player.removeAllActions()
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: height))
            player.jumped += 1
            player.run(.sequence([jump, .repeatForever(fall)]), withKey: "jump")
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
                camera.run(.group([.moveTo(x: player.position.x, duration: 0.25), .moveTo(y: player.position.y, duration: 0.5)]))
                returnButton?.run(.group([.moveTo(x: player.position.x - 350, duration: 0.25), .moveTo(y: player.position.y + 150, duration: 0.5)]))
                jumpButton?.run(.group([.moveTo(x: player.position.x + 280, duration: 0.25), .moveTo(y: player.position.y, duration: 0.5)]))
            }
        }
    }
    
    func getDoubleJump(){
            doubleJumpNode.hasAcquired = true
            player.jumpLimit = 2
            let label = SKLabelNode(text: NSLocalizedString("DJump", comment: ""))
            label.position = CGPoint(x: 16824.793, y: 470)
            label.fontName = "Sora"
            label.fontSize = 14
            label.alpha = 0
            let labelBg = SKSpriteNode(texture: SKTexture(imageNamed: "LabelBg"))
            labelBg.size = CGSize(width: label.frame.size.width + 20, height: label.frame.size.height + 10)
            labelBg.position = CGPoint(x: label.position.x, y: 475)
            labelBg.zPosition = -1
            labelBg.alpha = 0
            
            self.addChild(labelBg)
            self.addChild(label)
            
            let fadeInOutAction = SKAction.sequence([.fadeIn(withDuration: 1), .wait(forDuration: 4), .fadeOut(withDuration: 1)])
            
            label.run(fadeInOutAction)
            labelBg.run(fadeInOutAction)
            
        }
    
    func startWalkingAnimation() {
        player.removeAction(forKey: "idle")
        // Check if the walk animation is already running
        if player.action(forKey: "walk") == nil && player.action(forKey: "jump") == nil{
            // Create the animation action and run it once
            let moveAction = SKAction.repeatForever(.animate(with: player.textureSheet, timePerFrame: 2.0))
            moveAction.speed = 0
            player.run(moveAction, withKey: "walk")
        }
    }

    func stopWalkingAnimation() {
        player.removeAction(forKey: "walk")
        player.texture = SKTexture(imageNamed: "Player_Idle_4")
    }
    
    func idleAnimation(){
        stopWalkingAnimation()
        if player.action(forKey: "idle") == nil && player.action(forKey: "jump") == nil{
            // Create the animation action and run it once
            let idleAction = SKAction.repeatForever(.animate(with: player.idleTextureSheet, timePerFrame: 0.5))
            player.run(idleAction, withKey: "idle")
        }
    }

    func updatePlayerPosition() {

        // Update the player's facing direction based on moveSpeed
        if self.moveSpeed < 0 {
            player.xScale = -1
        } else if self.moveSpeed > 0 {
            player.xScale = 1
        }
        
        // Update the player's position based on the movement speed
        if moveSpeed < 0{
            player.position.x -= (moveSpeed * -1)
        } else {
            player.position.x += self.moveSpeed
        }
    }
    
    func prepareToGoToNextScene(){
        SoundDesign.shared.stopSoundEffect()
        SoundDesign.shared.stopBackgroundMusic()
        UserDefaults.resetDefaults()
        checkpoint.removeFromParent()
        checkpoint.locations = [
            CGPoint(x: 556.577, y: -364.928),
            CGPoint(x: 7575, y: -265.93),
            CGPoint(x: 10077.53, y: -175.077),
            CGPoint(x: 16824.793, y: 427.281)
        ]
        virtualController?.disconnect()
        checkpoint.position = checkpoint.locations.first!
        player.removeFromParent()
        checkCount = 0
        UserDefaults.standard.set(checkCount, forKey: "check")
        
        let gameScene = SKScene(fileNamed: "EndingTextScene")
           self.view?.presentScene(gameScene) // taking the player to the next scene
    }
    
    func die(){
        let blackScreen = SKSpriteNode(color: .black, size: CGSize(width: 1334, height: 750)) // setting the black fade
        blackScreen.alpha = 0 // setting the alpha to 0 to allow fade in
        blackScreen.zPosition = 1 // putting it "on top" of the characeter
        cameraNode?.addChild(blackScreen) // adding it as a child to player
        
        let fadeInBlack = SKAction.fadeIn(withDuration: 0.5)
        let fadeOutBlack = SKAction.fadeOut(withDuration: 0.5)
        let removeBlackScreen = SKAction.run{
            blackScreen.removeFromParent()
        }
        
        let respawn = SKAction.run { // defining the respawn action
            if let playerCheckpoint = player.playerCheckpoint{
                player.position = playerCheckpoint
                self.cameraNode?.removeAllActions()
                self.returnButton.removeAllActions()
                self.returnButton.position = CGPoint(x: player.position.x - 350, y: player.position.y + 150)
                self.camera?.position = playerCheckpoint
                player.physicsBody?.isResting = true
            }
        }
        
        let fadeOutRemove = SKAction.sequence([fadeOutBlack, removeBlackScreen])
        
        blackScreen.run(.sequence([fadeInBlack, respawn, fadeOutRemove]))
    }
    
    func setControllerInputHandler(){
        if controllerInstance.physController.extendedGamepad?.valueChangedHandler == nil && canTouch{
            controllerInstance.physController.extendedGamepad?.valueChangedHandler = {
                (gamepad: GCExtendedGamepad, element: GCControllerElement) in
                if gamepad.leftThumbstick.xAxis.value != 0{
                    self.moveSpeed = Double(gamepad.leftThumbstick.xAxis.value) * player.speed
                    self.isUsingJoystick = true
                }
                if gamepad.buttonA.isPressed {
                    self.jumpCharacter()
                }
                if gamepad.leftThumbstick.xAxis.value == 0 {
                    self.moveSpeed = 0
                    self.isUsingJoystick = false
                }
            }
        }
    }
    
    //main Functions
    override func didMove(to view: SKView) { // loaded when reaching the level
        
        if isReturningToScene == false{
            if let playerCheckpoint = player.playerCheckpoint{
                player.position = playerCheckpoint
                if playerCheckpoint == CGPoint(x: 0, y: 0){
                    player.position = CGPoint(x: -300, y: -414)
                    firstMove()
                }
            }
        } else {
            isReturningToScene = false
        }
        
        
        
        
        
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
        self.addChild(nextLevel) // adding next level light
        
        //Adcionando as pedras na scene
        self.addChild(rock1)
        self.addChild(rock2)
        self.addChild(rock3)
        self.addChild(rock4)
        self.addChild(rock5)
        self.addChild(rock5_1)
        self.addChild(rock6)
        self.addChild(rock6_1)
        self.addChild(rock7)
        self.addChild(rock8)
        
        self.addChild(stone1)
        self.addChild(stone2)
        self.addChild(stone3)
        self.addChild(stone4)
        self.addChild(stone5)
        self.addChild(stone6)
        self.addChild(stone7)
        
        self.addChild(mount1)
        self.addChild(mount2)
        self.addChild(mount3)
        
        //Configurando o tamanho das pedras
        rock1.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 1)
        rock2.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 0.8)
        rock3.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 1)
        rock4.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 0.8)
        rock5.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 1)
        rock5_1.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 0.8)
        rock6.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 0.8)
        rock6_1.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 1)
        rock7.size = CGSize(width: frame.size.width / 3, height: frame.size.height / 1)
        rock8.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 0.8)
        
        stone1.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone2.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone3.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone4.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone5.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone6.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        stone7.size = CGSize(width: frame.size.width / 6, height: frame.size.height / 3)
        
        mount1.size = CGSize(width: frame.size.width / 1.4, height: frame.size.height / 1.4)
        mount2.size = CGSize(width: frame.size.width / 1.4, height: frame.size.height / 1.4)
        mount3.size = CGSize(width: frame.size.width / 1.4, height: frame.size.height / 1.4)
        
        //Configurando a poisção do Z
        rock1.zPosition = -1
        rock2.zPosition = -1
        rock3.zPosition = -1
        rock4.zPosition = -1
        rock5.zPosition = -1
        rock5_1.zPosition = -1
        rock6.zPosition = -1
        rock6_1.zPosition = -1
        rock7.zPosition = -1
        rock8.zPosition = -1
        
        stone1.zPosition = -2
        stone2.zPosition = -2
        stone3.zPosition = -2
        stone4.zPosition = -2
        stone5.zPosition = -2
        stone6.zPosition = -2
        stone7.zPosition = -2
        
        mount1.zPosition = -3
        mount2.zPosition = -3
        mount3.zPosition = -3
        
    }
    
    override func update(_ currentTime: TimeInterval) { // func that updates the game scene at each frame
        /// Camera position setup
        cameraBounds()
        
        ///rain settings
        rainEmitter.position.x = camera?.position.x ?? player.position.x
        rainEmitter.position.y = (camera?.position.y ?? player.position.y) + 190
        
        /// Controller Settings
        
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value ?? 0))
        
        if let controller = virtualController?.controller {
            // getting the joystick x value
             let xAxisValue = CGFloat(controller.extendedGamepad?.leftThumbstick.xAxis.value ?? 0.0)
            moveSpeed = xAxisValue * player.speed //calculating the speed
            
            // If the joystick values are beyond the threshold, consider the joystick is being used
            if abs(xAxisValue) != 0{
                isUsingJoystick = true
            } else {
                isUsingJoystick = false
            }
        }
        
        updatePlayerPosition() //applying the speed to the player

        if let moveAction = player.action(forKey: "walk"){
            if moveSpeed < 0{
                moveAction.speed = (moveSpeed * -1)
            } else {
                moveAction.speed = moveSpeed
            }
            }
        
        if GCController.controllers().count > 1{
            virtualController?.disconnect()
            jumpButton.position = CGPoint(x: 0, y: -1000)
            jumpButton.removeFromParent()
        }
        controllerInstance.updateController()
        setControllerInputHandler()
        
        if GCController.controllers().isEmpty{
            virtualController?.connect()
            if jumpButton.isChild(of: self) == false{
                self.addChild(jumpButton)
            }
        }
        
        /// Controller
       // If the joystick is being used, update the player's position
       if isUsingJoystick {
           startWalkingAnimation()
       } else {
           idleAnimation()
       } ///End of controller settings
        
        
        /// Double Jump removal if acquired
        if doubleJumpNode.hasAcquired {
            let action = SKAction.run {
                self.doubleJumpNode.removeFromParent()
            }
            if doubleJumpNode.hasAcquired{
                self.doubleJumpNode.removeFromParent()
            } else {
                doubleJumpNode.run(.sequence([.fadeOut(withDuration: 0.5), action]))
            }
        }
        
        
        /// Death
        if player.position.y < -1280 {
            die()
        } /// End of Death settings
        
        //Variavel atualizando e armazenando a posição da camera
        let cameraXPosition = cameraNode!.position.x
        let cameraYPosition = cameraNode!.position.y
        
        //Configurando a posição das pedras de acordo com o eixo X da camera
        rock1.position.x = cameraXPosition * parallaxSpeed1x - 300
        rock2.position.x = cameraXPosition * parallaxSpeed1x + 500
        rock3.position.x = cameraXPosition * parallaxSpeed1x + 1300
        rock4.position.x = cameraXPosition * parallaxSpeed1x + 2100
        rock5.position.x = cameraXPosition * parallaxSpeed1x + 2900
        rock5_1.position.x = cameraXPosition * parallaxSpeed1x + 3000
        rock6.position.x = cameraXPosition * parallaxSpeed1x + 3700
        rock6_1.position.x = cameraXPosition * parallaxSpeed1x + 3800
        rock7.position.x = cameraXPosition * parallaxSpeed1x + 4500
        rock8.position.x = cameraXPosition * parallaxSpeed1x + 5300
        
        stone1.position.x = cameraXPosition * parallaxSpeed2x + 500
        stone2.position.x = cameraXPosition * parallaxSpeed2x + 1200
        stone3.position.x = cameraXPosition * parallaxSpeed2x + 2000
        stone4.position.x = cameraXPosition * parallaxSpeed2x + 2800
        stone5.position.x = cameraXPosition * parallaxSpeed2x + 3600
        stone6.position.x = cameraXPosition * parallaxSpeed2x + 4400
        stone7.position.x = cameraXPosition * parallaxSpeed2x + 5200
        
        mount1.position.x = cameraXPosition * parallaxSpeed3x - 200
        mount2.position.x = cameraXPosition * parallaxSpeed3x + 100
        mount3.position.x = cameraXPosition * parallaxSpeed3x + 400
        
        //Configurando a posição das pedras de acordo com o eixo Y da camera
        rock1.position.y = cameraYPosition * parallaxSpeed1y - 250
        rock2.position.y = cameraYPosition * parallaxSpeed1y - 300
        rock3.position.y = cameraYPosition * parallaxSpeed1y - 100
        rock4.position.y = cameraYPosition * parallaxSpeed1y + 50
        rock5.position.y = cameraYPosition * parallaxSpeed1y + 150
        rock5_1.position.y = cameraYPosition * parallaxSpeed1y + 800
        rock6.position.y = cameraYPosition * parallaxSpeed1y + 150
        rock6_1.position.y = cameraYPosition * parallaxSpeed1y + 800
        rock7.position.y = cameraYPosition * parallaxSpeed1y + 50
        rock8.position.y = cameraYPosition * parallaxSpeed1y + 150
        
        stone1.position.y = cameraYPosition * parallaxSpeed2y - 150
        stone2.position.y = cameraYPosition * parallaxSpeed2y
        stone3.position.y = cameraYPosition * parallaxSpeed2y + 150
        stone4.position.y = cameraYPosition * parallaxSpeed2y + 150
        stone5.position.y = cameraYPosition * parallaxSpeed2y + 150
        stone6.position.y = cameraYPosition * parallaxSpeed2y + 150
        stone7.position.y = cameraYPosition * parallaxSpeed2y + 150
       
        mount1.position.y = cameraYPosition * parallaxSpeed3y - 70
        mount2.position.y = cameraYPosition * parallaxSpeed3y - 70
        mount3.position.y = cameraYPosition * parallaxSpeed3y - 70
        
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self // setting the world physics
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if jumpButton.contains(touchLocation) {
            if canTouch{
                jumpCharacter()
            }
        }
        
        else if returnButton.contains(touchLocation){ // if clicking the return button
            if canTouch{
                let gameScene = SKScene(fileNamed: "SettingScene")
                self.view?.presentScene(gameScene) // taking the player back to the start of the game
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerPosx = CGFloat(0)
    }
    
    func didBegin(_ contact: SKPhysicsContact) { // on contact detection
        // Sort the node names alphabetically to create a unique identifier for the contact
        let nodeNames = [contact.bodyA.node?.name, contact.bodyB.node?.name].compactMap { $0 }.sorted()
        let contactIdentifier = "\(nodeNames[0])-\(nodeNames[1])"

        // Handle the unique contact events
        switch contactIdentifier {
        case "checkpoint-player":
            
            if checkpoint.locations.first == CGPoint(x: 556.577, y: -364.928){
                notOnboarding = true
            }
            checkpoint.updateCheckpoint()
            checkpoint.removeFromParent()
            
            lightning()
            checkCount += 1
            UserDefaults.standard.set(checkCount, forKey: "check")
            
            if checkCount >= 4{
                checkpoint.removeFromParent()
            }else{
                addChild(checkpoint)
            }
            
        case "ground-player":
            player.jumped = 1
            if player.action(forKey: "jump") != nil {
                player.removeAllActions()
                player.run(.animate(with: player.landTextureSheet, timePerFrame: player.animationFrameTime / 6), withKey: "jump")
        }
        case "doubleJump-player":
            getDoubleJump()
            checkpoint.removeFromParent()
        case "nextLevel-player":
            prepareToGoToNextScene()
            player.xScale = 1
        default:
            break
        }
    }
    
}




