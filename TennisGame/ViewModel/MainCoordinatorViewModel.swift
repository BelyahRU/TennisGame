
import Foundation
class MainCoordinatorViewModel {
    
    let levelManager = LevelManager.shared
    
    init() { }
    
    public func getLastOpenedLevel() -> Level {
        let arr = levelManager.getAllLevels()
        var lastLevel: Level?
        for i in arr {
            if i.isLocked == false {
                lastLevel = i
            }
        }
        guard let lastLevel = lastLevel else {return arr.first!}
        return lastLevel
    }
}
