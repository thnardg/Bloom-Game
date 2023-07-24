//
//  SettingScene.swift
//  mini_challenge_1
//
//  Created by Jairo Júnior on 21/07/23.
//

import Foundation
import SpriteKit


class SettingScene: SKScene {
    
    var returnButton: SkButtonNode!
    var sfxButton: SkButtonNode!
    var musicButton: SkButtonNode!
    var resetButton: SkButtonNode!
    var informationButton: SkButtonNode!
    
    override func didMove(to view: SKView) {
        createButtons()
       
    }
    
    func createButtons(){
        
        //return Button
        returnButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Return")) // creating return button (returns to game start)
        
        returnButton.position = CGPoint(x: -350, y: 150)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        //sfx Button
        sfxButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "")) // creating return button (returns to game start)
        
        sfxButton.position = CGPoint(x: -250, y: 50)
        
        if let button = sfxButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let sfxText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 50, height: 100)), label: .init(text: "SFX"))
        
        sfxText.position = CGPoint(x: -200, y: 50)
        addChild(sfxText)
        
        
        //music Button
        musicButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "")) // creating return button (returns to game start)
        
        musicButton.position = CGPoint(x: 0, y: 50)
        
        if let button = musicButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let musicText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 50, height: 100)), label: .init(text: "Music"))
        
        musicText.position = CGPoint(x: 60, y: 50)
        addChild(musicText)
        
        
        //reset Button
        resetButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "")) // creating return button (returns to game start)
        
        resetButton.position = CGPoint(x: -250, y: -30)
        
        if let button = resetButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let resetText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 50, height: 50)), label: .init(text: "Reset History")) // creating return button (returns to game start)
        
        resetText.position = CGPoint(x: -153, y: -30)
        addChild(resetText)
        
        
        //
        informationButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 50, height: 50)), label: .init(text: "Info")) // creating return button (returns to game start)
        
        informationButton.position = CGPoint(x: 580, y: 250)
        
        if let button = informationButton{
            addChild(button) // adding return button to scene's node tree
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if returnButton.contains(touchLocation){ // if clicking the return button
            let gameScene = SKScene(fileNamed: "Level01Scene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }
    }
        
}
    
    
    
    
    

