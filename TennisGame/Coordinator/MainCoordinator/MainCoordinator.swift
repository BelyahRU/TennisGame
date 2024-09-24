
import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var mainViewController: MainViewController!
    var gameCoordinator: GameCoordinator!
    var levelsCoordinator: LevelsCoordinator!
    var shopCoordinator: ShopCoordinator!
    
    var viewModel = MainCoordinatorViewModel()
    
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
        gameCoordinator = GameCoordinator(level: viewModel.getLastOpenedLevel().num, mainCoordinator: self)//FIX
        gameCoordinator.navigationController = navigationController
        gameCoordinator.start()
    }
    
    public func showLevels() {
        levelsCoordinator = LevelsCoordinator(mainCoordinator: self)
        levelsCoordinator.navigationController = navigationController
        levelsCoordinator.start()
    }
    
    public func showShop() {
        shopCoordinator = ShopCoordinator(mainCoordinator: self)
        shopCoordinator.navigationController = navigationController
        shopCoordinator.start()
    }
    
    
    
}
