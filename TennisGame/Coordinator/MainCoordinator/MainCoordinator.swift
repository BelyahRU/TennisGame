
import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    //MARK: Coordinators
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
    
    //MARK: - MAIN SCREEN
    public func showMain() {
        mainViewController = MainViewController()
        mainViewController.coordinator = self  // назначаем координатор
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    //MARK: - GAME SCREEN
    public func showGame() {
        gameCoordinator = GameCoordinator(level: viewModel.getLastOpenedLevel().num, mainCoordinator: self)//FIX
        gameCoordinator.navigationController = navigationController
        gameCoordinator.start()
    }
    
    //MARK: - LEVELS SCREEN
    public func showLevels() {
        levelsCoordinator = LevelsCoordinator(mainCoordinator: self)
        levelsCoordinator.navigationController = navigationController
        levelsCoordinator.start()
    }
    
    //MARK: - SHOP SCREEN
    public func showShop() {
        shopCoordinator = ShopCoordinator(mainCoordinator: self)
        shopCoordinator.navigationController = navigationController
        shopCoordinator.start()
    }
    
    
    
}
