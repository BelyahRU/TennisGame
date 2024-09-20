
import Foundation

class LevelsViewModel {
    
    let levelManager = LevelManager.shared
    
    init() { }
    
    public func getLevel(by levelNumber: Int) -> Level? {
        return levelManager.level(for: levelNumber)
    }
    
}
