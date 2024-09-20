
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    
    func scheduleStarSpawn(range: Range<Double>) {
        let randomTime = Double.random(in: range)
        DispatchQueue.main.async {
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: randomTime),
                SKAction.run { [weak self] in
                    self?.spawnStar()
                }
            ]))
        }
    }
    
    private func spawnStar() {
        let starTexture = SKTexture(imageNamed: Resources.ItemImages.star)
        
        star = SKSpriteNode(texture: starTexture, size: CGSize(width: 75, height: 75))
        setupStarPosition()
        setupStarPhysics()
        addChild(star)
    }
    
    private func setupStarPosition() {
        let minDistance: CGFloat = 30
        var isValidPosition = false
        
        var position = CGPoint.zero
        
        while !isValidPosition {
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 50)
            isValidPosition = isPositionValid(position, existingNodes: children.filter {
                $0.physicsBody?.categoryBitMask == ballCategory ||
                $0.physicsBody?.categoryBitMask == meteorCategory ||
                $0.physicsBody?.categoryBitMask == shieldCategory ||
                $0.physicsBody?.categoryBitMask == heartCategory ||
                $0.physicsBody?.categoryBitMask == starCategory 
            }, minDistance: minDistance)
        }

        star.position = position
    }
    
    private func setupStarPhysics() {
        star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
        star.physicsBody?.categoryBitMask = starCategory
        star.physicsBody?.contactTestBitMask = racketCategory
        star.physicsBody?.affectedByGravity = true
        star.physicsBody?.collisionBitMask = 0
        star.physicsBody?.restitution = 0.5
        star.physicsBody?.linearDamping = 0.5
//        shield.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))?
    }
}
