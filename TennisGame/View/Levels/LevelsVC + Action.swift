
import Foundation
import UIKit

extension LevelsViewController {
    func setupButton() {
        backButton = levelsView.backButton
        
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        levelsCoordinator.showMain()
    }
}
