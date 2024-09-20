
import Foundation

class GameSceneViewModel {
    
    let levelManager = LevelManager.shared
    
    init() { }
    
    public func getLevel(by levelNumber: Int) -> Level? {
        return levelManager.level(for: levelNumber)
    }
    
    public func getCountLevels() -> Int {
        return levelManager.getLevelsCount()
    }
}
