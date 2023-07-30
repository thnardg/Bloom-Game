import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tileMap: SKTileMapNode!
    var tileSet: SKTileSet!
        
    override func didMove(to view: SKView) {
        
        tileSet = SKTileSet(named: "LevelTileSet")
        tileMap = SKTileMapNode(tileSet: tileSet, columns: 1, rows: 1, tileSize: CGSize(width: 100, height: 100))
        tileMap.position = CGPoint(x: 0, y: 0)
        addChild(tileMap)
        
        self.backgroundColor = .black

        let circle = SKSpriteNode(imageNamed: "double_jumpbig") // Node da forma inicial
        circle.size = CGSize(width: 30, height: 30)
        circle.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        circle.addGlow(radius: 5)
        addChild(circle)
        
        // Animação breathing:
        let scaleUp = SKAction.scale(to: 1.0, duration: 3.5)
        let scaleDown = SKAction.scale(to: 0.5, duration: 3.5)
        let wait = SKAction.wait(forDuration: 1.0)
        let sequence = SKAction.sequence([scaleDown, scaleUp, scaleDown, scaleUp, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        circle.run(repeatForever)
        
        let backgroundImage = SKSpriteNode(imageNamed: "Menu_fundox4.png")
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundImage.zPosition = -1
        
        // Calculate scale factor to fit the screen while maintaining the aspect ratio
        let widthScale = self.frame.width / backgroundImage.size.width
        let heightScale = self.frame.height / backgroundImage.size.height
        let scaleFactor = max(widthScale, heightScale)
        
        // Apply the scale factor to the background image
        backgroundImage.setScale(scaleFactor)
        
        addChild(backgroundImage)
        
        // Música intro:
        SoundDesign.shared.playBackgroundMusic(filename: "intro-music.mp3")
        
        
        let nome = SKLabelNode(text: NSLocalizedString("Name", comment: ""))
        let iniciar = SKLabelNode(text: NSLocalizedString("Start", comment: ""))
        nome.fontName = "UbuntuMono-Regular"
        nome.fontSize = 25
        nome.fontColor = SKColor.white
        nome.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(nome)
        nome.addChild(iniciar)
        iniciar.fontColor = SKColor.white
        iniciar.fontName = "Sora"
        iniciar.fontSize = 16
        iniciar.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 60)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let sequenceAction = SKAction.sequence([fadeInAction, SKAction.wait(forDuration: 0.5), fadeOutAction])
        
        // Animação:
        iniciar.run(SKAction.repeatForever(sequenceAction))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let headphoneScene = SKScene(fileNamed: "HeadphoneScene")
        self.view?.presentScene(headphoneScene)
    }
}
