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
    
    
    var isPopupOn = false
    var confirm: SkButtonNode!
    var cancel: SkButtonNode!
    var popupBackGround: SkButtonNode!
    var label:SkButtonNode!
    
    
    override func didMove(to view: SKView) {
        createButtons()
       
    }
    
    //all functions
    
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
        
        let sfxText = SKLabelNode(text: NSLocalizedString("SFX", comment: ""))
        sfxText.fontName = "Sora"
        sfxText.fontSize = 18
        sfxText.horizontalAlignmentMode = .left
        
        sfxText.position = CGPoint(x: sfxButton.position.x + 20, y: sfxButton.position.y - 10)
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
        

        let musicText = SKLabelNode(text: NSLocalizedString("Music", comment: ""))
        musicText.fontName = "Sora"
        musicText.fontSize = 18
        musicText.horizontalAlignmentMode = .left
        
        musicText.position = CGPoint(x: musicButton.position.x + 20, y: musicButton.position.y - 10)
        addChild(musicText)
        
        
        //reset Button
        resetButton = SkButtonNode(image: SKSpriteNode(imageNamed: "reset"), label: SKLabelNode()) // creating return button (returns to game start)
        
        resetButton.image?.size = CGSize(width: 30, height: 30)
        
        resetButton.position = CGPoint(x: -250, y: 20)
        
        if let button = resetButton{
            addChild(button) // adding return button to scene's node tree
        }
        

        let resetText = SKLabelNode(text: NSLocalizedString("Reset", comment: "")) // creating return button (returns to game start)
        resetText.fontName = "Sora"
        resetText.fontSize = 18
        resetText.horizontalAlignmentMode = .left
        
        resetText.position = CGPoint(x: resetButton.position.x + 20, y: resetButton.position.y - 10)
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
        
        let exitText = SKLabelNode(text: NSLocalizedString("Quit", comment: "")) // creating return button (returns to game start)
        exitText.fontName = "Sora"
        exitText.fontSize = 18
        exitText.horizontalAlignmentMode = .left
        
        exitText.position = CGPoint(x: exitButton.position.x + 20, y: exitButton.position.y - 10)
        addChild(exitText)
    }
    
    func createPopup(){
        popupBackGround = SkButtonNode(image: SKSpriteNode(imageNamed: "backgroundPopup"), label: SKLabelNode(text: NSLocalizedString("QuitConfirmation", comment: ""))) // creating return button (returns to game start)
        
        popupBackGround.image?.size = CGSize(width: 1334, height: 750)
        popupBackGround.position = CGPoint(x: 0, y: 0)
        popupBackGround.zPosition = 1
        popupBackGround.label?.position = CGPoint(x: 0, y: 40)
        self.addChild(popupBackGround)
        
        label = SkButtonNode(image: SKSpriteNode(imageNamed: "textPopup"), label: SKLabelNode(text: NSLocalizedString("Back", comment: "")))
        label.image?.position = CGPoint(x: 0, y: 50)
        label.image?.zPosition = 2
        label.image?.size = CGSize(width: 160, height: 18)
        label.label?.fontColor = .black
        label.label?.zPosition = 2
        label.label?.position = CGPoint(x: -50, y: -72)
        label.label?.fontSize = 18
        
        addChild(label)
        
        confirm = SkButtonNode(image: SKSpriteNode(imageNamed: "confirmPopup"), label: SKLabelNode(text: NSLocalizedString("QuitConfirmed", comment: "")))
        confirm.image?.size = CGSize(width: 80.51, height: 27.84)
        confirm.position = CGPoint(x: 80, y: -15)
        confirm.zPosition = 2
        confirm.label?.zPosition = 2
        confirm.label?.color = .white
        confirm.label?.position = CGPoint(x: 1, y: -7)
        confirm.label?.fontSize = 18
        addChild(confirm)
        
        cancel = SkButtonNode(image: SKSpriteNode(imageNamed: "cancelPopup"), label: SKLabelNode())
        cancel.image?.size = CGSize(width: 150, height: 28.84)
        cancel.position = CGPoint(x: -50, y: -15)
        cancel.zPosition = 2
        addChild(cancel)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        
        if isPopupOn == false{
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
                player.removeFromParent()
                checkpoint.locations = [
                    CGPoint(x: 556.577, y: -364.928),
                    CGPoint(x: 7575, y: -265.93),
                    CGPoint(x: 10077.53, y: -175.077),
                    CGPoint(x: 16824.793, y: 427.281)
                ]
                checkCount = 0
                UserDefaults.standard.set(checkCount, forKey: "check")
                checkpoint.position = checkpoint.locations.first!
                let gameScene = SKScene(fileNamed: "GameScene")
                player.xScale = 1
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

                
                createPopup()
                isPopupOn.toggle()
                
            }
            if returnButton.contains(touchLocation){ // if clicking the return button
                isReturningToScene = true
                checkpoint.removeFromParent()
                player.removeFromParent()
                let gameScene = SKScene(fileNamed: "Level01Scene")
                self.view?.presentScene(gameScene) // taking the player back to the start of the game
                
            }
            
            if informationButton.contains(touchLocation){
                let gameScene = SKScene(fileNamed: "InfoScene")
                self.view?.presentScene(gameScene)
                
            }
        }else{
            
            if confirm.contains(touchLocation){
                exit(0)
            }
            if cancel.contains(touchLocation){
                isPopupOn.toggle()
                popupBackGround.removeFromParent()
                label.removeFromParent()
                confirm.removeFromParent()
                cancel.removeFromParent()
            }
        }
    }
}

