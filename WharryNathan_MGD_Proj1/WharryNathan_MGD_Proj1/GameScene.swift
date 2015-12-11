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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // set a display variable
    var reset : Bool = false
    
    
    override func didMoveToView(view: SKView) {
    
        /* Setup for the scene */
        
        // create our game layers
        setupLayers()
        
        // setup our contact mask
        self.physicsWorld.contactDelegate = self
        
        
        // create our game header
        let appHeader = SKLabelNode(fontNamed:"Chalkduster")
        appHeader.text = "Coin Attack";
        appHeader.fontSize = 45
        appHeader.verticalAlignmentMode = .Top
        appHeader.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height);
        
        // Create the world bounds to prevent objects going off screen and allowing collisions
        let gameBorder = SKPhysicsBody(edgeLoopFromRect: self.frame)
        gameBorder.friction = 0
        //self.physicsBody = gameBorder
        
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
        
        // setup the score display
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: "
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPointMake(80, self.frame.height-50)
        scoreLabel.zPosition = layers.gameLevel + 1
        scoreLabel.name = "scorelabel"
        
        // setup the display of the actual score
        scoreTotal = SKLabelNode(fontNamed: "Chalkduster")
        scoreTotal.text = "\(scoreNum)"
        scoreTotal.fontSize = 30
        scoreTotal.position = CGPointMake(165, self.frame.height-50)
        /* Not used for game
        
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
        
        */
        
        // create the start button
        startBtn = SKSpriteNode(imageNamed: "button.png")
        startBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        startBtn.zPosition = layers.buttonLevel
        startBtn.name = "startgame"
        
        // create the start button label
        startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "Start Game"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        startLabel.zPosition = layers.buttonLevel + 1
        startLabel.name = "startgame"
        
        // create the pause button
        pauseBtn = SKSpriteNode(imageNamed: "button.png")
        pauseBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        pauseBtn.zPosition = layers.buttonLevel
        pauseBtn.name = "pausegame"
        
        // create the pause button label
        pauseLabel = SKLabelNode(fontNamed: "Charcoal")
        pauseLabel.text = "Pause Game"
        pauseLabel.fontSize = 25
        pauseLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        pauseLabel.zPosition = layers.buttonLevel + 1
        pauseLabel.name = "pausegame"
        
        // create the pause button
        resumeBtn = SKSpriteNode(imageNamed: "button.png")
        resumeBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        resumeBtn.zPosition = layers.buttonLevel
        resumeBtn.name = "resumegame"
        
        // create the pause button label
        resumeLabel = SKLabelNode(fontNamed: "Charcoal")
        resumeLabel.text = "Resume Game"
        resumeLabel.fontSize = 25
        resumeLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        resumeLabel.zPosition = layers.buttonLevel + 1
        resumeLabel.name = "resumegame"
        
        /**                           **/
        /*  Original Bullet Animation  */
        /**                           **/
        
        //let bulletDuration : Double = 5
        //let bulletPath = SKAction.moveToX(self.frame.width + 30, duration: bulletDuration)
        //coinImage.runAction(bulletPath)
        // loop image in the "update" section below to bring the coin back and send it off the screen again
        

        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        
        /* Add Elements to the Objects Layer View of the GameScene */
        objectsLayer.addChild(scoreLabel)
        objectsLayer.addChild(scoreTotal)
        objectsLayer.addChild(startBtn)
        objectsLayer.addChild(startLabel)
        objectsLayer.addChild(appHeader)
        
    }
    
    func spawnPlayer(at: CGPoint) {
        
        // elements for creating the player character and adding to the view
        newPlayer.position = at  // not sure why this errors on restart - if I comment it out everything runs fine excep the starting player location
        objectsLayer.addChild(newPlayer)
        
    }
    
    func spawnEnemy(at: CGPoint, level: Int) {
        
        // create enemy and spawn at starting location
        let newEnemy = enemy()
        newEnemy.position = at
        newEnemy.health = 10 + level*3
        self.addChild(newEnemy)
        
    }
    
    func startGameElements() {
        
        // start the player running
        
        /**                          **/
        /* Player Character Animation */
        /**                          **/
        
        startGame = true
        
        /* Player Animation */
        // set the character sizing
        let charTexture = SKTexture(imageNamed: "player")
        let xSizeChar = charTexture.size().width*0.49
        let ySizeChar = charTexture.size().height*scale
        
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
        player.size = CGSize(width: xSizeChar, height: ySizeChar)
        player.zPosition = layers.playerLevel
        
        // add the physicsBody to validate collision
        player.physicsBody = SKPhysicsBody(texture: charTexture, size: player.size)
        player.physicsBody?.dynamic = true
        player.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        player.physicsBody?.mass = 1.0
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = enemyCategory
        player.physicsBody?.contactTestBitMask = enemyCategory
        player.name = "player"
        
        // add player to the scene
        objectsLayer.addChild(player)
        
        // add enemies to the scene
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock({ self.spawnEnemy(enemyPosition, level: 1) }),
                SKAction.waitForDuration(1.0)
                ])
            ))

        
        
        /**                                 **/
        /* Start the Game Animation Elements */
        /**                                 **/

        animateChar(player, frames: playerWalking, key: "animateWalkChar")
        
        
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
                    spriteNode.removeFromParent()
            }
        })
    }
    
    // function to pause the game
    func pauseGame(value: Bool) {
        
        // set the game state based on the boolean passed
        self.view!.paused = value
        
    }
    
    // function to end the game
    func gameOver() {
        
        // remove current scene
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        self.removeFromParent()
        
        // Transition to the Game Over Scene
        gameScene = LoseScene(size: scene!.size)
        let transition = SKTransition.crossFadeWithDuration(0.3)
        gameScene!.scaleMode = .AspectFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
        
    }
    
    // function to win the game
    func winGame() {
        
        // remove current scene
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        self.removeFromParent()
        
        // Transition to the Win Game Scene
        gameScene = WinScene(size: scene!.size)
        print(gameScene)
        let transition = SKTransition.crossFadeWithDuration(0.3)
        gameScene!.scaleMode = .AspectFill
        self.scene!.view?.presentScene(gameScene!, transition: transition)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            
        // set up which touch we are getting
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        // function to play audio
        func playAudio(name: String) {
            
            let playSound = SKAction.playSoundFileNamed(name, waitForCompletion: false)
            runAction(playSound)
        
        }
        
        // verify the game is not paused before running game functions
        if !self.view!.paused {
        
            // check for touched location name
            if touchedNode.name == "startgame" {
                
                // setup the start sound
                playAudio("startgame.mp3")

                
                // remove the start game buttons and starting character
                startBtn.removeFromParent()
                startLabel.removeFromParent()
                removeSprite(newPlayer, sprite: "startPlayer")
                
                // add the pause option
                objectsLayer.addChild(pauseBtn)
                objectsLayer.addChild(pauseLabel)
                
                // start the game animation
                startGameElements()
                
                
            } else if touchedNode.name == "pausegame" {
                
                // play file
                //playAudio("coins.mp3")    // record pause audio
                
                // remove our pause game option
                pauseBtn.removeFromParent()
                pauseLabel.removeFromParent()
                
                // add in our resume game option
                objectsLayer.addChild(resumeBtn)
                objectsLayer.addChild(resumeLabel)
                
                // pause the game - function needed to update before pausing correctly
                self.runAction(SKAction.runBlock({ self.pauseGame(true) }))
        
            } else {
                
                // make sure the game is actually running before performing the game element functions
                if startGame {
                    
                    // setup the bullet sound
                    playAudio("pewpew.mp3")
                    
                    // run the bullet functions
                    newPlayer.shoot()
                    
                }
                
            }
            
        } else {
            
            // run our resume functions
            if touchedNode.name == "resumegame" {
            
                // unpause the view first for the game to update the view properly
                self.view!.paused = false
            
                // remove our resume game option
                resumeBtn.removeFromParent()
                resumeLabel.removeFromParent()
            
                // add back in our pause option
                objectsLayer.addChild(pauseBtn)
                objectsLayer.addChild(pauseLabel)
                
            } else {
                
                // do nothing during the game being paused
                
            }
            
        }

    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        // assign the contacts
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        // create contactmask to define appropriate contact/collision
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // validate nil since there are extra collisions that are getting registered after the elements are getting removed
        if firstBody.node == nil || secondBody.node == nil {
            
            // nothing to see here, please move along
            
        } else {
            
            // evaluate the contact and perform appropriate code elements
            switch contactMask {
                
            case enemyCategory | bulletCategory:
                
                // assign the correct elements to remove as needed
                if contact.bodyA.categoryBitMask == bulletCategory {
                    
                    // assign bullet as first contact
                    let firstNode = firstBody.node as! SKSpriteNode
                    let secondNode = secondBody.node as! SKSpriteNode
                    
                    // remove elements
                    firstNode.removeFromParent()
                    secondNode.removeFromParent()
                    
                    // add up our score
                    addScore()
                    
                } else {
                    
                    // assign bullet as first contact
                    let firstNode = secondBody.node as! SKSpriteNode
                    let secondNode = firstBody.node as! SKSpriteNode
                    
                    //remove elements
                    firstNode.removeFromParent()
                    secondNode.removeFromParent()
                    addScore()
                    
                }
                
            case enemyCategory | playerCategory:
                
                // Here we don't care which body is which, the scene is ending
                
                // remove elements to prevent this from running multiple times
                let firstNode = firstBody.node as! SKSpriteNode
                let secondNode = secondBody.node as! SKSpriteNode
                firstNode.removeFromParent()
                secondNode.removeFromParent()
                
                // run the game over functions
                gameOver()
                
            default:
                
                // assigning default in case a different collision happens during testing
                fatalError("other collision: \(contactMask)")
            }
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // check reset and run appropriately
        if !reset {
            
            spawnPlayer(playerPosition)
            reset = true
            
        }
        
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
        if startGame {
            
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
        
        // check winning value and end game if total is reached (set to 50 points)
        if scoreNum >= 50 {
            
            // you win
            winGame()
            
        }
        
        
    }
}
