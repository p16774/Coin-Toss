//
//  Bullet.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/10/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class bullet: projectile {
    
    override init() {
        
        // initialize the parent element
        super.init()
        
        // set our texture size to create the SKSpriteNode
        let xSize = playerBullet.size().width
        let ySize = playerBullet.size().height
        let size = CGSize(width: xSize, height: ySize)
        
        // create our bullet texture
        bulletNode = SKSpriteNode(texture: playerBullet, size: playerBullet.size())
        
        // create and populate our physicsBody parameters
        bulletNode.physicsBody = SKPhysicsBody(texture: playerBullet, size: size)
        bulletNode.physicsBody?.dynamic = true
        bulletNode.physicsBody?.affectedByGravity = false
        bulletNode.physicsBody?.mass = 0.1
        bulletNode.name = "projectile"
        bulletNode.physicsBody?.usesPreciseCollisionDetection = true
        bulletNode.physicsBody?.categoryBitMask = bulletCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = enemyCategory
        
        // assign our positioning and add element to the scene
        bulletNode.zPosition = layers.bulletLevel
        bulletNode.position = bulletPosition
        objectsLayer.addChild(bulletNode)
        
        // move the bullet across the screen
        let bulletDuration : Double = 2
        let bulletPath = SKAction.moveToX(gameScene.frame.width + 50, duration: bulletDuration)
        bulletNode.runAction(bulletPath)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
