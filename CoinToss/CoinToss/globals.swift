//
//  globals.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/9/16.
//  Copyright © 2016 Nathan Wharry. All rights reserved.
//

import Foundation
import SpriteKit

/* Global Character Textures */

let playerTexture = SKTextureAtlas(named: "Player")
let enemyTexture = SKTextureAtlas(named: "Enemy")
let playerBullet = SKTexture(imageNamed: "coinage.png")


/* Global Game Elements */

// set up the global variables allowed to be used in every function or section of the gamescene
let bgImage = SKSpriteNode(imageNamed: "bgimage.png")
let bgImage2 = SKSpriteNode(imageNamed: "bgimage.png")
let walkingPath = SKSpriteNode(imageNamed: "walkingpath.png")
let walkingPath2 = SKSpriteNode(imageNamed: "walkingpath.png")
let creditsImage = SKSpriteNode(imageNamed: "button.png")
var startGame : Bool = false
var allowCollisions : Bool = true
var player : SKSpriteNode!
var enemies : SKSpriteNode!
var bulletNode : SKSpriteNode!
var playerWalking : [SKTexture]!
var enemyWalking : [SKTexture]!
var startBtn : SKSpriteNode!
var startLabel : SKLabelNode!
var coinImprovement : Int = 0

// set our default player model to use as our initial character view
let newPlayer = hero()
let newEnemy = enemy()
let newBullet = bullet()

// Create Node Objects to add multiple instances to one parent
var nodesToRemove = [SKNode]()
var objectsLayer: SKNode!

// GameScene and Player/Enemy Locations
var gameScene : SKScene!
var frameW = gameScene.frame.size.width
var frameH = gameScene.frame.size.height
let playerPosition = CGPoint(x: 200, y: (frameH/2) - 185)
let enemyPosition = CGPoint(x:  frameW+20, y: (frameH/2) - 195)
let bulletPosition = CGPoint(x: 200, y: (frameH/2) - 185)

// scaling variable
let scale : CGFloat = 0.4

// assign zPositioning for the layers of the game
struct layers {
    
    static let backLevel: CGFloat = -1
    static let groundLevel: CGFloat = 20
    static let gameLevel: CGFloat = 30
    static let playerLevel: CGFloat = 50
    static let enemyLevel: CGFloat = 50
    static let bulletLevel: CGFloat = 60
    static let buttonLevel: CGFloat = 80
    
}

// collision categories
let noCategory: UInt32 = 0x1 << 0
let bulletCategory: UInt32 = 0x1 << 1
let enemyCategory: UInt32 = 0x1 << 2
let playerCategory: UInt32 = 0x1 << 3
let worldCategory: UInt32 = 0x1 << 4

// function to make the player run
func animateChar(name: SKSpriteNode, frames: [SKTexture], key: String) {
    
    //This is our general runAction method to make our player run
    name.runAction(SKAction.repeatActionForever(
        SKAction.animateWithTextures(frames,
            timePerFrame: 0.1,
            resize: false,
            restore: true)),
                   withKey: key)
}
