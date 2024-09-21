
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    func spawnBall(speed: Int) {
        let ballTexture = SKTexture(imageNamed: Resources.BallImages.tennisBall)
        let ball = SKSpriteNode(texture: ballTexture, size: CGSize(width: 60, height: 60))
        
        setupBallPosition(for: ball)
        setupBallPhysics(for: ball)
        setupBallSpeed(with: speed, ball: ball)
        addChild(ball)
    }
    
    //0 to 1300 - speed range
    private func setupBallSpeed(with speed: Int, ball: SKSpriteNode ) {
        //if speed == 0, then we use base speed
        if speed != 0 {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        }
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
        let existingNodes = children.filter {
            $0.physicsBody?.categoryBitMask == meteorCategory ||
            $0.physicsBody?.categoryBitMask == shieldCategory ||
            $0.physicsBody?.categoryBitMask == heartCategory ||
            $0.physicsBody?.categoryBitMask == starCategory
        }

        // Выполняем проверку в отдельном потоке
        DispatchQueue.global().async { [weak self] in
            print("setupBall")
            var isValidPosition = false
            var position = CGPoint.zero

            while !isValidPosition {
                let sizeW = self!.size.width
                let sizeH = self!.size.height
                position = CGPoint(x: CGFloat.random(in: 0.0...sizeW), y: sizeH - 200)
                isValidPosition = self?.isPositionValid(position, existingNodes: existingNodes, minDistance: minDistance) ?? false

                print("after")
            }

            // Обновляем позицию шара в основном потоке
            DispatchQueue.main.async {
                ball.position = position
            }
        }
    }

    
}
