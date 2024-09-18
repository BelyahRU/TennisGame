
import Foundation
import UIKit

extension MainViewController {
    func setupButtons() {
        gameStartButton = mainView.gameStartButton
        gameStartButton.addTarget(self, action: #selector(gameStartPressed), for: .touchUpInside)
    }

    @objc func gameStartPressed() {
        
    }
}
