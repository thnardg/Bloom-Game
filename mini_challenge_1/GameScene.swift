//
//  GameScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 11/07/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tileMap: SKTileMapNode!
    var tileSet: SKTileSet!
    
    private var label: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        tileSet = SKTileSet()
        tileMap = SKTileMapNode(tileSet: tileSet, columns: 1, rows: 1, tileSize: CGSize(width: 336, height: 112))
        tileMap.position = CGPoint(x: 0, y: 0)
        addChild(tileMap)
        
        label = SKLabelNode(fontNamed: "Futura")
        label.text = "tela inicial"
        label.fontColor = SKColor.white
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(label)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let textScene = SKScene(fileNamed: "TextScene")
        self.view?.presentScene(textScene)
    }
}
