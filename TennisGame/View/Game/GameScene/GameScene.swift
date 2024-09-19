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
    
    func createRacket() {
        let racketTexture = SKTexture(imageNamed: Resources.RacketImages.racketImage)
        let racketWidth = size.width * 0.58
        let racketHeight = racketWidth * (racketTexture.size().height / racketTexture.size().width)
        
        racket = SKSpriteNode(texture: racketTexture, size: CGSize(width: racketWidth, height: racketHeight))
        
        racket.position = CGPoint(x: size.width / 2, y: racketHeight / 2 + 20)
        
        let leftHalfWidth = racketWidth / 2
        let collisionAreaSize = CGSize(width: leftHalfWidth, height: racketHeight)
        
        let collisionBody = SKPhysicsBody(rectangleOf: collisionAreaSize, center: CGPoint(x: -leftHalfWidth / 2, y: 0))
        collisionBody.isDynamic = false
        collisionBody.categoryBitMask = racketCategory
        collisionBody.contactTestBitMask = ballCategory | meteorCategory
        collisionBody.collisionBitMask = 0
        
        racket.physicsBody = collisionBody
        
        addChild(racket)
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
    
    func isPositionValid(_ position: CGPoint, existingNodes: [SKNode], minDistance: CGFloat) -> Bool {
        for node in existingNodes {
            let nodePosition = node.position
            let nodeSize: CGFloat
            if let spriteNode = node as? SKSpriteNode {
                nodeSize = max(spriteNode.size.width, spriteNode.size.height)
            } else {
                nodeSize = 0
            }
            let distance = hypot(position.x - nodePosition.x, position.y - nodePosition.y)
            if distance < minDistance + nodeSize / 2 {
                return false
            }
        }
        return true
    }

    //MARK: - Circle spawn items
    
    func spawnBall() {
        let ballTexture = SKTexture(imageNamed: Resources.BallImages.tennisBall)
        let ball = SKSpriteNode(texture: ballTexture, size: CGSize(width: 60, height: 60))
        
        let minDistance: CGFloat = 30
        var isValidPosition = false
        var position = CGPoint.zero
        
        while !isValidPosition {
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 200)
            isValidPosition = isPositionValid(position, existingNodes: children.filter { $0.physicsBody?.categoryBitMask == ballCategory || $0.physicsBody?.categoryBitMask == meteorCategory }, minDistance: minDistance)
        }
        
        ball.position = position
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory
        ball.physicsBody?.collisionBitMask = 0
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0.5
        
        addChild(ball)
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
