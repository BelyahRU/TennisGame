
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    
    func scheduleShieldSpawn(range: Range<Double>) {
        let randomTime = Double.random(in: range)
        DispatchQueue.main.async {
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: randomTime),
                SKAction.run { [weak self] in
                    self?.spawnShield()
                }
            ]))
        }
    }
    
    private func spawnShield() {
        let shieldTexture = SKTexture(imageNamed: Resources.ItemImages.shield)
        
        shield = SKSpriteNode(texture: shieldTexture, size: CGSize(width: 75, height: 75))
        setupShieldPosition()
        setupShieldPhysics()
        addChild(shield)
    }
    
    private func setupShieldPosition() {
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

        shield.position = position
    }
    
    private func setupShieldPhysics() {
        shield.physicsBody = SKPhysicsBody(circleOfRadius: shield.size.width / 2)
        shield.physicsBody?.categoryBitMask = shieldCategory
        shield.physicsBody?.contactTestBitMask = racketCategory
        shield.physicsBody?.affectedByGravity = true
        shield.physicsBody?.collisionBitMask = 0
        shield.physicsBody?.restitution = 0.5
        shield.physicsBody?.linearDamping = 0.5
        shield.physicsBody?.velocity = CGVector(dx: 0, dy: -600)
//        shield.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -10))?
    }
}
