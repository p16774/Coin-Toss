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

class enemy: character, pTargetable {
    
    var life = 10  // define the values required by the protocols used ( pTargetable here )
    
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
        for var i=0; i<enemyNumImages; i++ {
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
        enemies.physicsBody = SKPhysicsBody(texture: texture, size: enemies.size)
        enemies.physicsBody?.dynamic = true
        enemies.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        enemies.physicsBody?.mass = 1.0
        enemies.physicsBody?.allowsRotation = false
        enemies.physicsBody?.usesPreciseCollisionDetection = true
        enemies.physicsBody?.categoryBitMask = enemyCategory
        enemies.physicsBody?.contactTestBitMask = bulletCategory
        enemies.physicsBody?.collisionBitMask = bulletCategory
        enemies.name = "enemies"
        
        /*
        let texture = SKTexture(imageNamed: "player")
        let xSize = texture.size().width*scale                // Create The texture for the top ( visible sprite )
        let ySize = texture.size().height*scale
        let charSize = CGSize(width: xSize, height: ySize)
        */
        
        /*
        self.physicsBody = SKPhysicsBody(texture: texture, size: charSize)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        self.physicsBody?.mass = 1.0
        self.physicsBody?.allowsRotation = false
        self.name = "enemy"
        */
    
        
        // add enemy to the scene and animate
        objectsLayer.addChild(enemies)
        animateChar(enemies, frames: enemyWalking, key: "animateWalkEnemy")
        
        // move our enemy placement across the screen
        let enemyDuration : Double = 8
        let enemyPath = SKAction.moveToX(self.frame.width - 100, duration: enemyDuration)
        enemies.runAction(enemyPath)
        
        /*
        let top = SKSpriteNode(texture: texture, size: charSize)
        top.zPosition = layers.playerLevel
        top.name = "startEnemy"
        top.color = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        top.colorBlendFactor = 1.0
        // add the top sprite
        self.addChild(top)
        */
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func takeDmg(damage: Int) {
        life -= damage
        print("You lost \(damage) hit points")
        
        if life <= 0 {
            charIsDead()
            print("You are dead now")
        }
    }
    
    
    /* enemy will not need to shoot

    func shoot() {
        
        let newBullet = bulletPlayer()
        newBullet.position = CGPoint(x: 50, y: 0)
        self.addChild(newBullet)
        newBullet.physicsBody?.velocity = CGVector(dx: 350, dy: 0)
        
    }
    
    */
    
}
