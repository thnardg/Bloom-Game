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
    var languageButton: SkButtonNode!
    var exitButton: SkButtonNode!
    
    
    override func didMove(to view: SKView) {
        createButtons()
       
    }
    
    func createButtons(){
        
        //return Button


        returnButton = SkButtonNode(image: SKSpriteNode(imageNamed: "return"), label: SKLabelNode()) // creating return button (returns to game start)

        returnButton.image?.size = CGSize(width: 30, height: 30)
        
        returnButton.position = CGPoint(x: -350, y: 150)
        
        if let button = returnButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        
        //sfx Button
        if sfx{
            sfxButton = SkButtonNode(image: SKSpriteNode(imageNamed: "sfxOn"), label: SKLabelNode()) // creating return button (returns to game start)
        }else{
            sfxButton = SkButtonNode(image: SKSpriteNode(imageNamed: "sfxOff"), label: SKLabelNode()) // creating return button (returns to game start)
        }
           
        sfxButton.image?.size = CGSize(width: 30, height: 30)
        
        sfxButton.position = CGPoint(x: -250, y: 100)
        
        if let button = sfxButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let sfxText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 100)), label: .init(text: NSLocalizedString("SFX", comment: "")))
        
        sfxText.position = CGPoint(x: -190, y: 100)
        addChild(sfxText)
        
        
        //music Button
        if musicIsOn{
            musicButton = SkButtonNode(image: SKSpriteNode(imageNamed: "musicOn"), label: SKLabelNode()) // creating return button (returns to game start)
        }else{
            musicButton = SkButtonNode(image: SKSpriteNode(imageNamed: "musicOff"), label: SKLabelNode()) // creating return button (returns to game start)
        }
        musicButton.image?.size = CGSize(width: 30, height: 30)
        musicButton.position = CGPoint(x: -50, y: 100)
        
        if let button = musicButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        let musicText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 100)), label: .init(text: NSLocalizedString("Music", comment: "")))

        
        musicText.position = CGPoint(x: 7, y: 100)
        addChild(musicText)
        
        
        //reset Button
        resetButton = SkButtonNode(image: SKSpriteNode(imageNamed: "reset"), label: SKLabelNode()) // creating return button (returns to game start)
        
        resetButton.image?.size = CGSize(width: 30, height: 30)
        
        resetButton.position = CGPoint(x: -250, y: 20)
        
        if let button = resetButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        let resetText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 25)), label: .init(text: NSLocalizedString("Reset", comment: ""))) // creating return button (returns to game start)

        
        resetText.position = CGPoint(x: -151, y: 20)
        addChild(resetText)
        
        

        informationButton = SkButtonNode(image: SKSpriteNode(imageNamed: "info"), label: SKLabelNode()) // creating return button (returns to game start)
        
        informationButton.image?.size = CGSize(width: 30, height: 30)
        
        informationButton.position = CGPoint(x: 350, y: 150)
        
        if let button = informationButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        exitButton = SkButtonNode(image: SKSpriteNode(imageNamed: "exit"), label: SKLabelNode()) // creating return button (returns to game start)
            
        exitButton.image?.size = CGSize(width: 30, height: 30)
        
        exitButton.position = CGPoint(x: -250, y: -60)
        
        if let button = exitButton{
            addChild(button) // adding return button to scene's node tree
        }
        
        let exitText = SkButtonNode(image: .init(color: .clear, size: CGSize(width: 25, height: 25)), label: .init(text: NSLocalizedString("Sair do Jogo", comment: ""))) // creating return button (returns to game start)

        
        exitText.position = CGPoint(x: -160, y: -60)
        addChild(exitText)
    }
    
    
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        

        if musicButton.contains(touchLocation){
            musicIsOn.toggle()
     
            
            if musicIsOn == true{
                musicButton.removeFromParent()
                sfxButton.removeFromParent()
                createButtons()
                SoundDesign.shared.unmuteMusic()
                
            }else{
                musicButton.removeFromParent()
                sfxButton.removeFromParent()
                createButtons()
                SoundDesign.shared.muteMusic()
            }
        }
        
        if resetButton.contains(touchLocation){

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
            checkpoint.position = checkpoint.locations.first!
//            Level01Scene.addChild(checkpoint)
            let gameScene = SKScene(fileNamed: "GameScene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game

        }
        
        if sfxButton.contains(touchLocation){
            sfx.toggle()
        
            if sfx == true{
                musicButton.removeFromParent()
                sfxButton.removeFromParent()
                createButtons()
                SoundDesign.shared.unmuteSoundEffet()
            }else{
                musicButton.removeFromParent()
                sfxButton.removeFromParent()
                createButtons()
                SoundDesign.shared.muteSoundEffect()
            }
        }
        
        if exitButton.contains(touchLocation){// if clicking the return menu button
            exit(0)
        }
        if returnButton.contains(touchLocation){ // if clicking the return button
            isReturningToScene = true
            let gameScene = SKScene(fileNamed: "Level01Scene")
               self.view?.presentScene(gameScene) // taking the player back to the start of the game
            
        }

        if informationButton.contains(touchLocation){
            let gameScene = SKScene(fileNamed: "InfoScene")
            self.view?.presentScene(gameScene)
            
        }
    }
    
    
    ///
    ///
    ///
    ///
    ///
    ///
        
    override func update(_ currentTime: TimeInterval) {
//        if sfx{
//            sfxButton.removeFromParent()
//            createButtons()
//        }else{
//            sfxButton.removeFromParent()
//            createButtons()
//        }
        
        
        
        
    }
}
    
    
    
