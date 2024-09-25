import Foundation
struct Racket {
    let id: Int
    let name: String
    let price: Int
    var isPurchased: Bool = false
}

final class ShopManager {
    static let shared = ShopManager()

    private var rackets: [Racket] = [
        Racket(id: 1, name: "racketImageFree", price: 0, isPurchased: true),
        Racket(id: 2, name: "racketImage5000", price: 500),
        Racket(id: 3, name: "racketImage10000", price: 1000)
    ]
   
    private var currentRacketName: String = "racketImageFree" {
        didSet {
            saveCurrentRacket()
        }
    }


    private init() {
        loadRackets()
    }

    private func loadRackets() {
        if let purchasedRacketIds = UserDefaults.standard.array(forKey: "purchasedRackets") as? [Int] {
            for i in 0..<rackets.count {
                if purchasedRacketIds.contains(rackets[i].id) {
                    rackets[i].isPurchased = true
                }
            }
        }
    }

    private func saveRackets() {
        let purchasedRacketIds = rackets.filter { $0.isPurchased }.map { $0.id }
        UserDefaults.standard.set(purchasedRacketIds, forKey: "purchasedRackets")
    }

    func getRackets() -> [Racket] {
        return rackets
    }

    func buyRacket(racketId: Int) -> Bool {
        guard let racketIndex = rackets.firstIndex(where: { $0.id == racketId }) else { return false }
        let racket = rackets[racketIndex]

        if ScoreManager.shared.spendScore(racket.price) {
            rackets[racketIndex].isPurchased = true
            saveRackets()
            return true
        }

        return false
    }
    
    private func loadCurrentRacket() {
        if let name = UserDefaults.standard.string(forKey: "currentRacket") {
            currentRacketName = name
        }
    }

    //save
    private func saveCurrentRacket() {
        UserDefaults.standard.set(currentRacketName, forKey: "currentRacket")
    }
    
    //current
    func getCurrentRacketName() -> String {
        return currentRacketName
    }

    func setCurrentRacket(name: String) {
        currentRacketName = name
    }


}
