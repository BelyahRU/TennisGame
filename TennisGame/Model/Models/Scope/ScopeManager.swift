
import Foundation

class ScopeManager {
    
    static let shared = ScopeManager()
    
    private var totalScope: Int = 0
    
    private init() {
        loadScope()
    }
    
    private func loadScope() {
        totalScope = UserDefaults.standard.integer(forKey: "totalScope")
    }
    
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
