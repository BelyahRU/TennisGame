import Foundation
import UIKit
import SpriteKit
import SnapKit
protocol gameSceneDelegate: AnyObject {
    func showShield()
    func showMain()
}

final class GameViewController: UIViewController, gameSceneDelegate {

    weak var gameCoordinator: GameCoordinator!
    var currentLevel: Int = 1

    var scene: GameScene!

   private lazy var progressView = ShieldLoadingView()


    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Добавление progressView в начале

        setupScene()

        // 3. Вызов showShield() после layout и setupScene
    }

    private func setupScene() {
        let skView = SKView(frame: .zero)
        skView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView)

        skView.backgroundColor = .clear
        skView.ignoresSiblingOrder = true

        skView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(16)
            make.width.equalTo(252)
        }

        skView.layoutIfNeeded()
        let sceneSize = CGSize(width: skView.bounds.width, height: skView.bounds.height)
        scene = GameScene(size: sceneSize)
        scene.currentLevel = currentLevel
        scene.scaleMode = .resizeFill
        scene.gameSceneDelegate = self

        skView.presentScene(scene)
    }

    func showShield() {
        progressView.showShield()
    }
    
    func showMain() {
        gameCoordinator.showMain()
    }


    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
