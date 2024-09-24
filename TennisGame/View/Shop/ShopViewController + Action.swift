
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
        print(currentRacketIndex)
        print(viewModel.getAllRackets())
        UIView.transition(with: shopView.racketView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.shopView.racketView.image = UIImage(named: self.racketImages[self.currentRacketIndex])
                          })
        guard let racket = viewModel.getRacket(by: currentRacketIndex + 1) else {
            return
        }
        
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
        // Проверяем, куплена ли ракета
        if racket.isPurchased {
            // Ракетка уже куплена
            // Покажите сообщение или выполните другое действие
        } else {
            // Покупка ракетки
            if viewModel.buyRacket(racketId: racket.id) {
                // Ракетка успешно куплена
                updateBalanceLabel()
                updateBuyTakeButtons()
            } else {
                // Недостаточно валюты
                // Покажите сообщение или выполните другое действие
            }
        }
    }

    @objc func takeButtonTapped() {
        guard let racket = viewModel.getRacket(by: currentRacketIndex + 1) else {
            return
        }
        // Проверяем, куплена ли ракета
        if racket.isPurchased {
            // Выбираем ракетку
            viewModel.setCurrentRacket(racket: racket)
            updateBuyTakeButtons()
        } else {
            // Ракетка не куплена
            // Покажите сообщение или выполните другое действие
        }
    }

    
    
}
