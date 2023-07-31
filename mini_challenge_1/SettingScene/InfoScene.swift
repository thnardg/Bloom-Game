//
//  InfoScene.swift
//  mini_challenge_1
//
//  Created by Jairo Júnior on 24/07/23.
//

import Foundation
import SpriteKit



class InfoScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        criarTelaDeCreditos()
    }
    
    func criarTelaDeCreditos() {
        // Texto dos créditos
        let textoCreditos = NSLocalizedString("Credits", comment: "")
        
        // Crie o nó de texto
        let labelNode = SKLabelNode(fontNamed: "Sora")
        labelNode.text = textoCreditos
        labelNode.fontSize = 15
        labelNode.fontColor = SKColor.white
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .top
        labelNode.numberOfLines = 0
        labelNode.preferredMaxLayoutWidth = size.width - 40 // Largura máxima para quebrar o texto
        labelNode.position = CGPoint(x: 0, y: frame.minY) // Posicione o texto abaixo da tela

        addChild(labelNode)
        
        // Defina a ação de movimento para fazer os créditos subirem
        let subir = SKAction.moveBy(x: 0, y: size.height + labelNode.frame.size.height, duration: 10)
        print(labelNode.frame.size.height)
        
        // Defina uma ação para remover os créditos da cena quando eles saírem da tela
        let remover = SKAction.removeFromParent()
        
        let voltar = SKAction.run {
            let introTextScene = SKScene(fileNamed: "SettingScene")
            self.view?.presentScene(introTextScene)
        }
        
        // Crie uma sequência de ações para primeiro subir e depois remover os créditos
        let sequencia = SKAction.sequence([subir, remover, voltar])
        
        // Execute a sequência de ações nos créditos
        labelNode.run(sequencia)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let introTextScene = SKScene(fileNamed: "SettingScene")
        self.view?.presentScene(introTextScene)
        
    }
}
