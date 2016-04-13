//
//  Enemy.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/3/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class enemy: character {
    
    override init() {
        
        
        super.init()   //  initialize the default values from the SuperClass ( character )
        
        // override any values here
        health = 5         //change the default scorePoints from 1 to 5
        
        /* Enemy Animation */
        // set the character sizing
        let texture = SKTexture(imageNamed: "enemy")
        let xSizeEnemy = texture.size().width*0.49
        let ySizeEnemy = texture.size().height*scale
        
        // create the texture atlas array
        var enemyWalk = [SKTexture]()
        let enemyNumImages = enemyTexture.textureNames.count
        for i in 0 ..< enemyNumImages {
            let enemyTextureName = "Run__00\(i)"
            enemyWalk.append(enemyTexture.textureNamed(enemyTextureName))
        }
        
        // set up the running enemy character
        enemyWalking = enemyWalk
        let enemyFirstFrame = enemyWalking[0]
        enemies = SKSpriteNode(texture: enemyFirstFrame)
        enemies.position = enemyPosition
        enemies.name = "gameChar"
        enemies.size = CGSize(width: xSizeEnemy, height: ySizeEnemy)
        enemies.zPosition = layers.playerLevel
        
        // add the physicsBody to validate collision
        enemies.physicsBody = SKPhysicsBody(rectangleOfSize: enemies.size)
        enemies.physicsBody?.dynamic = true
        enemies.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        enemies.physicsBody?.mass = 1.0
        enemies.physicsBody?.allowsRotation = false
        enemies.physicsBody?.restitution = 0
        enemies.physicsBody?.usesPreciseCollisionDetection = true
        enemies.physicsBody?.categoryBitMask = enemyCategory
        enemies.physicsBody?.contactTestBitMask = bulletCategory
        enemies.physicsBody?.collisionBitMask = noCategory
        enemies.name = "enemies"
        
        
        // add enemy to the scene and animate
        objectsLayer.addChild(enemies)
        animateChar(enemies, frames: enemyWalking, key: "animateWalkEnemy")
        
        // move our enemy placement across the screen
        // random function for when the enemy appears
        let enemyDuration : Double = 7
        let enemyPath = SKAction.moveToX(self.frame.width - 75, duration: enemyDuration)
        enemies.runAction(enemyPath)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
