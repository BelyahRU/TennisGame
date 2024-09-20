
import Foundation

final class LevelManager {
    
    static let shared = LevelManager()
    
    var levelsArray: [Level] = []
    
    private init() {
        loadLevels()
    }
    
    
    private func loadLevels() {
        if let data = UserDefaults.standard.data(forKey: "levels"),
           let savedLevels = try? JSONDecoder().decode([Level].self, from: data) {
            levelsArray = savedLevels
        } else {
            getBaseLevels()
            //save
        }
    }
    
    
    
    private func getBaseLevels() {
        levelsArray = [Level(num: 1,
                             stars: 1,
                             isLocked: false),
                       Level(num: 2,
                            stars: 3,
                            isLocked: false),
                       Level(num: 3,
                             stars: 3,
                             isLocked: false),
                       Level(num: 4,
                             stars: 2,
                             isLocked: false),
                       Level(num: 5,
                             stars: 3,
                             isLocked: false),
                       Level(num: 6,
                             stars: 2,
                             isLocked: false),
                       Level(num: 7,
                             stars: 1,
                             isLocked: false),
                       Level(num: 8,
                             stars: 1,
                             isLocked: false),
                       Level(num: 9,
                             stars: 0,
                             isLocked: false)]
    }
}
