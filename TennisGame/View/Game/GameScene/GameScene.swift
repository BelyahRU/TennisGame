import SpriteKit
import GameplayKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //delegate
    weak var gameSceneDelegate: gameSceneDelegate?
    
    //views
    var pauseView: PauseView?
    var gameOverView: GameOverView?

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
    
    var clockImage: SKSpriteNode!
    var heartImage: SKSpriteNode!
    var scoreImage: SKSpriteNode!
    
    //labels
    var scoreLabel: SKLabelNode!
    
    
    
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
    var timeRemaining = 0
    var newTime = 0
    
    //viewModel
    let viewModel = GameSceneViewModel()
    
    //for countingStars
    var allBalls = 0
    var gotBalls = 0
    
    let backgroundTexture = SKTexture(image: UIImage(named:
                        Resources.BackgroundImages.mainBackgroundImage)!)
    
    override func didMove(to view: SKView) {

        loadLevel(levelNumber: currentLevel)
        configure()
        startTimer(timerTime: newTime)
        createClockImage()
        createTimerLabel()

    }
    
    func loadLevel(levelNumber: Int) {
        if levelNumber <= viewModel.getCountLevels() && levelNumber > 0 {
            currentLevelParams = viewModel.getLevel(by: levelNumber)
            setupLevel(for: currentLevelParams?.num ?? 1)
        } else {
            print("Уровень не найден")
        }
    }
    
    func configure() {
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        
        // 4. Устанавливаем размер спрайта, чтобы он занимал весь экран
        backgroundNode.size = size
        
        // 5. Устанавливаем позицию спрайта в центр экрана
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode.zPosition = -5
        // 6. Добавляем спрайт в сцену
        addChild(backgroundNode)
        setupPhysics()
        createRacket()
        createPauseButton()
        createRestartButton()
        createHeartImage()
        createScoreImage()
    }
    
    //MARK: Timer
    func startTimer(timerTime: Int) {
        print("timer started")
        timeRemaining = timerTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            if timeRemaining >= 60 {
                let minutes = timeRemaining / 60
                let seconds = timeRemaining % 60
                timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            } else {
                timerLabel.text = "\(timeRemaining)"
            }
            
        } else {
            timer?.invalidate()
            gameOver()
        }
    }
    
    //MARK: UI
    func createTimerLabel() {
        print("timerLabel created")
        timerLabel = SKLabelNode(fontNamed: "BULGOGI")
        timerLabel.fontSize = 17
        timerLabel.fontColor = Resources.Colors.purpleTextColor
        timerLabel.position = CGPoint(x: size.width / 2, y: clockImage.position.y - 7)
        timerLabel.text = "\(timeRemaining)"
        timerLabel.zPosition = 2
        addChild(timerLabel)
    }
    
    func createPauseButton() {
        print("created pauseButton")
        let pauseButtonTexture = SKTexture(imageNamed: Resources.ButtonImages.pauseButton)
        pauseButton = SKSpriteNode(texture: pauseButtonTexture, size: CGSize(width: 60, height: 60))
        
        pauseButton.position = CGPoint(x: 50, y: size.height - 64)
        pauseButton.name = "pauseButton"
        pauseButton.zPosition = 2
        addChild(pauseButton)
    }
    
    func createRestartButton() {
        print("created restartButton")
        let restartButtonTexture = SKTexture(imageNamed: Resources.ButtonImages.restartButton)
        restartButton = SKSpriteNode(texture: restartButtonTexture, size: CGSize(width: 60, height: 60))
        
        restartButton.position = CGPoint(x: size.width-50, y: size.height - 64)
        restartButton.name = "restartButton"
        restartButton.zPosition = 2
        addChild(restartButton)
    }
    
    
    
    func createRacket() {
        print("created racket")
        print(viewModel.getRacketCurrentName())
        let racketTexture = SKTexture(imageNamed: viewModel.getRacketCurrentName())
        let racketWidth = size.width * 0.58
        let racketHeight = racketWidth * (racketTexture.size().height / racketTexture.size().width)
        
        racket = SKSpriteNode(texture: racketTexture, size: CGSize(width: racketWidth, height: racketHeight))
        
        racket.position = CGPoint(x: size.width / 2, y: 80)
        
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
    
    func createClockImage() {
        print("created clockImage")
        let clockImageTexture = SKTexture(imageNamed: Resources.ItemImages.clockImage)
        clockImage = SKSpriteNode(texture: clockImageTexture, size: CGSize(width: 75, height: 75))
        
        clockImage.position = CGPoint(x: size.width / 2, y: size.height - 64)
        clockImage.name = "clockImage"
        clockImage.zPosition = 1
        addChild(clockImage)
    }
    
    func createHeartImage() {
        print("lives created")
        
        let heartImageTexture = getHeartTexture(lives: lives)
        heartImage = SKSpriteNode(texture: heartImageTexture, size: CGSize(width: 75, height: 65))
        
        heartImage.position = CGPoint(x: (50 + size.width/2) / 2 + 10, y: pauseButton.position.y - 6.5)
        heartImage.name = "heartImage"
        heartImage.zPosition = 1
        addChild(heartImage)
    }
    
    func getHeartTexture(lives: Int) -> SKTexture {
        switch lives {
        case 5:
            return SKTexture(imageNamed: Resources.ItemImages.x5Heart)
        case 4:
            return SKTexture(imageNamed: Resources.ItemImages.x4Heart)
        case 3:
            return SKTexture(imageNamed: Resources.ItemImages.x3Heart)
        case 2:
            return SKTexture(imageNamed: Resources.ItemImages.x2Heart)
        case 1:
            return SKTexture(imageNamed: Resources.ItemImages.x1Heart)
        default:
            return SKTexture(imageNamed: Resources.ItemImages.x0Heart)
        }
    }
    
    func createScoreImage() {
        print("score created")
        
        let scoreImageTexture = SKTexture(imageNamed: Resources.ItemImages.scoreImage)
        scoreImage = SKSpriteNode(texture: scoreImageTexture, size: CGSize(width: 52, height: 60))
        
        scoreImage.position = CGPoint(x: (size.width-50 + size.width/2) / 2, y: pauseButton.position.y - 2)
        scoreImage.name = "score"
        scoreImage.zPosition = 1
        addChild(scoreImage)
        
        scoreLabel = SKLabelNode(fontNamed: "BULGOGI")
        scoreLabel.fontSize = 14
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: scoreImage.position.x, y: scoreImage.position.y - 12)
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
        
    //MARK: Position
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
    
    
}

