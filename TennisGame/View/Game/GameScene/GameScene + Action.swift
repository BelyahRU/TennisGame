
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
        let spawnRandomItem = SKAction.run { self.spawnRandomItem() }
        
        let wait = SKAction.wait(forDuration: Double(Int.random(in: 0...1))) //random time 0 to 1
        run(SKAction.repeatForever(SKAction.sequence([spawnRandomItem, wait])))
    }
    
    func spawnRandomItem() {
        let itemType = Int.random(in: 0...1) // 0 - meteor, 1 - ball, 2 - other
        switch itemType {
        case 0:
            spawnMeteor()
        case 1:
            spawnBall()
        default:
            spawnOtherItem()
        }
    }
    func spawnOtherItem() {
        //ADD: - jther items
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
            ballCollision(bodyA: bodyA, bodyB: bodyB)
        }
        // -live
        else if collision == racketCategory | meteorCategory {
            meteorCollision(bodyA: bodyA, bodyB: bodyB)
        }
        //+live
        else if collision == racketCategory | heartCategory {
            heartCollision(bodyA: bodyA, bodyB: bodyB)
        }
        //invisible 5 sec.
        else if collision == racketCategory | shieldCategory {
            shieldCollision(bodyA: bodyA, bodyB: bodyB)
        }
    }
    
    func ballCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        score += 1
        scoreLabel.text = "Score: \(score)"
        if bodyA.categoryBitMask == ballCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    func meteorCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        guard !isInvincible else { return }
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
    
    func heartCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        lives += 1
        lifeLabel.text = "Lives: \(lives)"
        
        if bodyA.categoryBitMask == heartCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    func shieldCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        activateInvincibility(duration: 5)
        
        if bodyA.categoryBitMask == shieldCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    private func activateInvincibility(duration: TimeInterval) {
        // Здесь вы можете изменить визуальные эффекты или состояние игрока, если нужно
        isInvincible = true // Пример переменной состояния

        // Запускаем таймер для отключения неуязвимости через 5 секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.isInvincible = false
            // Возвращаем визуальные эффекты в норму, если были
        }
    }




}
