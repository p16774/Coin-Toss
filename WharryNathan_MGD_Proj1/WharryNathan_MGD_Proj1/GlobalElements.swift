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

// set up the global variables allowed to be used in every function or section of the gamescene
let bgImage = SKSpriteNode(imageNamed: "bgimage.png")
let bgImage2 = SKSpriteNode(imageNamed: "bgimage.png")
let walkingPath = SKSpriteNode(imageNamed: "walkingpath.png")
let walkingPath2 = SKSpriteNode(imageNamed: "walkingpath.png")
let creditsImage = SKSpriteNode(imageNamed: "button.png")
var startGame : Bool = false
var healthBar : SKSpriteNode!
var player : SKSpriteNode!
var enemies : SKSpriteNode!
var bulletNode : SKSpriteNode!
var playerWalking : [SKTexture]!
var enemyWalking : [SKTexture]!
var creditsText : SKLabelNode!
var creditsText1 : SKLabelNode!
var creditsText2 : SKLabelNode!
var creditsText3 : SKLabelNode!
var creditsText4 : SKLabelNode!
var creditsText5 : SKLabelNode!
var instructionsBtn : SKSpriteNode!
var instructionsLabel : SKLabelNode!
var creditsBtn : SKSpriteNode!
var creditsLabel : SKLabelNode!
var startBtn : SKSpriteNode!
var startLabel : SKLabelNode!
var stopBtn : SKSpriteNode!
var stopLabel : SKSpriteNode!
var pauseBtn : SKSpriteNode!
var pauseLabel : SKLabelNode!
var resumeBtn : SKSpriteNode!
var resumeLabel : SKLabelNode!
var restartBtn : SKSpriteNode!
var restartLabel : SKLabelNode!
var scoreLabel : SKLabelNode!
var scoreTotal : SKLabelNode!
var scoreNum : Int! = 0

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

// function to add value to the score
func addScore() {
    
    // add 1
    scoreNum = scoreNum + 1
    
    // update score displayed
    scoreTotal.text = "\(scoreNum)"
    
    
}

// reset score
func resetScore() {
    
    // add 1
    scoreNum = 0
    
    // update score displayed
    scoreTotal.text = "\(scoreNum)"
    
}

// display the instructions
func displayOverlay(value: Bool, type: String) {
    
    // check for type of display - instructions or credits
    if type == "instructions" {
        
        if value == true {
            
            // add the background
            objectsLayer.addChild(creditsImage)
            
            // create the instructions text
            creditsText = SKLabelNode(fontNamed: "Chalkduster")
            creditsText.text = "Instructions:                tap to close"
            creditsText.horizontalAlignmentMode = .Left
            creditsText.position = CGPointMake(160, gameScene.frame.height-265)
            creditsText.fontSize = 30
            creditsText.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText1 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText1.text = "Tap Screen to Throw Coin"
            creditsText1.horizontalAlignmentMode = .Left
            creditsText1.position = CGPointMake(creditsText.position.x - 30, creditsText.position.y - 50)
            creditsText1.fontSize = 30
            creditsText1.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText2 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText2.text = "Use Coins to Attack incoming Ninjas"
            creditsText2.horizontalAlignmentMode = .Left
            creditsText2.position = CGPointMake(creditsText1.position.x, creditsText1.position.y - 50)
            creditsText2.fontSize = 30
            creditsText2.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText3 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText3.text = "Get 1 point for each enemy defeated"
            creditsText3.horizontalAlignmentMode = .Left
            creditsText3.position = CGPointMake(creditsText2.position.x, creditsText2.position.y - 50)
            creditsText3.fontSize = 30
            creditsText3.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText4 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText4.text = "Score 50 points and win the game"
            creditsText4.horizontalAlignmentMode = .Left
            creditsText4.position = CGPointMake(creditsText3.position.x, creditsText3.position.y - 50)
            creditsText4.fontSize = 30
            creditsText4.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText5 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText5.text = "But don't let them touch you or Game Over!"
            creditsText5.horizontalAlignmentMode = .Left
            creditsText5.position = CGPointMake(creditsText4.position.x, creditsText4.position.y - 50)
            creditsText5.fontSize = 30
            creditsText5.zPosition = layers.buttonLevel+61
            
            objectsLayer.addChild(creditsText)
            objectsLayer.addChild(creditsText1)
            objectsLayer.addChild(creditsText2)
            objectsLayer.addChild(creditsText3)
            objectsLayer.addChild(creditsText4)
            objectsLayer.addChild(creditsText5)
            
        } else if value == false {
            
            // remove all instructions objects
            creditsImage.removeFromParent()
            creditsText.removeFromParent()
            creditsText1.removeFromParent()
            creditsText2.removeFromParent()
            creditsText3.removeFromParent()
            creditsText4.removeFromParent()
            creditsText5.removeFromParent()
            
        } else {
            
            // this should never happen, but if it does - do NOTHING
            
        }
    
    } else if type == "credits" {
        
        if value == true {
            
            // add the credit background
            objectsLayer.addChild(creditsImage)
            
            // display the credits
            creditsText = SKLabelNode(fontNamed: "Chalkduster")
            creditsText.text = "Credits:"
            creditsText.horizontalAlignmentMode = .Left
            creditsText.position = CGPointMake(100, gameScene.frame.height-265)
            creditsText.fontSize = 30
            creditsText.zPosition = layers.buttonLevel+61
            
            creditsText1 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText1.text = "All code written and tested by Nathan Wharry"
            creditsText1.horizontalAlignmentMode = .Left
            creditsText1.position = CGPointMake(creditsText.position.x - 50, creditsText.position.y - 50)
            creditsText1.fontSize = 30
            creditsText1.zPosition = layers.buttonLevel+61
            
            creditsText2 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText2.text = "All images taken from http://opengameart.org/"
            creditsText2.horizontalAlignmentMode = .Left
            creditsText2.position = CGPointMake(creditsText1.position.x, creditsText1.position.y - 50)
            creditsText2.fontSize = 30
            creditsText2.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText3 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText3.text = "Animations authored by http://www.gameart2d.com/"
            creditsText3.horizontalAlignmentMode = .Left
            creditsText3.position = CGPointMake(creditsText2.position.x, creditsText2.position.y - 50)
            creditsText3.fontSize = 30
            creditsText3.zPosition = layers.buttonLevel+61
            
            // create the instructions line 1 text
            creditsText4 = SKLabelNode(fontNamed: "Chalkduster")
            creditsText4.text = "Tap anywhere to return to game"
            creditsText4.horizontalAlignmentMode = .Left
            creditsText4.position = CGPointMake(creditsText3.position.x, creditsText3.position.y - 100)
            creditsText4.fontSize = 30
            creditsText4.zPosition = layers.buttonLevel+61
            
            // add elements to the scene
            objectsLayer.addChild(creditsText)
            objectsLayer.addChild(creditsText1)
            objectsLayer.addChild(creditsText2)
            objectsLayer.addChild(creditsText3)
            objectsLayer.addChild(creditsText4)
            
        } else if value == false {
            
            // remove all credits objects
            creditsImage.removeFromParent()
            creditsText.removeFromParent()
            creditsText1.removeFromParent()
            creditsText2.removeFromParent()
            creditsText3.removeFromParent()
            creditsText4.removeFromParent()
            
        } else {
            
            // go away, you shouldn't be here
        }
        
    } else {
        
        // nothing to see here, please keep moving
    }
    
        
}


