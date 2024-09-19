import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var racket: SKSpriteNode!
    var racketNode: SKNode!

    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    var score = 0
    var lives = 3
    
    let racketCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let meteorCategory: UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView) {
        configure()
    }
    
    func configure() {
        setupPhysics()
        createRacket()
        createLabels()
        setupAction()
    }
    
    //MARK: - CREATE
    func createRacket() {
        let greenPart = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 20))
        greenPart.position = CGPoint(x: -25, y: 0)

        let bluePart = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 20))
        bluePart.position = CGPoint(x: 50, y: 0)

        racketNode = SKNode()
        racketNode.addChild(greenPart)
        racketNode.addChild(bluePart)

        greenPart.physicsBody = SKPhysicsBody(rectangleOf: greenPart.size)
        greenPart.physicsBody?.isDynamic = false
        greenPart.physicsBody?.categoryBitMask = racketCategory
        greenPart.physicsBody?.contactTestBitMask = ballCategory | meteorCategory
        greenPart.physicsBody?.collisionBitMask = 0

        addChild(racketNode)

        racketNode.position = CGPoint(x: size.width / 2, y: 50)
    }
    
    func createLabels() {
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
        
        lifeLabel = SKLabelNode(fontNamed: "Arial")
        lifeLabel.fontSize = 24
        lifeLabel.fontColor = .white
        lifeLabel.position = CGPoint(x: size.width - 100, y: size.height - 50)
        lifeLabel.text = "Lives: \(lives)"
        addChild(lifeLabel)
    }
    
    //MARK: - Circle spawn items
    func spawnBall() {
        let ball = SKSpriteNode(color: .green, size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory
        ball.physicsBody?.collisionBitMask = 0
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0.5
        addChild(ball)
    }
    
    func spawnMeteor() {
        let meteor = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        meteor.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height)
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: meteor.size.width / 2)
        meteor.physicsBody?.categoryBitMask = meteorCategory
        meteor.physicsBody?.contactTestBitMask = racketCategory
        meteor.physicsBody?.collisionBitMask = 0
        meteor.physicsBody?.affectedByGravity = true
        meteor.physicsBody?.restitution = 0
        meteor.physicsBody?.linearDamping = 0.5
        addChild(meteor)
    }
    
    
    //MARK: - Moving
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            racketNode.position.x = location.x
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
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        //+score
        if collision == racketCategory | ballCategory {
            score += 1
            scoreLabel.text = "Score: \(score)"
            if contact.bodyA.categoryBitMask == ballCategory {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
        //-live
        } else if collision == racketCategory | meteorCategory {
            lives -= 1
            lifeLabel.text = "Lives: \(lives)"
            
            if contact.bodyA.categoryBitMask == meteorCategory {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
            
            if lives > 0 {
                racketNode.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.racketNode.isHidden = false
                }
            //lives == 0
            } else {
                gameOver()
            }
        }
    }



    
    // MARK: - Game over
    func gameOver() {
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 48
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameOverLabel)
        
        isPaused = true
    }
}
