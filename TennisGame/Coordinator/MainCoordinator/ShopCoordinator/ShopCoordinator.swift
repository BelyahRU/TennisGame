
import Foundation
import UIKit

final class ShopCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var mainCoordinator: MainCoordinator!
    
    private var shopViewController: ShopViewController!
    
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func start() {
        showShopViewController()
    }
    
    private func showShopViewController() {
        shopViewController = ShopViewController()
        shopViewController.shopCoordinator = self
        
        navigationController.pushViewController(shopViewController, animated: true)
    }
    
    public func showMain() {
        navigationController.popViewController(animated: true)
    }

}
