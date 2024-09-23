
import Foundation
import UIKit

final class GameCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var mainCoordinator: MainCoordinator!
    var level: Int
    
    private var gameViewController: GameViewController!
    
    init(level: Int, mainCoordinator: MainCoordinator) {
        self.level = level
        self.mainCoordinator = mainCoordinator
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func start() {
        showGameViewController()
    }
    
    private func showGameViewController() {
        gameViewController = GameViewController()
        gameViewController.gameCoordinator = self
        gameViewController.currentLevel = level
        navigationController.pushViewController(gameViewController, animated: false)
    }
    
    public func showMain() {
        
        navigationController.popViewController(animated: true)
        mainCoordinator.showMain()
    }
    
    
}
