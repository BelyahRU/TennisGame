
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    func setupLevel(for num: Int) {
        print(num)
        switch num {
            case 1:
                setupFirstLevel()
                print("loaded 1 level")
            case 2:
                setupSecondLevel()
                print("loaded 2 level")
            case 3:
                setupThirdLevel()
                print("loaded 3 level")
            case 4:
                setupFourthLevel()
                print("loaded 4 level")
            case 5:
                setupFifthLevel()
                print("loaded 5 level")
            case 6:
                setupSixthLevel()
                print("loaded 6 level")
            case 7:
                setupSeventhLevel()
                print("loaded 7 level")
            case 8:
                setupEightLevel()
                print("loaded 8 level")
            case 9:
                setupNinthLevel()
                print("loaded 9 level")
                
            default:
                print("error load level")
        }
    }
    
    
    //1
    func setupFirstLevel() {
        newTime = 20
        lives = 3
        setupMeteorBallSpawnWith(meteorPersent: 0.5, meteorSpeed: 0, ballSpeed: 0, duration: Double(1.2)..<Double(2))
    }
    
    //2
    func setupSecondLevel() {
        newTime = 60
        setupMeteorBallSpawnWith(meteorPersent: 0.4, meteorSpeed: 400, ballSpeed:0, duration: Double(1.2)..<Double(2))
        scheduleShieldSpawn(range: Double(0)..<Double(5))
        
        self.scheduleHeartSpawn(range: Double(0)..<Double(5))
    }
    
    //3
    func setupThirdLevel() {
        newTime = 45
        lives = 2
        setupMeteorBallSpawnWith(meteorPersent: 0.4, meteorSpeed: 700, ballSpeed:0, duration: Double(1.2)..<Double(2))
        scheduleHeartSpawn(range: Double(15)..<Double(20))
        
    }
    
    //4
    func setupFourthLevel() {
        newTime = 30
        lives = 2
        setupMeteorBallSpawnWith(meteorPersent: 0.5, meteorSpeed: 700, ballSpeed:300, duration: Double(1.2)..<Double(2))
        scheduleStarSpawn(range: Double(10)..<Double(15))
        scheduleHeartSpawn(range: Double(15)..<Double(18))
    }
    
    //5
    func setupFifthLevel() {
        newTime = 60
        lives = 2
        setupMeteorBallSpawnWith(meteorPersent: 0.5, meteorSpeed: 700, ballSpeed:300, duration: Double(0.5)..<Double(2))
        scheduleShieldSpawn(range: Double(5)..<Double(10))
        scheduleShieldSpawn(range: Double(20)..<Double(32))
        scheduleStarSpawn(range: Double(32)..<Double(50))
    }
    
    //6
    func setupSixthLevel() {
        newTime = 30
        lives = 1
        setupMeteorBallSpawnWith(meteorPersent: 0.2, meteorSpeed: 900, ballSpeed:300, duration: Double(0.5)..<Double(2))
        scheduleShieldSpawn(range: Double(5)..<Double(10))
//        scheduleShieldSpawn(range: Double(20)..<Double(32))
        scheduleStarSpawn(range: Double(10)..<Double(15))
        scheduleHeartSpawn(range: Double(15)..<Double(29))
    }
    
    //7
    func setupSeventhLevel() {
        newTime = 120
        lives = 4
        setupMeteorBallSpawnWith(meteorPersent: 0.2, meteorSpeed: 600, ballSpeed:600, duration: Double(0.5)..<Double(2))
        scheduleStarSpawn(range: Double(10)..<Double(15))
        scheduleHeartSpawn(range: Double(15)..<Double(29))
        scheduleShieldSpawn(range: Double(30)..<Double(45))
        scheduleStarSpawn(range: Double(60)..<Double(70))
        scheduleShieldSpawn(range: Double(70)..<Double(80))
        scheduleStarSpawn(range: Double(80)..<Double(90))
        scheduleShieldSpawn(range: Double(90)..<Double(105))
    }
    
    //8
    func setupEightLevel() {
        newTime = 30
        lives = 2
        setupMeteorBallSpawnWith(meteorPersent: 0, meteorSpeed: 800, ballSpeed:600, duration: Double(0.5)..<Double(2))
        for i in 0..<15 {
            if i > 8 || i < 5 {
                let startRange = Double(i * 2)
                let endRange = Double((i + 1) * 2)
                scheduleStarSpawn(range: startRange..<endRange)
            }
        }
        scheduleShieldSpawn(range: Double(10)..<Double(15))
    }
    
    //9
    func setupNinthLevel() {
        newTime = 30
        lives = 2
        setupMeteorBallSpawnWith(meteorPersent: 0, meteorSpeed: 1200, ballSpeed:1000, duration: Double(1.5)..<Double(2))
        for i in 0..<15 {
            if i > 8 || i < 5 {
                let startRange = Double(i * 2)
                let endRange = Double((i + 1) * 2)
                scheduleStarSpawn(range: startRange..<endRange)
            }
        }
        scheduleShieldSpawn(range: Double(10)..<Double(15))
    }
}
