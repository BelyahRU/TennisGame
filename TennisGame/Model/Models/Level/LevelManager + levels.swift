
import Foundation

extension LevelManager {
    
    func level(for number: Int) -> Level? {
        guard number > 0 && number <= levelsArray.count else { return nil }
        return levelsArray.first { $0.num == number }
    }
    
    func updateLevel(level: Level) {
        if let index = levelsArray.firstIndex(where: { $0.num == level.num }) {
            levelsArray[index] = level
            if levelsArray[index].stars == 3 {
                markLevelAsCompleted(for: level.num)
            }
            if level.num != levelsArray.count {
                if level.num == 3 && self.level(for: level.num + 1)!.isLocked == true {
                    unlockNextLevel(levelNumber: level.num)
                }
            }
            
            saveLevels()
        }
    }
    
    func getLastUnlockedLevel() -> Level? {
        return levelsArray.filter { !$0.isLocked }.max(by: { $0.num < $1.num})
    }
    
    private func markLevelAsCompleted(for number: Int) {
        if var level = level(for: number) {
            level.stars = 3
            updateLevelWithoutMarkingComplete(level: level)
            unlockNextLevel(levelNumber: number)
            saveLevels()
        }
    }
    
    private func updateLevelWithoutMarkingComplete(level: Level) {
        if let index = levelsArray.firstIndex(where:  { $0.num == level.num }) {
            levelsArray[index] = level
        }
    }
    
    private func unlockNextLevel(levelNumber: Int) {
        let nextLevelNumber = levelNumber + 1
        if nextLevelNumber <= levelsArray.count, var nextLevel = level(for: nextLevelNumber) {
            nextLevel.isLocked = false
            updateLevelWithoutMarkingComplete(level: nextLevel)
        }
    }
 
    private func saveLevels() {
        if let data = try? JSONEncoder().encode(levelsArray) {
            UserDefaults.standard.set(data, forKey: "levels")
        }
    }
    
    
    func getAllLevels() -> [Level] {
        return levelsArray
    }
}
