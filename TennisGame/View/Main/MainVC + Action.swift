
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        gameStartButton = mainView.gameStartButton
        levelsButton = mainView.levelsButton
        shopButton = mainView.shopButton
        
        gameStartButton.addTarget(self, action: #selector(gameStartPressed), for: .touchUpInside)
        levelsButton.addTarget(self, action: #selector(levelsPressed), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopPressed), for: .touchUpInside)
    }

    @objc 
    func gameStartPressed() {
        coordinator?.showGame()
    }
    
    @objc
    func levelsPressed() {
        coordinator.showLevels()
    }
    
    @objc
    func shopPressed() {
        coordinator.showShop()
    }
}
