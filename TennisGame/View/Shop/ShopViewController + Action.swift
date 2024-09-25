
import Foundation
import UIKit

extension ShopViewController {
    public func setupTargets() {
        shopView.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        shopView.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        shopView.buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        shopView.takeButton.addTarget(self, action: #selector(takeButtonTapped), for: .touchUpInside)
        shopView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc func backPressed() {
        shopCoordinator?.showMain()
    }
    
    //previous
    @objc func leftButtonTapped() {
        currentRacketIndex = (currentRacketIndex - 1 + racketImages.count) % racketImages.count
        UIView.transition(with: shopView.racketView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.shopView.racketView.image = UIImage(named: self.racketImages[self.currentRacketIndex])
                          })
        
        updateBuyTakeButtons()
    }

    //next
    @objc func rightButtonTapped() {
        currentRacketIndex = (currentRacketIndex + 1) % racketImages.count

        UIView.transition(with: shopView.racketView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.shopView.racketView.image = UIImage(named: self.racketImages[self.currentRacketIndex])
                          })
        updateBuyTakeButtons()
    }
    
    @objc func buyButtonTapped() {
        guard let racket = viewModel.getRacket(by: currentRacketIndex + 1) else {
            return
        }
        if racket.isPurchased {
            //already bought
        } else {
            if viewModel.buyRacket(racketId: racket.id) {
                updateBalanceLabel()
                updateBuyTakeButtons()
            } else {
                //no money
            }
        }
    }

    @objc func takeButtonTapped() {
        guard let racket = viewModel.getRacket(by: currentRacketIndex + 1) else {
            return
        }
        if racket.isPurchased {
            viewModel.setCurrentRacket(racket: racket)
            updateBuyTakeButtons()
        } else {
            //racket not bought
        }
    }

    
    
}
