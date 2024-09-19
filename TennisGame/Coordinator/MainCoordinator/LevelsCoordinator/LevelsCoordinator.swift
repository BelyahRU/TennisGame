
import Foundation
import UIKit

final class LevelsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    private var levelsViewController: LevelsViewController!
    
    init() {
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
    
}
