
import Foundation
import GameplayKit
import SpriteKit

class PlayerNode: SKSpriteNode { // This is the class responsible for creating the character, it inherits from SKSpriteNode
    let key = "usr_checkpoint" //
    let keyJump = "usr_dbJump" // keys used for UserDefaults storage
    
    let textureSheet = [SKTexture(imageNamed: "im1"),
                        SKTexture(imageNamed: "im2"),
                        SKTexture(imageNamed: "im3"),
                        SKTexture(imageNamed: "im4"),
                        SKTexture(imageNamed: "im5"),
                        SKTexture(imageNamed: "im6"),
                        SKTexture(imageNamed: "im7"),
                        SKTexture(imageNamed: "im8")
    ] // Texture array for character walk animation
    let idleTextureSheet = [SKTexture(imageNamed: "Player_Idle_1"),
                            SKTexture(imageNamed: "Player_Idle_2"),
                            SKTexture(imageNamed: "Player_Idle_3"),
                            SKTexture(imageNamed: "Player_Idle_4"),
                            SKTexture(imageNamed: "Player_Idle_5"),
                            SKTexture(imageNamed: "Player_Idle_6"),
                            SKTexture(imageNamed: "Player_Idle_7"),
                            SKTexture(imageNamed: "Player_Idle_8"),
    ] // texture array for character idle anim
    let jumpTextureSheet = [SKTexture(imageNamed: "Player_jump_1"),
                            SKTexture(imageNamed: "Player_jump_2"),
                            SKTexture(imageNamed: "Player_jump_3"),
    ] // texture array for character jump anim
    let fallTextureSheet = SKTexture(imageNamed: "Player_jump_4") // texture for falling, which is "static"
    let landTextureSheet = [SKTexture(imageNamed: "Player_jump_5"),
                            SKTexture(imageNamed: "Player_jump_6"),
                            SKTexture(imageNamed: "Player_jump_7"),
                            SKTexture(imageNamed: "Player_jump_8"),
    ]  // texture array for character landing animation
    
    var jumpLimit: Int { // a jump limit for the character so that it can jump a limited number of times
        get{ // computer property for UserDefaults storing and retrieving information
            if UserDefaults.standard.integer(forKey: keyJump) == 0{
                return 1
            } else {
                return UserDefaults.standard.integer(forKey: keyJump)
            }
        }
        set{ // changed every time the variable changes
            UserDefaults.standard.set(newValue, forKey: keyJump)
        }
    }
    var jumped = 1 // number of times the player has jumped, reset when touching the ground
    var animationFrameTime = 2.0 // a common timeset for animations
    var playerCheckpoint: CGPoint? // the latest position where the player acquired a checkpoint
    {
        get{
            retrieve()
        }
        set{
            save(newValue ?? CGPoint(x: 0, y: 0))
        }
    }
    
    init() { // The class initializer
        let texture = SKTexture(imageNamed: "Player_Idle_4") // the main texture for the player
        let size = CGSize(width: 100, height: 100) // the character's size
        let speed = 5.0 // its speed
        super.init(texture: texture, color: .orange, size: size) // calling the superclass initializer
        self.speed = speed // setting the superclass speed variable to match the character's
        if self.jumpLimit == 0{ // making sure that the jump limit isn't 0
            self.jumpLimit = 1
        }
        
        
        configurePhysicsBody() // configurinmg the player's physics body
    }
    
    required init?(coder aDecoder: NSCoder) { // required init for the SKSpriteNode class
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: self.size) // definig a physics body with the player size
        body.isDynamic = true //
        body.affectedByGravity = true // setting its properties
        body.allowsRotation = false //
        
        body.mass = 0.222222238779068 // defining a constant mass so that despite the player's size it will still act as a standard
        
        body.categoryBitMask = 1 //
        body.collisionBitMask = 2 // defining contact and collision properties
        body.contactTestBitMask = 1 //
        
        physicsBody = body // attaching the body as the player's
        self.name = "player" // naming the player node
    }
    
    func save(_ CGPoint: CGPoint){ // func used to encode CGPoint info and store it in UserDefaults
        if let encodedData = try? JSONEncoder().encode(CGPoint) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func retrieve() -> CGPoint{ // func used to decode info from JSON located in UserDefs. and return its value
        if let data = UserDefaults.standard.data(forKey: key){
            guard let savedItems = try? JSONDecoder().decode(CGPoint.self, from: data) else {return CGPoint(x: 0, y: 0)}
            return savedItems
        }
        else {return CGPoint(x: 0, y: 0)}
        }
}
