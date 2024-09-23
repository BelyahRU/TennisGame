
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    
    func scheduleHeartSpawn(range: Range<Double>) {
        let randomTime = Double.random(in: range)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomTime) {
            self.run(SKAction.sequence([
                SKAction.run { [weak self] in
                    self?.spawnHeart()
                }
            ]))
        }
        
    }
    func spawnHeart() {
        let heartTexture = SKTexture(imageNamed: Resources.ItemImages.heart)
        heart = SKSpriteNode(texture: heartTexture, size: CGSize(width: 75, height: 75))
        
        setupHeartPosition()
        setupHeartPhysics()
        addChild(heart)
    }
    
    private func setupHeartPosition() {
        let minDistance: CGFloat = 30
        var isValidPosition = false
        
        var position = CGPoint.zero
        
        while !isValidPosition {
            
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height - 10)
            isValidPosition = isPositionValid(position, existingNodes: children.filter {
                $0.physicsBody?.categoryBitMask == ballCategory ||
                $0.physicsBody?.categoryBitMask == meteorCategory ||
                $0.physicsBody?.categoryBitMask == shieldCategory ||
                $0.physicsBody?.categoryBitMask == heartCategory ||
                $0.physicsBody?.categoryBitMask == starCategory
            }, minDistance: minDistance)
        }

        heart.position = position
    }
    
    private func setupHeartPhysics() {
        heart.physicsBody = SKPhysicsBody(circleOfRadius: heart.size.width / 2)
        heart.physicsBody?.categoryBitMask = heartCategory
        heart.physicsBody?.contactTestBitMask = racketCategory
        heart.physicsBody?.affectedByGravity = true
        heart.physicsBody?.collisionBitMask = 0
        heart.physicsBody?.restitution = 0.5
        heart.physicsBody?.linearDamping = 0.5
        heart.physicsBody?.velocity = CGVector(dx: 0, dy: -600)
//        heart.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))?
    }
}
