
import Foundation

extension LevelManager {
    private func saveScope() {
        UserDefaults.standard.set(totalScope, forKey: "totalScope")
    }
    
    func getTotalScope() -> Int {
        return totalScope
    }
    
    func addScope(_ amount: Int) {
        totalScope += amount
        saveScope()
    }
    
    func spendScope(_ amount: Int) -> Bool {
        guard totalScope >= amount else { return false }
        totalScope -= amount
        saveScope()
        return true
    }
}
