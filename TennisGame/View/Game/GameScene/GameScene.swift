import SpriteKit
import GameplayKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    // levels
    var currentLevel: Int = 0
    var currentLevelParams: Level?
    var countLevels: Int = 10
    
    //items
    var racket: SKSpriteNode!
    var racketNode: SKNode!
    var heart: SKSpriteNode!
    var shield: SKSpriteNode!
    var star: SKSpriteNode!

    //labels
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    
    //buttons
    var pauseButton: SKSpriteNode!
    var restartButton: SKSpriteNode!
    
    var score = 0
    var lives = 3
    var isInvincible = false
    
    //bit category
    let racketCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let meteorCategory: UInt32 = 0x1 << 2
    let heartCategory: UInt32 = 0x1 << 3
    let shieldCategory: UInt32 = 0x1 << 4
    let starCategory: UInt32 = 0x1 << 5
    
    //timer
    var timerLabel: SKLabelNode!
    var timer: Timer?
    var timeRemaining = 30
    
    //viewModel
    let viewModel = GameSceneViewModel()
    
    override func didMove(to view: SKView) {
        loadLevel(levelNumber: currentLevel)
        configure()
        self.startTimer(timerTime: 25)
        createTimerLabel()
    }
    
    func loadLevel(levelNumber: Int) {
        if levelNumber < viewModel.getCountLevels() && levelNumber > 0 {
            currentLevelParams = viewModel.getLevel(by: levelNumber)
            setupLevel(for: currentLevelParams?.num ?? 1)
        } else {
            print("Уровень не найден")
        }
    }
    
    func configure() {
        setupPhysics()
        createRacket()
        createLabels()
        createPauseButton()
        createRestartButton()
    }
     
    //MARK: Timer
    func startTimer(timerTime: Int) {
        print("timer started")
        timeRemaining = timerTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.timer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self?.updateTimer), userInfo: nil, repeats: true)
        }
    }

    @objc func updateTimer() {
        if timeRemaining > 0 {
            print(timeRemaining)
            timeRemaining -= 1
            DispatchQueue.main.async { [weak self] in
                self?.timerLabel.text = "Time: \(self!.timeRemaining)"
            }
        } else {
            timer?.invalidate()
            DispatchQueue.main.async { [weak self] in
                self?.gameOver()
            }
        }
    }
    
    //MARK: UI
    func createTimerLabel() {
        print("timer created")
        timerLabel = SKLabelNode(fontNamed: "Arial")
        timerLabel.fontSize = 24
        timerLabel.fontColor = .white
        timerLabel.position = CGPoint(x: size.width / 2, y: size.height - 100)
        timerLabel.text = "Time: \(timeRemaining)"
        addChild(timerLabel)
    }
    
    func createPauseButton() {
        print("created pauseButton")
        let pauseButtonTexture = SKTexture(imageNamed: Resources.ButtonImages.pauseButton)
        pauseButton = SKSpriteNode(texture: pauseButtonTexture, size: CGSize(width: 60, height: 60))
        
        pauseButton.position = CGPoint(x: 50, y: size.height - 64)
        pauseButton.name = "pauseButton"
        
        addChild(pauseButton)
    }
    
    func createRestartButton() {
        print("created restartButton")
        let restartButtonTexture = SKTexture(imageNamed: Resources.ButtonImages.restartButton)
        restartButton = SKSpriteNode(texture: restartButtonTexture, size: CGSize(width: 60, height: 60))
        
        restartButton.position = CGPoint(x: size.width-50, y: size.height - 64)
        restartButton.name = "restartButton"
        
        addChild(restartButton)
    }


    
    func createRacket() {
        print("created racket")
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
        print("created labels")
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
    
    //MARK: Position
    func isPositionValid(_ position: CGPoint, existingNodes: [SKNode], minDistance: CGFloat) -> Bool {
        print("position validation")
        print(position, existingNodes.map{$0.position}, minDistance)
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
                print(false)
                return false
            }
        }
        print(true)
        return true
    }

    
    // MARK: - Game over
    func gameOver() {
        print("gameOver")
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 48
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameOverLabel)
        
        isPaused = true
    }
}
