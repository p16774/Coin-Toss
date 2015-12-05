//
//  GlobalElements.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/2/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import SpriteKit

/* Global Character Textures */

let playerTexture = SKTextureAtlas(named: "Player")
let enemyTexture = SKTextureAtlas(named: "Enemy")
let playerBullet = SKTexture(imageNamed: "coinage.png")


/* Global Game Elements */

// Create Node Objects to add multiple instances to one parent
var nodesToRemove = [SKNode]()
var objectsLayer: SKNode!

// GameScene and Player/Enemy Locations
var gameScene : SKScene!
var frameW = gameScene.frame.size.width
var frameH = gameScene.frame.size.height
let playerPosition = CGPoint(x: 200, y: (frameH/2) - 185)
let enemyPosition = CGPoint(x:  frameW-100, y: (frameH/2) - 185)

// scaling variable
let scale : CGFloat = 0.4

// assign zPositioning for the 3 layers of the game
struct layers {
    
    static let backLevel: CGFloat = -1
    static let groundLevel: CGFloat = 20
    static let gameLevel: CGFloat = 30
    static let playerLevel: CGFloat = 50
    static let enemyLevel: CGFloat = 50
    static let bulletLevel: CGFloat = 60
    
}

// function to make the player run
func animateChar(name: SKSpriteNode, frames: [SKTexture]) {
    //This is our general runAction method to make our player run
    name.runAction(SKAction.repeatActionForever(
        SKAction.animateWithTextures(frames,
            timePerFrame: 0.1,
            resize: false,
            restore: true)),
        withKey:"animateCharWalk")
}

// function to produce our bullet
func shoot() {
    
    let newBullet = bulletPlayer()
    newBullet.position = CGPoint(x: 50, y: 0)
    newBullet.zPosition = layers.bulletLevel
    objectsLayer.addChild(newBullet)
    newBullet.physicsBody?.velocity = CGVector(dx: 350, dy: 0)
    
}
