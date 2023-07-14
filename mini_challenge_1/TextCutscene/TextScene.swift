//
//  TextScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 13/07/23.
//
import SpriteKit
import GameplayKit

class TextScene: SKScene {
    
        private var label: SKLabelNode!
        var lastPhrase = false
        
        override func didMove(to view: SKView) {

            label = SKLabelNode(fontNamed: "Futura")
            label.text = "Você é um grão flutuando no espaço. No vazio você vê uma luz. O que ela quer te dizer?" // Separar os textos em outro arquivo
            label.fontColor = SKColor.white
            label.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(label)
            fadeLabelIn()
        }
        
        // Cria um efeito de fade in no texto depois de 1 segundo de tela preta
        private func fadeLabelIn() {
            label.alpha = 0
            let waitAction = SKAction.wait(forDuration: 1)
            let fadeInAction = SKAction.fadeIn(withDuration: 5.0)
            let fadeSequence = SKAction.sequence([waitAction, fadeInAction])
            label.run(fadeSequence)
        }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if lastPhrase == true {
            let circleGlowScene = SKScene(fileNamed: "CircleGlowScene")
            self.view?.presentScene(circleGlowScene)
        }
    }
}

