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
    var returnMenuButton: SkButtonNode!
    
    
    override func didMove(to view: SKView) {
        createButtons()
       
    }
    
    func createButtons(){
        
        //return Button

        returnButton = SkButtonNode(image: SKSpriteNode(imageNamed: "pause"), label: SKLabelNode()) // creating return button (returns to game start)
        returnButton.image?.size = CGSize(width: 30, height: 30)
        
        returnButton.position = CGPoint(x: -350, y: 150)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        //sfx Button
        sfxButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 25, height: 25)), label: .init(text: "")) // creating return button (returns to game start)
        
        sfxButton.position = CGPoint(x: -250, y: 50)
        
        if let button = sfxButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let sfxText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 100)), label: .init(text: "SFX"))
        
        sfxText.position = CGPoint(x: -200, y: 50)
        addChild(sfxText)
        
        
        //music Button
        musicButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 25, height: 25)), label: .init(text: "")) // creating return button (returns to game start)
        
        musicButton.position = CGPoint(x: 0, y: 50)
        
        if let button = musicButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        let musicText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 100)), label: .init(text: "Música"))

        
        musicText.position = CGPoint(x: 60, y: 50)
        addChild(musicText)
        
        
        //reset Button
        resetButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 25, height: 25)), label: .init(text: "")) // creating return button (returns to game start)
        
        resetButton.position = CGPoint(x: -250, y: -30)
        
        if let button = resetButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        let resetText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 25)), label: .init(text: "Resetar Jogo")) // creating return button (returns to game start)

        
        resetText.position = CGPoint(x: -153, y: -30)
        addChild(resetText)
        
        

        informationButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 25, height: 25)), label: .init(text: "Informações")) // creating return button (returns to game start)

        
        informationButton.position = CGPoint(x: 350, y: 150)
        
        if let button = informationButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        returnMenuButton = SkButtonNode(image: .init(color: .blue, size: CGSize(width: 25, height: 25)), label: .init(text: "Menu Principal")) // creating return button (returns to game start)

        
        returnMenuButton.position = CGPoint(x: -350, y: -150)
        
        if let button = returnMenuButton{
            addChild(button) // adding return button to scene's node tree
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        

        if musicButton.contains(touchLocation){
            musicIsOn.toggle()
     
            print("apertou my friend")
            print(musicIsOn)
            
            if musicIsOn == true{
                SoundDesign.shared.playBackgroundMusic(filename: "medo.mp3")
            }else{
                SoundDesign.shared.stopBackgroundMusic()
            }
        }
        
        if resetButton.contains(touchLocation){
            UserDefaults.resetDefaults()
            alreadyPlayed.toggle()
        }
        
        if sfxButton.contains(touchLocation){
            sfx.toggle()
        
            if sfx == true{
                SoundDesign.shared.playSoundEffect(filename: "storm.mp3")
            }else{
                SoundDesign.shared.stopSoundEffect()
            }
        }
        
        if returnMenuButton.contains(touchLocation){// if clicking the return menu button
            SoundDesign.shared.stopBackgroundMusic()
            SoundDesign.shared.stopSoundEffect()

            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }
        if returnButton.contains(touchLocation){ // if clicking the return button
            let gameScene = SKScene(fileNamed: "Level01Scene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
        }

        if informationButton.contains(touchLocation){
            let gameScene = SKScene(fileNamed: "InfoScene")
            self.view?.presentScene(gameScene)
        }
    }
        
}
    
    
    
    
    

