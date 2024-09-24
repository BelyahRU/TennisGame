
import Foundation

class GameSceneViewModel {
    
    let levelManager = LevelManager.shared
    let scopeManager = ScopeManager.shared
    let shopManager = ShopManager.shared
    
    init() { }
    
    public func getLevel(by levelNumber: Int) -> Level? {
        return levelManager.level(for: levelNumber)
    }
    
    public func getCountLevels() -> Int {
        return levelManager.getLevelsCount()
    }
    
    public func updateLevel(level: Level) {
        levelManager.updateLevel(level: level)
    }
    
    public func addScores(_ scores: Int) {
        scopeManager.addScope(scores)
        print("Total scores: \(scopeManager.getTotalScope())")
    }
    
    public func getRacketCurrentName() -> String {
        return shopManager.getCurrentRacketName()
    }
}
