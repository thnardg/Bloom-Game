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

        // Música intro:
        
        SoundDesign.shared.playBackgroundMusic(filename: "intro-music.mp3")
        
        
        
        
        let nome = SKLabelNode(text: NSLocalizedString("Name", comment: ""))
        let iniciar = SKLabelNode(text: NSLocalizedString("Start", comment: ""))
        nome.fontName = "UbuntuMono-Regular"
        nome.fontSize = 20
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
