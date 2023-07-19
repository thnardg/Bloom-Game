//
//  Level01Scene.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import Foundation
import SpriteKit
import GameplayKit

class Level01Scene: GameScene, SKPhysicsContactDelegate {
    var moveLeftButton: SkButtonNode!
    var moveRightButton: SkButtonNode!
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    
    var isMovingLeft = false
    var isMovingRight = false
    var cameraNode: SKCameraNode!
    
    
    var state: GKStateMachine?
    
    override func didMove(to view: SKView) {
        createMoveButtons()
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        self.addChild(player)
        
//        character = childNode(withName: "player") as? SKSpriteNode
        
    }
    
    func createMoveButtons() {
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "return"))
       
        addChild(returnButton)
        
        
        jumpButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Up"))
       
        addChild(jumpButton)
        
        moveLeftButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Left"))
        addChild(moveLeftButton)
        
        moveRightButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Right"))
        addChild(moveRightButton)
    }
    
    func jumpCharacter() {
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
//        let characterSpeed: CGFloat = 5.0
//
//        if isMovingLeft {
//            character.position.x -= characterSpeed
//        } else if isMovingRight {
//            character.position.x += characterSpeed
//        }
        state?.update(deltaTime: currentTime)
        
        if let camera = cameraNode {
                camera.position = player.position
        }
        
        moveLeftButton.position.x = player.position.x - 300
        moveLeftButton.position.y = player.position.y - 100
        moveRightButton.position.x = player.position.x - 200
        moveRightButton.position.y = player.position.y - 100
        jumpButton.position.x = player.position.x  + 300
        jumpButton.position.y = player.position.y - 100
        returnButton.position.x = player.position.x - 0
        returnButton.position.y = player.position.y + 150
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
        
        state = GKStateMachine(states: [DeadState(gameScene: self), IdleState(gameScene: self), JumpState(gameScene: self), MovingLeftState(gameScene: self), MovingRightState(gameScene: self)])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if moveLeftButton.contains(touchLocation) { // if clicking left button
            
            state?.enter(MovingLeftState.self)
            player.xScale = -1
            
        } else if moveRightButton.contains(touchLocation) { // if clicking right button
            
            state?.enter(MovingRightState.self)
            player.xScale = 1
            
        } else if jumpButton.contains(touchLocation) {
            state?.enter(JumpState.self)
//            jumpCharacter()
            
        } else if returnButton.contains(touchLocation){
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        state?.enter(IdleState.self)
        
//        if moveLeftButton.contains(touchLocation) {
//            isMovingLeft = false
//            player.removeAllActions()
//
//        } else if moveRightButton.contains(touchLocation) {
//            isMovingRight = false
//            player.removeAllActions()
//        }

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "player"{
            player.jumped = 0
        }
    }
    
}
