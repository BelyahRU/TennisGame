
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    func spawnBall() {
        let ballTexture = SKTexture(imageNamed: Resources.BallImages.tennisBall)
        let ball = SKSpriteNode(texture: ballTexture, size: CGSize(width: 60, height: 60))
        
        setupBallPosition(for: ball)
        setupBallPhysics(for: ball)
        
        addChild(ball)
    }
    
    private func setupBallPhysics(for ball: SKSpriteNode) {
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory
        ball.physicsBody?.collisionBitMask = 0
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0.5
    }
    
    private func setupBallPosition(for ball: SKSpriteNode) {
        let minDistance: CGFloat = 30
        var isValidPosition = false
        var position = CGPoint.zero
        
        while !isValidPosition {
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 200)
            isValidPosition = isPositionValid(position, existingNodes: children.filter {  $0.physicsBody?.categoryBitMask == ballCategory ||
                $0.physicsBody?.categoryBitMask == ballCategory ||
                $0.physicsBody?.categoryBitMask == meteorCategory ||
                $0.physicsBody?.categoryBitMask == shieldCategory ||
                $0.physicsBody?.categoryBitMask == heartCategory ||
                $0.physicsBody?.categoryBitMask == starCategory
            }, minDistance: minDistance)
        }
        
        ball.position = position
    }
}
