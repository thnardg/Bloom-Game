import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tileMap: SKTileMapNode!
    var tileSet: SKTileSet!
    
    override func didMove(to view: SKView) {
        // Música intro:
        SoundDesign.shared.playBackgroundMusic(filename: "intro-music.mp3")
        
        // Inicializador do tileset:
        tileSet = SKTileSet(named: "LevelTileSet")
        tileMap = SKTileMapNode(tileSet: tileSet, columns: 1, rows: 1, tileSize: CGSize(width: 100, height: 100))
        tileMap.position = CGPoint(x: 0, y: 0)
        addChild(tileMap)
        
        
        // Background:
        self.backgroundColor = .black
        let backgroundImage = SKSpriteNode(imageNamed: "bg.png")
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundImage.zPosition = -1
        // Aspect ratio do background:
        let widthScale = self.frame.width / backgroundImage.size.width
        let heightScale = self.frame.height / backgroundImage.size.height
        let scaleFactor = max(widthScale, heightScale)
        backgroundImage.setScale(scaleFactor)
        addChild(backgroundImage)
        
        // Bola de luz
        let circle = SKSpriteNode(imageNamed: "double_jumpbig") // Node da forma inicial
        circle.size = CGSize(width: 60, height: 60)
        circle.position = CGPoint(x: frame.midX, y: frame.midY + 70)
        circle.addGlow(radius: 5)
        addChild(circle)
        // Animação breathing:
        let scaleUp = SKAction.scale(to: 1.0, duration: 3.0)
        let scaleDown = SKAction.scale(to: 0.8, duration: 3.0)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        let repeatForever = SKAction.repeatForever(sequence)
        circle.run(repeatForever)

        // Logo:
        let bloomImage = SKSpriteNode(imageNamed: "logo")
        bloomImage.size = CGSize(width: 200, height: 120)
        bloomImage.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bloomImage)
        
        // Toque para iniciar:
        let iniciar = SKLabelNode(text: NSLocalizedString("Start", comment: ""))
        bloomImage.addChild(iniciar)
        iniciar.fontColor = SKColor.white
        iniciar.fontName = "Sora"
        iniciar.fontSize = 16
        iniciar.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 120)
        
        // Animação fade-in/out
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let sequenceAction = SKAction.sequence([fadeInAction, SKAction.wait(forDuration: 0.5), fadeOutAction])
        iniciar.run(SKAction.repeatForever(sequenceAction))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let headphoneScene = SKScene(fileNamed: "HeadphoneScene")
        self.view?.presentScene(headphoneScene)
    }
}
