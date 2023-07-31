
import Foundation
import GameplayKit
import SpriteKit

var player = PlayerNode()

class PlayerNode: SKSpriteNode {
    let key = "usr_checkpoint"
    let keyJump = "usr_dbJump"
    
    let textureSheet = [SKTexture(imageNamed: "im1"),
                        SKTexture(imageNamed: "im2"),
                        SKTexture(imageNamed: "im3"),
                        SKTexture(imageNamed: "im4"),
                        SKTexture(imageNamed: "im5"),
                        SKTexture(imageNamed: "im6"),
                        SKTexture(imageNamed: "im7"),
                        SKTexture(imageNamed: "im8")
    ]
    let idleTextureSheet = [SKTexture(imageNamed: "Player_Idle_1"),
                            SKTexture(imageNamed: "Player_Idle_2"),
                            SKTexture(imageNamed: "Player_Idle_3"),
                            SKTexture(imageNamed: "Player_Idle_4"),
                            SKTexture(imageNamed: "Player_Idle_5"),
                            SKTexture(imageNamed: "Player_Idle_6"),
                            SKTexture(imageNamed: "Player_Idle_7"),
                            SKTexture(imageNamed: "Player_Idle_8"),
    ]
    let jumpTextureSheet = [SKTexture(imageNamed: "Player_jump_1"),
                            SKTexture(imageNamed: "Player_jump_2"),
                            SKTexture(imageNamed: "Player_jump_3"),
    ]
    let fallTextureSheet = SKTexture(imageNamed: "Player_jump_4")
    let landTextureSheet = [SKTexture(imageNamed: "Player_jump_5"),
                            SKTexture(imageNamed: "Player_jump_6"),
                            SKTexture(imageNamed: "Player_jump_7"),
                            SKTexture(imageNamed: "Player_jump_8"),
    ]
    
    var jumpLimit: Int {
        get{
            if UserDefaults.standard.integer(forKey: keyJump) == 0{
                return 1
            } else {
                return UserDefaults.standard.integer(forKey: keyJump)
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: keyJump)
        }
    }
    var jumped = 1
    var animationFrameTime = 2.0
    var playerCheckpoint: CGPoint?
    {
        get{
            retrieve()
        }
        set{
            save(newValue ?? CGPoint(x: 0, y: 0))
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "Player_Idle_4")
        let size = CGSize(width: 100, height: 100)
        let speed = 5.0
        super.init(texture: texture, color: .orange, size: size)
        self.speed = speed
        if self.jumpLimit == 0{
            self.jumpLimit = 1
        }
        
        
        configurePhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.isDynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        
        body.mass = 0.222222238779068
        
        body.categoryBitMask = 1
        body.collisionBitMask = 2
        body.contactTestBitMask = 1
        
        physicsBody = body
        name = "player"
    }
    
    func save(_ CGPoint: CGPoint){
        if let encodedData = try? JSONEncoder().encode(CGPoint) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func retrieve() -> CGPoint{
        if let data = UserDefaults.standard.data(forKey: key){
            guard let savedItems = try? JSONDecoder().decode(CGPoint.self, from: data) else {return CGPoint(x: 0, y: 0)}
            return savedItems
        }
        else {return CGPoint(x: 0, y: 0)}
        }
}
