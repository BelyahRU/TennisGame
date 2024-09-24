
import Foundation
import UIKit

class ShopViewModel {
    let shopManager = ShopManager.shared
    let scoreManager = ScopeManager.shared
    
    func getAllRackets() -> [Racket] {
        return shopManager.getRackets()
    }
    
    func buyRacketBy(id: Int) -> Bool {
        return shopManager.buyRacket(racketId: id)
    }
    
    func getRacket(by id: Int) -> Racket? {
        let arr = shopManager.getRackets()
        for i in arr {
            if i.id == id {
                return i
            }
        }
        return nil
    }
    
    func setCurrentRacket(racket: Racket) {
        shopManager.setCurrentRacket(name: racket.name)
    }
    
    func buyRacket(racketId: Int) -> Bool {
        return shopManager.buyRacket(racketId: racketId)
    }
    
    func getBalance() -> Int{
        return scoreManager.getTotalScope()
    }
    
}
