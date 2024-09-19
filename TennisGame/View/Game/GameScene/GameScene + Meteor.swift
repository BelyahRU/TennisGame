
import Foundation
import UIKit
import SpriteKit

//MARK: - Meteor
extension GameScene {
    func spawnMeteor() {
        let randomAsteroidType = Int.random(in: 1...2) //two types
        var maxSize: CGFloat = 0 //it depends on random
        
        var meteor: SKSpriteNode = setupMeteorSpriteNode(randomMeteorType: randomAsteroidType, maxSize: &maxSize)
        
        setupMeteorTexture(meteor: &meteor, maxSize: maxSize)
        
        meteor.physicsBody?.categoryBitMask = meteorCategory
        meteor.physicsBody?.contactTestBitMask = racketCategory
        meteor.physicsBody?.collisionBitMask = 0
        meteor.physicsBody?.affectedByGravity = true
        meteor.physicsBody?.restitution = 0
        meteor.physicsBody?.linearDamping = 0.5
        
        meteor.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height + 200)
        
        addChild(meteor)
    }
    
    func setupMeteorSpriteNode(randomMeteorType: Int, maxSize: inout CGFloat) -> SKSpriteNode {
        var meteor: SKSpriteNode
        if randomMeteorType == 1 {
            meteor = SKSpriteNode(imageNamed: Resources.MeteorImages.meteor1)
            maxSize = CGFloat(Int.random(in: 100...150))
        } else {
            meteor = SKSpriteNode(imageNamed: Resources.MeteorImages.meteor2)
            maxSize = CGFloat(Int.random(in: 150...250))
        }
        return meteor
    }
    
    //MARK: - Texture
    func setupMeteorTexture(meteor: inout SKSpriteNode, maxSize: CGFloat) {
        if let texture = meteor.texture {
            let textureSize = texture.size()
            
            let aspectRatio = textureSize.width / textureSize.height
            if textureSize.width > maxSize || textureSize.height > maxSize {
                
                if textureSize.width > textureSize.height {
                    meteor.size = CGSize(width: maxSize, height: maxSize / aspectRatio)
                } else {
                    meteor.size = CGSize(width: maxSize * aspectRatio, height: maxSize)
                }
            } else {
                //original size
                meteor.size = textureSize
            }
            
            meteor.physicsBody = SKPhysicsBody(texture: texture, size: meteor.size)
        }
    }
}
