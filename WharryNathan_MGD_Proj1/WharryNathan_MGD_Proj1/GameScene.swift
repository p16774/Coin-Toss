//
//  GameScene.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 11/29/15.
//  Copyright (c) 2015 Nathan Wharry. All rights reserved.
//

import SpriteKit
import AVFoundation
import AVKit

class GameScene: SKScene {
    
    // set up the global variables allowed to be used in every function or section of the gamescene
    let bgImage = SKSpriteNode(imageNamed: "bgimage.png")
    let bgImage2 = SKSpriteNode(imageNamed: "bgimage.png")
    let walkingPath = SKSpriteNode(imageNamed: "walkingpath.png")
    let walkingPath2 = SKSpriteNode(imageNamed: "walkingpath.png")
    var player : SKSpriteNode!
    var playerWalking : [SKTexture]!
    var startBtn = SKSpriteNode!()
    var startLabel = SKLabelNode!()
    var stopBtn = SKSpriteNode!()
    var stopLabel = SKSpriteNode!()
    
    // preload sounds to prevent initial pause
    let playSound = SKAction.playSoundFileNamed("startgame.mp3", waitForCompletion: false)
    
    // set our default player model to use globally
    let newPlayer = hero()
    let newBullet = hero()
    
    
    override func didMoveToView(view: SKView) {
    
        /* Setup for the scene */
        setupLayers()
        
        let appHeader = SKLabelNode(fontNamed:"Chalkduster")
        appHeader.text = "Nathan Wharry's SpriteKit";
        appHeader.fontSize = 45
        appHeader.verticalAlignmentMode = .Top
        appHeader.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height);
        
        // Create the world bounds to prevent objects going off screen and allowing collisions
        let gameBorder = SKPhysicsBody(edgeLoopFromRect: self.frame)
        gameBorder.friction = 0
        self.physicsBody = gameBorder
        
        // manipulate the background images
        bgImage.size = self.frame.size
        bgImage.position = CGPointZero
        bgImage.anchorPoint = CGPointZero
        bgImage.zPosition = layers.backLevel
        bgImage2.size = self.frame.size
        bgImage2.position = CGPointMake(bgImage2.size.width-1, 0)
        bgImage2.anchorPoint = CGPointZero
        bgImage2.zPosition = layers.backLevel

        
        // create walkingpath image
        walkingPath.size = self.frame.size
        walkingPath.position = CGPointZero
        walkingPath.anchorPoint = CGPointZero
        walkingPath.zPosition = layers.groundLevel
        walkingPath2.size = self.frame.size
        walkingPath2.position = CGPointMake(walkingPath2.size.width-1, 0)
        walkingPath2.anchorPoint = CGPointZero
        walkingPath2.zPosition = layers.groundLevel
        
        // add a sprite coin image
        let coinImage = SKSpriteNode(imageNamed: "coinage.png")
        coinImage.position = CGPointMake(300, 300)
        coinImage.zPosition = layers.gameLevel
        coinImage.name = "coin"
        
        // add second coin image for collision check
        let coinImage2 = SKSpriteNode(imageNamed: "coinage.png")
        coinImage2.position = CGPointMake(700, 300)
        coinImage2.zPosition = layers.gameLevel
        coinImage2.name = "bouncycoin"
        
        // create the coin physics body for collision check
        let coinPhysics = SKPhysicsBody(circleOfRadius: 18)
        coinPhysics.allowsRotation = false
        coinPhysics.affectedByGravity = true
        coinPhysics.friction = 0
        coinPhysics.restitution = 1
        coinPhysics.linearDamping = 0
        coinPhysics.angularDamping = 0
        
        // apply coin physics
        coinImage2.physicsBody = coinPhysics
        
        // add the coin label
        let coinLabel = SKLabelNode(fontNamed: "Arial")
        coinLabel.text = "Push coin for sound!"
        coinLabel.fontSize = 25
        coinLabel.position = CGPointMake(300, 320)
        coinLabel.zPosition = layers.gameLevel
        coinLabel.name = "coinlabel"
        
        // create the start button
        startBtn = SKSpriteNode(imageNamed: "button.png")
        startBtn.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-200)
        startBtn.zPosition = layers.gameLevel
        startBtn.name = "startgame"
        
        // create the start button label
        startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "Start Game"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-210)
        startLabel.zPosition = layers.gameLevel + 1
        startLabel.name = "startgame"
        
        /**                **/
        /* Bullet Animation */
        /**                **/
        
        let bulletDuration : Double = 5
        let bulletPath = SKAction.moveToX(self.frame.width + 30, duration: bulletDuration)
        coinImage.runAction(bulletPath)
        // loop image in the "update" section below to bring the coin back and send it off the screen again
        
        

        /* Add Elements to the GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        self.addChild(coinImage)
        self.addChild(coinLabel)
        self.addChild(coinImage2)
        self.addChild(startBtn)
        self.addChild(startLabel)
        self.addChild(appHeader)
        spawnPlayer(playerPosition)
        
    }
    
    func spawnPlayer(at: CGPoint) {
        
        newPlayer.position = at
        objectsLayer.addChild(newPlayer)
        
    }
    
    func spawnEnemy(at: CGPoint, level: Int) {
        
        
    }
    
    func startGameElements() {
        
        // start the player running
        
        /**                          **/
        /* Player Character Animation */
        /**                          **/
        
        // set the character sizing
        let texture = SKTexture(imageNamed: "player")
        let xSize = texture.size().width*0.49
        let ySize = texture.size().height*scale
        
        // create the texture atlas array
        var playerWalk = [SKTexture]()
        let numImages = playerTexture.textureNames.count
        for var i=0; i<numImages; i++ {
            let playerTextureName = "Run__00\(i)"
            playerWalk.append(playerTexture.textureNamed(playerTextureName))
        }
        
        // set up the running player character
        playerWalking = playerWalk
        let playerFirstFrame = playerWalking[0]
        player = SKSpriteNode(texture: playerFirstFrame)
        player.position = playerPosition
        player.name = "gameChar"
        player.size = CGSize(width: xSize, height: ySize)
        player.zPosition = layers.playerLevel
        addChild(player)
        
        
        
        
        /**                                 **/
        /* Start the Game Animation Elements */
        /**                                 **/

        animateChar(player, frames: playerWalking)
        
    }
    
    // function to create the Parent Node layers
    func setupLayers() {
        objectsLayer = SKNode()
        objectsLayer.name = "Objects Layer"
        addChild(objectsLayer)
    }
    
    // function to remove specific nodes by name
    func removeSprite(name: SKNode, sprite: String) {
        name.enumerateChildNodesWithName(sprite, usingBlock: { (node, stop) -> Void in
            if let spriteNode = node as? SKSpriteNode {
                 print("hello")
                    spriteNode.removeFromParent()
            }
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        //var audioPlayer: AVAudioPlayer = AVAudioPlayer()
            
            // set up which touch we are getting
            let touch = touches.first! as UITouch
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
        
            // function to play audio
            func playAudio(name: String) {
            
                let playSound = SKAction.playSoundFileNamed(name, waitForCompletion: false)
                runAction(playSound)
            
            }
        
            // check for touched location name
            if touchedNode.name == "startgame" {
                
                // setup the start sound
                playAudio("startgame.mp3")

                
                // hide the game buttons and remove the starting character
                startBtn.hidden = true
                startLabel.hidden = true
                removeSprite(newPlayer, sprite: "startPlayer")
                
                // start the game animation
                startGameElements()
                
                
            } else if touchedNode.name == "coin" {
                
                // play file
                playAudio("coins.mp3")
                
            } else {
                
                // make sure the game is actually running before performing the game element functions
                if startBtn.hidden {
                    
                    // setup the bullet sound
                    playAudio("pewpew.mp3")
                    
                    newPlayer.hidden = false
                    
                    /* rewrite to make the standing man disappear */
                    
                    // run the bullet functions
                    newPlayer.shoot() /* I can't get this to show the sprite, but I can see the effects*/
                    
                }
                
            }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // set up our infinite scrolling
        bgImage.position = CGPoint(x: bgImage.position.x-2, y: bgImage.position.y)
        bgImage2.position = CGPoint(x: bgImage2.position.x-2, y: bgImage2.position.y)
        
        // validate positioning and then reset as needed to loop the background correctly for both bgImages
        if bgImage.position.x < -bgImage.size.width {
            
            // reset the bgImage image
            bgImage.position = CGPointMake(bgImage2.position.x + bgImage2.size.width, bgImage.position.y)
            
        }
        
        if bgImage2.position.x < -bgImage2.size.width {
            
            // reset the bgImage2 image
            bgImage2.position = CGPointMake(bgImage.position.x + bgImage.size.width, bgImage2.position.y)
            
        }
        
        // code check to make sure the game has started before scrolling the walkingPath
        if startBtn.hidden {
            
            // set up our infinite scrolling for the walkingPath
            walkingPath.position = CGPoint(x: walkingPath.position.x-10, y: walkingPath.position.y)
            walkingPath2.position = CGPoint(x: walkingPath2.position.x-10, y: walkingPath2.position.y)
            
            // validate positioning and then reset as needed to loop the path correctly for both walkingPath images
            if walkingPath.position.x < -walkingPath.size.width {
                
                // reset the walkingPath image
                walkingPath.position = CGPointMake(walkingPath2.position.x + walkingPath2.size.width, walkingPath.position.y)
                
            }
            
            if walkingPath2.position.x < -walkingPath2.size.width {
                
                // reset the walkingPath2 image
                walkingPath2.position = CGPointMake(walkingPath.position.x + walkingPath.size.width, walkingPath2.position.y)
                
            }
            
            
        }
        
        
    }
}
