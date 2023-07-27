////
////  BotoesMovimentacao.swift
////  mini_challenge_1
////
////  Created by Jairo Júnior on 21/07/23.
////
//
//import Foundation
//import SpriteKit
//
//
//class BotoesMovimentacao:GameScene{
//    var moveLeftButton: SkButtonNode!
//    var moveRightButton: SkButtonNode!
//    var isMovingLeft = false
//    var isMovingRight = false
//
//    func criar(){
//        moveLeftButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Left"))
//
//        if let button = moveLeftButton{
//            addChild(button) // adding it to the scene's node tree
//
//        }
//
//        moveRightButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Right"))
//        if let button = moveRightButton{
//            addChild(button) // adding it to the scene's node tree
//        }
//    }
//
//
//    override func update(_ currentTime: TimeInterval) {
//        let characterSpeed: CGFloat = 5.0
//        if isMovingLeft {
//            player.position.x -= characterSpeed
//        } else if isMovingRight {
//            player.position.x += characterSpeed
//        }
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let touchLocation = touch.location(in: self)
//
//        //moving player buttons being activated to move/jump/return to the first scene
//        if moveLeftButton.contains(touchLocation) {
//            isMovingLeft = true
//            player.xScale = -1
//
//        } else if moveRightButton.contains(touchLocation) {
//            isMovingRight = true
//            player.xScale = 1
//
//        }
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let touchLocation = touch.location(in: self)
//
//        if moveLeftButton.contains(touchLocation) {
//            isMovingLeft = false
//
//        } else if moveRightButton.contains(touchLocation) {
//            isMovingRight = false
//
//        }
//    }
//
//
//}
