//
//  SettingScene.swift
//  mini_challenge_1
//
//  Created by Jairo Júnior on 21/07/23.
//

import Foundation
import SpriteKit


class SettingsScene: SKScene {
    var returnButton : SkButtonNode!
    
    
    override func didMove(to view: SKView) { // loaded when reaching the level
        CreateButtons()
        
    }
    
    func CreateButtons(){
        print("criando")
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "return"))
        
        returnButton.position = CGPoint(x: 0, y: 0)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
            print("foi")
        }
    }
}
