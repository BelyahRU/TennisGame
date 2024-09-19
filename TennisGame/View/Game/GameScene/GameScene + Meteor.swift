
import Foundation
import UIKit
import SpriteKit

// MARK: - Meteor
extension GameScene {
    func spawnMeteor() {
        let meteorType = getRandomMeteorType()
        let maxSize = getMaxSize(for: meteorType)
        
        let meteor = createMeteor(type: meteorType, maxSize: maxSize)
        setupMeteorPhysics(for: meteor)
        positionAndAddMeteor(meteor)
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
            meteor = SKSpriteNode() // Return an empty node if type is invalid
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
        var isValidPosition = false
        var position = CGPoint.zero
        
        while !isValidPosition {
            position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 200)
            isValidPosition = isPositionValid(position, existingNodes: children.filter {
                $0.physicsBody?.categoryBitMask == meteorCategory || $0.physicsBody?.categoryBitMask == ballCategory
            }, minDistance: minDistance)
        }
        
        meteor.position = position
        addChild(meteor)
    }
}
