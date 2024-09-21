
import Foundation
import UIKit
import SpriteKit

// MARK: - Meteor
extension GameScene {
    func spawnMeteor(speed: Int) {
        let meteorType = getRandomMeteorType()
        let maxSize = getMaxSize(for: meteorType)
        
        let meteor = createMeteor(type: meteorType, maxSize: maxSize)
        setupMeteorPhysics(for: meteor)
        positionAndAddMeteor(meteor)
        setupMeteorSpeed(with: speed, meteor: meteor)
    }
    
    //0 to 1300 - speed range
    private func setupMeteorSpeed(with speed: Int, meteor: SKSpriteNode) {
        //if speed == 0, then we use base speed
        if speed != 0 {
            meteor.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        }
    }
    
    private func getRandomMeteorType() -> Int {
        return Int.random(in: 1...2) // Two types of meteors
    }
    
    private func getMaxSize(for meteorType: Int) -> CGFloat {
        switch meteorType {
        case 1:
            return CGFloat(Int.random(in: 100...150))
        case 2:
            return CGFloat(Int.random(in: 150...250))
        default:
            return 0
        }
    }
    
    private func createMeteor(type meteorType: Int, maxSize: CGFloat) -> SKSpriteNode {
        var meteor: SKSpriteNode
        switch meteorType {
        case 1:
            meteor = SKSpriteNode(imageNamed: Resources.MeteorImages.meteor1)
        case 2:
            meteor = SKSpriteNode(imageNamed: Resources.MeteorImages.meteor2)
        default:
            meteor = SKSpriteNode(imageNamed: Resources.MeteorImages.meteor1)
        }
        configureMeteorSize(meteor: &meteor, maxSize: maxSize)
        return meteor
    }
    
    private func configureMeteorSize(meteor: inout SKSpriteNode, maxSize: CGFloat) {
        guard let texture = meteor.texture else { return }
        let textureSize = texture.size()
        let aspectRatio = textureSize.width / textureSize.height
        
        if textureSize.width > maxSize || textureSize.height > maxSize {
            meteor.size = (textureSize.width > textureSize.height)
                ? CGSize(width: maxSize, height: maxSize / aspectRatio)
                : CGSize(width: maxSize * aspectRatio, height: maxSize)
        } else {
            meteor.size = textureSize
        }
        
        meteor.physicsBody = SKPhysicsBody(texture: texture, size: meteor.size)
    }
    
    private func setupMeteorPhysics(for meteor: SKSpriteNode) {
        meteor.physicsBody?.categoryBitMask = meteorCategory
        meteor.physicsBody?.contactTestBitMask = racketCategory
        meteor.physicsBody?.collisionBitMask = 0
        meteor.physicsBody?.affectedByGravity = true
        meteor.physicsBody?.restitution = 0
        meteor.physicsBody?.linearDamping = 0.5
    }
    
    private func positionAndAddMeteor(_ meteor: SKSpriteNode) {
        let minDistance: CGFloat = 30
        let existingNodes = children.filter {
            $0.physicsBody?.categoryBitMask == ballCategory ||
            $0.physicsBody?.categoryBitMask == meteorCategory ||
            $0.physicsBody?.categoryBitMask == shieldCategory ||
            $0.physicsBody?.categoryBitMask == heartCategory ||
            $0.physicsBody?.categoryBitMask == starCategory
        }

        // Выполняем проверку в отдельном потоке
        DispatchQueue.global().async { [weak self] in
            print("setupMeteor")
            var isValidPosition = false
            var position = CGPoint.zero

            while !isValidPosition {
                let sizeW = self!.size.width
                let sizeH = self!.size.height
                position = CGPoint(x: CGFloat.random(in: 0.0...sizeW), y: sizeH - 200)
                isValidPosition = self?.isPositionValid(position, existingNodes: existingNodes, minDistance: minDistance) ?? false

                print("after")
            }

            // Обновляем позицию и добавляем метеорит в основном потоке
            DispatchQueue.main.async {
                meteor.position = position
                self?.addChild(meteor)
            }
        }
    }

    
}
