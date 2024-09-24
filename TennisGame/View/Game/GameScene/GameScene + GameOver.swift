
import Foundation
import UIKit
import SpriteKit

extension GameScene {
    // MARK: - Game over
    func gameOver() {
        print("gameOver")
        timer?.invalidate()
        isPaused = true
        guard lives != 0 else {
            showGameOverView(with: 0)
            return
        }
        let coefficient = Double(gotBalls) / Double(allBalls)
        print(coefficient, gotBalls, allBalls)
        if coefficient > 0.85 {
            //3 star
            showGameOverView(with: 3)
        } else if coefficient > 0.7 {
            showGameOverView(with: 2)
            //2 star
        } else if coefficient > 0.5 {
            showGameOverView(with: 1)
            //1 star
        } else {
            showGameOverView(with: 0)
            //level failed
        }
    }
    
    func showGameOverView(with stars: Int) {
        if gameOverView == nil {
            gameOverView = GameOverView(stars: stars, scores: score)

            gameOverView?.frame = CGRect(x: 0, y: 0, width: 290, height: 438)
//                            pauseView = PauseView()
            gameOverView?.center = CGPoint(x: size.width / 2, y: size.height / 2)

            gameOverView?.nextLevelButton.addTarget(self, action: #selector(setupNextLevel), for: .touchUpInside)
            gameOverView?.backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
            gameOverView?.restartButton.addTarget(self, action: #selector(restartLevel), for: .touchUpInside)
        }
        if let view = view {
            view.window?.rootViewController?.view.addSubview(gameOverView!)
        }
        
        //VIEWMODEL
        let level = viewModel.getLevel(by: currentLevel)!
        if level.stars < stars {
            let newLevelData = Level(num: level.num, stars: stars, isLocked: false)
            viewModel.updateLevel(level: newLevelData)
        }
        //unlock next
        if level.num + 1 <= 9 && stars > 0 {
            let nextLevel = viewModel.getLevel(by: level.num + 1)!
            if nextLevel.isLocked {
                let newLevelData = Level(num: nextLevel.num, stars: 0, isLocked: false)
                viewModel.updateLevel(level: newLevelData)
            }
        }
        
        //addScores
        viewModel.addScores(score)
    }
    
    @objc
    func setupNextLevel() {
        if pauseView != nil {
            pauseView?.removeFromSuperview()
            pauseView = nil
        }
        if gameOverView != nil {
            gameOverView?.removeFromSuperview()
            gameOverView = nil
        }
        
        if currentLevel == 9 {
            let scene = GameScene(size: size)
            scene.scaleMode = .aspectFit
            scene.currentLevel = 1
            scene.gameSceneDelegate = gameSceneDelegate
            view?.presentScene(scene)
        } else {
            currentLevel += 1
            let scene = GameScene(size: size)
            scene.scaleMode = .aspectFit
            scene.gameSceneDelegate = gameSceneDelegate
            scene.currentLevel = currentLevel
            view?.presentScene(scene)
        }
    }
    
    @objc
    func restartLevel() {
        let scene = GameScene(size: size)
        scene.scaleMode = .aspectFit
        scene.gameSceneDelegate = gameSceneDelegate
        scene.currentLevel = currentLevel
        view?.presentScene(scene)
        if pauseView != nil {
            pauseView?.removeFromSuperview()
            pauseView = nil
        }
        if gameOverView != nil {
            gameOverView?.removeFromSuperview()
            gameOverView = nil
        }
    }
}
