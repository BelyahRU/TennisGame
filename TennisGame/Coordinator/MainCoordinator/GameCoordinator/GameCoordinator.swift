
import Foundation
import UIKit

final class GameCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    private var gameViewController: GameViewController!
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func start() {
        showGameViewController()
    }
    
    private func showGameViewController() {
        gameViewController = GameViewController()
        gameViewController.gameCoordinator = self
        
        navigationController.pushViewController(gameViewController, animated: false)
    }
    
    
}
