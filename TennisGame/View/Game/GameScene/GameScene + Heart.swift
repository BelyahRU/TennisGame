
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    
    func scheduleHeartSpawn(range: Range<Double>) {
        let randomTime = Double.random(in: range)
        DispatchQueue.main.async {
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: randomTime),
                SKAction.run { [weak self] in
                    self?.spawnHeart()
                }
            ]))
        }
        
    }
    func spawnHeart() {

        let heartTexture = SKTexture(imageNamed: Resources.HeartImage.heart)
        heart = SKSpriteNode(texture: heartTexture, size: CGSize(width: 74, height: 75))
        
        let minDistance: CGFloat = 30
        var isValidPosition = false
        
        var position = CGPoint.zero
        
        while !isValidPosition {
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 5)
            isValidPosition = isPositionValid(position, existingNodes: children.filter {
                $0.physicsBody?.categoryBitMask == ballCategory || $0.physicsBody?.categoryBitMask == meteorCategory
            }, minDistance: minDistance)
        }

        heart.position = position
        heart.physicsBody = SKPhysicsBody(circleOfRadius: heart.size.width / 2)
        heart.physicsBody?.categoryBitMask = heartCategory
        heart.physicsBody?.contactTestBitMask = racketCategory
        heart.physicsBody?.affectedByGravity = true
        heart.physicsBody?.collisionBitMask = 0
        heart.physicsBody?.restitution = 0.5
        heart.physicsBody?.linearDamping = 0.5
        heart.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))
        
        addChild(heart)
    }
}
