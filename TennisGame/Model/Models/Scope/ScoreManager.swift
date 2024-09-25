
import Foundation

final class ScoreManager {
    
    static let shared = ScoreManager()
    
    private var totalScore: Int = 0
    
    private init() {
        loadScore()
    }
    
    private func loadScore() {
        totalScore = UserDefaults.standard.integer(forKey: "totalScore")
    }
    
    private func saveScore() {
        UserDefaults.standard.set(totalScore, forKey: "totalScore")
    }
    
    func getTotalScore() -> Int {
        return totalScore
    }
    
    func addScore(_ amount: Int) {
        totalScore += amount
        saveScore()
    }
    
    func spendScore(_ amount: Int) -> Bool {
        guard totalScore >= amount else { return false }
        totalScore -= amount
        saveScore()
        return true
    }
}
