//
//  CircleSliderScene.swift
//  spritekitanimation
//
//  Created by Thayna Rodrigues on 14/07/23.
//

import SpriteKit
import GameplayKit

class CircleSliderScene: SKScene {
    
    var slider: UISlider!
    var shapeNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        shapeNode = SKSpriteNode(imageNamed: "O")
        shapeNode.size = CGSize(width: 100, height: 100)
        shapeNode.addGlow()
        shapeNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(shapeNode)
        
        //Slider:
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        // Slider horizontal: slider.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 50)
        slider.center = CGPoint(x: view.frame.size.width - 60, y: view.frame.size.height / 2)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2) // Rotaciona o slider em 90º
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 55 // Meio do slider
        slider.isContinuous = true // Atualiza o valor enquanto o slider se move
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        view.addSubview(slider)
    }
    
    // Muda o tamanho da forma de acordo com o valor do slider
    @objc func sliderChanged(sender: UISlider) {
        let scale = CGFloat(sender.value / 50)
        shapeNode.setScale(scale)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let gameScene = SKScene(fileNamed: "GameScene")
        self.view?.presentScene(gameScene)
        slider.removeFromSuperview()
    }
}
