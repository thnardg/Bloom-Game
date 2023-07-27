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
            let textoCreditos = """
            
               [NOME DO JOGO]

                iOS Developers:
            
                  -  Enrique Carvalho
                  -  Jairo Pereira
                  -  Lucas Nascimento
                  -  Thayná Rodrigues

            
                Designer:
            
                  -  Maria Clara Guimarães
            
            
                Esse jogo foi desenvolvido como atividade no Apple Developer
                Academy / UCB, sob mentoria de Antônio Santos e Felipe Carvalho
                e Coordenação de Jair Barbosa.
            
            
                -
                        
            """

            // Crie o nó de texto
            let labelNode = SKLabelNode(fontNamed: "Sora")
            labelNode.text = textoCreditos
            labelNode.fontSize = 15
            labelNode.fontColor = SKColor.white
            labelNode.horizontalAlignmentMode = .center
            labelNode.verticalAlignmentMode = .top
            labelNode.numberOfLines = 0
            labelNode.preferredMaxLayoutWidth = size.width - 40 // Largura máxima para quebrar o texto
            labelNode.position = CGPoint(x: size.width / 2, y: size.height) // Posicione o texto abaixo da tela
        labelNode.position = CGPoint(x: 0, y: 0)
            addChild(labelNode)

            // Defina a ação de movimento para fazer os créditos subirem
            let subir = SKAction.moveBy(x: 0, y: size.height + labelNode.frame.size.height, duration: 30)

            // Defina uma ação para remover os créditos da cena quando eles saírem da tela
            let remover = SKAction.removeFromParent()

            // Crie uma sequência de ações para primeiro subir e depois remover os créditos
            let sequencia = SKAction.sequence([subir, remover])

            // Execute a sequência de ações nos créditos
            labelNode.run(sequencia)
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let introTextScene = SKScene(fileNamed: "SettingScene")
        self.view?.presentScene(introTextScene)
        
    }
}
