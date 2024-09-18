
import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var mainViewController: MainViewController!
    var gameCoordinator: GameCoordinator!
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        showMain()
    }
    
    public func showMain() {
        mainViewController = MainViewController()
        mainViewController.coordinator = self  // назначаем координатор
        navigationController.pushViewController(mainViewController, animated: false)
    }

    
    public func showGame() {
        gameCoordinator = GameCoordinator()
        gameCoordinator.navigationController = navigationController
        gameCoordinator.start()
    }
    
    
    
}
