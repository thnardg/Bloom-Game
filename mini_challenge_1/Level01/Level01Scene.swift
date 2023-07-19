//
//  Level01Scene.swift
//  mini_challenge_1
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import Foundation
import SpriteKit

class Level01Scene: SKScene {
    var character: SKSpriteNode!
    
    var moveLeftButton: SkButtonNode!
    var moveRightButton: SkButtonNode!
    var jumpButton: SkButtonNode!
    var returnButton: SkButtonNode!
    
    var isMovingLeft = false
    var isMovingRight = false
    var cameraNode: SKCameraNode!
    
    override func didMove(to view: SKView) {
        createMoveButtons()
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        
        character = childNode(withName: "player") as? SKSpriteNode
        
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
        character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let characterSpeed: CGFloat = 5.0
        
        if isMovingLeft {
            character.position.x -= characterSpeed
        } else if isMovingRight {
            character.position.x += characterSpeed
        }
        
        if let camera = cameraNode {
                camera.position = character.position
        }
        
        moveLeftButton.position.x = character.position.x - 300
        moveLeftButton.position.y = character.position.y - 100
        moveRightButton.position.x = character.position.x - 200
        moveRightButton.position.y = character.position.y - 100
        jumpButton.position.x = character.position.x  + 300
        jumpButton.position.y = character.position.y - 100
        returnButton.position.x = character.position.x - 0
        returnButton.position.y = character.position.y + 150
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if moveLeftButton.contains(touchLocation) {
            isMovingLeft = true
           
            character.xScale = -1
        } else if moveRightButton.contains(touchLocation) {
            isMovingRight = true
          
            character.xScale = 1
        } else if jumpButton.contains(touchLocation) {
            jumpCharacter()
            
        } else if returnButton.contains(touchLocation){
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if moveLeftButton.contains(touchLocation) {
            isMovingLeft = false
            character.removeAllActions()
            
        } else if moveRightButton.contains(touchLocation) {
            isMovingRight = false
            character.removeAllActions()
        }

    }
    
}
