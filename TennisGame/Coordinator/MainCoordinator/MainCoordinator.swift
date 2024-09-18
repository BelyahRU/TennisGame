
import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var mainViewController: MainViewController!
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        showMain()
        //MARK:- ADD other
    }
    
    public func showMain() {
        mainViewController = MainViewController()
        mainViewController.coordinator = self
        
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    
    
    
    
}
