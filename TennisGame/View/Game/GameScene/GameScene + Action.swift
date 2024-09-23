
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let pauseButton = childNode(withName: "pauseButton") as? SKSpriteNode {
            if pauseButton.contains(touch.location(in: self)) {
                if isPaused == false {
                    isPaused = true
                    timer?.invalidate()
                    if pauseView == nil {
                        pauseView = PauseView(frame: CGRect(x: 0, y: 0, width: 290, height: 345))
//                            pauseView = PauseView()
                        pauseView?.center = CGPoint(x: size.width / 2, y: size.height - 350)
                        pauseView?.resumeButton.addTarget(self, action: #selector(resumeGame), for: .touchUpInside)
                        pauseView?.backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
                    }
                    if let view = view {
                        view.window?.rootViewController?.view.addSubview(pauseView!)
                    }

                }
            }
        }
        if let restartButton = childNode(withName: "restartButton") as? SKSpriteNode {
            if restartButton.contains(touch.location(in: self)) {
                // Перезагрузка сцены
                let scene = GameScene(size: size)
                scene.scaleMode = .aspectFit
                scene.currentLevel = currentLevel
                view?.presentScene(scene)
            }
        }
    }


    func setupMeteorBallSpawnWith(meteorPersent: Double, meteorSpeed: Int, ballSpeed: Int, duration: Range<Double>) {
        let spawnRandomItem = SKAction.run {
            let itemType = Int.random(in: 0...1)
            if Double(itemType) > meteorPersent {
                self.spawnBall(speed: ballSpeed)
            } else {
                self.spawnMeteor(speed: meteorSpeed)
            }
        }
        
        let wait = SKAction.wait(forDuration: Double(Double.random(in: 0.8...1.5))) //random time 0 to 1
        run(SKAction.repeatForever(SKAction.sequence([spawnRandomItem, wait])))
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
        // +live
        else if collision == racketCategory | heartCategory {
            heartCollision(bodyA: bodyA, bodyB: bodyB)
        }
        // invisible 5 sec.
        else if collision == racketCategory | shieldCategory {
            shieldCollision(bodyA: bodyA, bodyB: bodyB)
        }
        // + 50 scope
        else if collision == racketCategory | starCategory {
            starCollision(bodyA: bodyA, bodyB: bodyB)
        }
        
    }
    
    //MARK: Ball
    func ballCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        score += 1
        scoreLabel.text = "\(score)"
        if bodyA.categoryBitMask == ballCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    //MARK: Meteor
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
        heartImage.texture = getHeartTexture(lives: lives)
        
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
    
    //MARK: Heart
    func heartCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        lives += 1
        lifeLabel.text = "Lives: \(lives)"
        
        if bodyA.categoryBitMask == heartCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    //MARK: Shield/Invisible
    func shieldCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        activateInvincibility(duration: 5)
        
        if bodyA.categoryBitMask == shieldCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    //MARK: Star
    private func starCollision(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        score += 50
        scoreLabel.text = "\(score)"
        
        if bodyA.categoryBitMask == starCategory {
            bodyA.node?.removeFromParent()
        } else {
            bodyB.node?.removeFromParent()
        }
    }
    
    private func activateInvincibility(duration: TimeInterval) {
        isInvincible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.isInvincible = false
        }
        gameSceneDelegate?.showShield()

    }


    // Действие для кнопки "Продолжить"
    @objc func resumeGame() {
        isPaused = false
        startTimer(timerTime: timeRemaining)
        pauseView?.removeFromSuperview()
        pauseView = nil
    }

    // Действие для кнопки "Вернуться в меню"
    @objc func backToMenu() {
        pauseView?.removeFromSuperview()
        gameSceneDelegate?.showMain()
    }

}
