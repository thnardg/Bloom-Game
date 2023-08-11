
import SpriteKit

// Creates a glow effect to be applied at any skspritenode
extension SKSpriteNode {
    func addGlow(radius: Float) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        addChild(effectNode)
        let effect = SKSpriteNode(texture: texture)
        effect.color = .white
        effect.size = self.size
        effect.colorBlendFactor = 1
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
    
    
    
    func removeGlow() {
        for child in children {
            if let effectNode = child as? SKEffectNode {
                effectNode.removeFromParent()
            }
        }
    }
}


//create the storm effects
extension SKScene{
    func initialLIne(pointA: CGPoint, pointB: CGPoint) -> SKShapeNode { //initial line of the lightning
        let pathToDraw = CGMutablePath() //initial path of the line
        pathToDraw.move(to: pointA) //line A, that goes to line B
        pathToDraw.addLine(to: pointB) //line B
        let line = SKShapeNode() //linePaht
        line.path = pathToDraw
        line.glowWidth = 1
        line.strokeColor = .white //color of the line
        return line //returning the line to add to scene
    }
    
    
    
    func genrateLightningPath(startingFrom: CGPoint, angle: CGFloat, isBranch: Bool) -> [SKShapeNode] {
        var strikePath: [SKShapeNode] = [] //array of paths
        var startPoint = startingFrom
        var endPoint = startPoint
        let numberOfLines = isBranch ? 50 : 90 //limits of lines
        
        var idx = 0 
        while idx < numberOfLines {
            strikePath.append(initialLIne(pointA: startPoint, pointB: endPoint))
            startPoint = endPoint
            let r = CGFloat(10)
            endPoint.y -= r * cos(angle) + CGFloat.random(in: -10 ... 10)
            endPoint.x += r * sin(angle) + CGFloat.random(in: -10 ... 10)
            
            if Int.random(in: 0 ... 100) == 1 {
                let branchingStartPoint = endPoint
                
                let branchingAngle = CGFloat.random(in: -CGFloat.pi / 4 ... CGFloat.pi / 4) 
                
                strikePath.append(contentsOf: genrateLightningPath(startingFrom: branchingStartPoint, angle: branchingAngle, isBranch: true))
            }
            idx += 1
        }
        return strikePath
    }
    
    
    
    func lightningStrike(throughPath: [SKShapeNode], maxFlickeringTimes: Int) {
        let fadeTime = TimeInterval(CGFloat.random(in: 0.005 ... 0.03))
        let waitAction = SKAction.wait(forDuration: 0.05)
        let reduceAlphaAction = SKAction.fadeAlpha(to: 0.0, duration: fadeTime)
        let increaseAlphaAction = SKAction.fadeAlpha(to: 1.0, duration: fadeTime)
        let flickerSeq = [waitAction, reduceAlphaAction, increaseAlphaAction]
        
        var seq: [SKAction] = []
        let numberOfFlashes = Int.random(in: 1 ... maxFlickeringTimes)
        
        for _ in 1 ... numberOfFlashes {
            seq.append(contentsOf: flickerSeq)
        }
        for line in throughPath {
            seq.append(SKAction.fadeAlpha(to: 0, duration: 0.25))
            seq.append(SKAction.removeFromParent())
            line.run(SKAction.sequence(seq))
            self.addChild(line)
        }
    }
    
    
    
    func lightning(){
        let lightning = SKAudioNode(fileNamed: "thunder.mp3") // thunder sound effect
        let random = Int.random(in: -1 ... 1)
        let path = genrateLightningPath(startingFrom: CGPoint(x: player.position.x + CGFloat(random), y: (camera?.position.y ?? player.position.y) + 230), angle: CGFloat(100), isBranch: true )
        lightningStrike(throughPath: path, maxFlickeringTimes: 3)
        
        // adds the thunder sound effect
        self.addChild(lightning)
       
        
           let changeVolumeAction = SKAction.changeVolume(to: 0.2, duration: 0)

           lightning.run(changeVolumeAction)
    }
}


