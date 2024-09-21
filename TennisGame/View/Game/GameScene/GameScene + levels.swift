
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    func setupLevel(for num: Int) {
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
    
    //speed
    
    //1
    func setupFirstLevel() {
        //        setupMeteorBallSpawnWith(meteorPersent: 0.5, meteorSpeed: 3, ballSpeed: 4)
        //        DispatchQueue.main.async {
        //            self.scheduleHeartSpawn(range: Double(10)..<Double(15))
        //            self.scheduleShieldSpawn(range: Double(5)..<Double(10))
        //            self.scheduleStarSpawn(range: Double(15)..<Double(20))
        //        }
        setupMeteorBallSpawnWith(meteorPersent: 0.5, meteorSpeed: 0, ballSpeed: 0)
    }
    
    //2
    func setupSecondLevel() {
        setupMeteorBallSpawnWith(meteorPersent: 0.4, meteorSpeed: 400, ballSpeed: 1300)
//        self.scheduleHeartSpawn(range: Double(0)..<Double(5))
    }
    
    //3
    func setupThirdLevel() {
        
    }
    
    //4
    func setupFourthLevel() {
        
    }
    
    //5
    func setupFifthLevel() {
        
    }
    
    //6
    func setupSixthLevel() {
        
    }
    
    //7
    func setupSeventhLevel() {
        
    }
    
    //8
    func setupEightLevel() {
        
    }
    
    //9
    func setupNinthLevel() {
        
    }
}
