
import Foundation
import UIKit

final class LevelsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var mainCoordinator: MainCoordinator!
    var gameCoordinator: GameCoordinator!
    
    private var levelsViewController: LevelsViewController!
    
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func start() {
        showLevelsViewController()
    }
    
    private func showLevelsViewController() {
        levelsViewController = LevelsViewController()
        levelsViewController.levelsCoordinator = self
        
        navigationController.pushViewController(levelsViewController, animated: true)
    }
    
    public func showMain() {
        navigationController.popViewController(animated: true)
    }
    
    public func showGame(with level: Int) {
        gameCoordinator = GameCoordinator(level: level, mainCoordinator: mainCoordinator)//FIX
        gameCoordinator.navigationController = navigationController
        gameCoordinator.start()
    }

    
}
