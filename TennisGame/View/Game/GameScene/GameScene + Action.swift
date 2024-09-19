
import Foundation
import UIKit
import SpriteKit
//MARK: - Action
extension GameScene {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            racket.position.x = location.x
        }
    }

    
    func setupAction() {
        let spawnBalls = SKAction.run { self.spawnBall() }
        let spawnMeteors = SKAction.run { self.spawnMeteor() }
        
        let wait = SKAction.wait(forDuration: 2.0)
        run(SKAction.repeatForever(SKAction.sequence([spawnBalls, spawnMeteors, wait])))
    }
    
    func setupPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let collision = bodyA.categoryBitMask | bodyB.categoryBitMask
        
        // +score
        if collision == racketCategory | ballCategory {
            score += 1
            scoreLabel.text = "Score: \(score)"
            if bodyA.categoryBitMask == ballCategory {
                bodyA.node?.removeFromParent()
            } else {
                bodyB.node?.removeFromParent()
            }
        }
        // -live
        else if collision == racketCategory | meteorCategory {
            let meteorBody: SKPhysicsBody
            if bodyA.categoryBitMask == meteorCategory {
                meteorBody = bodyA
            } else {
                meteorBody = bodyB
            }
            
            if !meteorBody.allowsRotation {
                return
            }
            
            lives -= 1
            lifeLabel.text = "Lives: \(lives)"
            
            meteorBody.node?.removeFromParent()
            
            if lives > 0 {
                racket.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.racket.isHidden = false
                }
            } else {
                gameOver()
            }
            
            meteorBody.allowsRotation = false
        }
    }


}
