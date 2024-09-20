
import Foundation

class LevelManager {
    
    static let share = LevelManager()
    
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
        }
    }
    
    
    
    private func getBaseLevels() {
        levelsArray = [Level(num: 1,
                             stars: 0,
                             isLocked: false),
                       Level(num: 2,
                            stars: 0,
                            isLocked: true),
                       Level(num: 3,
                             stars: 0,
                             isLocked: true),
                       Level(num: 4,
                             stars: 0,
                             isLocked: true),
                       Level(num: 5,
                             stars: 0,
                             isLocked: true),
                       Level(num: 6,
                             stars: 0,
                             isLocked: true),
                       Level(num: 7,
                             stars: 0,
                             isLocked: true),
                       Level(num: 8,
                             stars: 0,
                             isLocked: true),
                       Level(num: 9,
                             stars: 0,
                             isLocked: true)]
    }
}
