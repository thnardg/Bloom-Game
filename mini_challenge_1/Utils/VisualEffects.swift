
import SpriteKit

// Cria um efeito de brilho para ser aplicado em qualquer SKSpriteNode.
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



extension SKScene{
    func createLine(pointA: CGPoint, pointB: CGPoint) -> SKShapeNode {
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: pointA)
        pathToDraw.addLine(to: pointB)
        let line = SKShapeNode()
        line.path = pathToDraw
        line.glowWidth = 1
        line.strokeColor = .white
        return line
    }
    func genrateLightningPath(startingFrom: CGPoint, angle: CGFloat, isBranch: Bool) -> [SKShapeNode] {
        var strikePath: [SKShapeNode] = []
        var startPoint = startingFrom
        var endPoint = startPoint
        let numberOfLines = isBranch ? 50 : 120
        
        var idx = 0
        while idx < numberOfLines {
            strikePath.append(createLine(pointA: startPoint, pointB: endPoint))
            startPoint = endPoint
            let r = CGFloat(10)
            endPoint.y -= r * cos(angle) + CGFloat.random(in: -10 ... 10)
            endPoint.x += r * sin(angle) + CGFloat.random(in: -10 ... 10)
            
            if Int.random(in: 0 ... 100) == 1 {
                let branchingStartPoint = endPoint
                
                let branchingAngle = CGFloat.random(in: -CGFloat.pi / 4 ... CGFloat.pi / 4) // the angle to make the branching look natural
                
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
    
    
    
    func flashTheScreen(nTimes: Int) {
        let lightUpScreenAction = SKAction.run { self.backgroundColor = UIColor.gray }
        let waitAction = SKAction.wait(forDuration: 0.05)
        let dimScreenAction = SKAction.run { self.backgroundColor = .darkGray}
        
        var flashActionSeq: [SKAction] = []
        for _ in 1 ... nTimes + 1 {
            flashActionSeq.append(contentsOf: [lightUpScreenAction, waitAction, dimScreenAction, waitAction])
        }
        self.run(SKAction.sequence(flashActionSeq))
    }
    
    func lightning(){
        let random = Int.random(in: -1 ... 1)
        let path = genrateLightningPath(startingFrom: CGPoint(x: player.position.x + CGFloat(random), y: player.position.y + 100), angle: CGFloat(100), isBranch: true )
        lightningStrike(throughPath: path, maxFlickeringTimes: 3)
        
        flashTheScreen(nTimes: 4)
        print("poooooow")
    }
}
