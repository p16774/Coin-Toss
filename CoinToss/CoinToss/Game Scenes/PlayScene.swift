//
//  GameScene.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/8/16.
//  Copyright (c) 2016 Nathan Wharry. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        
        // setup the objects layer to hold the moveable game elements
        objectsLayer = SKNode()
        objectsLayer.name = "Objects Layer"
        addChild(objectsLayer)
        
        // setup our contact mask
        physicsWorld.contactDelegate = self
        
        // create the background image and placement
        bgImage.size = self.frame.size
        bgImage.position = CGPointZero
        bgImage.anchorPoint = CGPointZero
        bgImage.zPosition = layers.backLevel
        bgImage2.size = self.frame.size
        bgImage2.position = CGPointMake(bgImage2.size.width-1, 0)
        bgImage2.anchorPoint = CGPointZero
        bgImage2.zPosition = layers.backLevel
        
        // create walkingpath image that sits over the background
        walkingPath.size = self.frame.size
        walkingPath.position = CGPointZero
        walkingPath.anchorPoint = CGPointZero
        walkingPath.zPosition = layers.groundLevel
        walkingPath2.size = self.frame.size
        walkingPath2.position = CGPointMake(walkingPath2.size.width-1, 0)
        walkingPath2.anchorPoint = CGPointZero
        walkingPath2.zPosition = layers.groundLevel
        
        // create the start button
        pauseBtn = SKSpriteNode(imageNamed: "button.png")
        pauseBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        pauseBtn.zPosition = layers.buttonLevel
        pauseBtn.name = "pausegame"
        
        // create the start button label
        pauseLabel = SKLabelNode(fontNamed: "Charcoal")
        pauseLabel.text = "Pause Game"
        pauseLabel.fontSize = 25
        pauseLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        pauseLabel.zPosition = layers.buttonLevel + 1
        pauseLabel.name = "pausegame"
        
        // setup the score display
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Distance: "
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPointMake(80, self.frame.height-50)
        scoreLabel.zPosition = layers.gameLevel + 1
        scoreLabel.name = "scorelabel"
        
        // setup the display of the actual score
        scoreTotal = SKLabelNode(fontNamed: "Chalkduster")
        scoreTotal.text = "\(distanceRan)"
        scoreTotal.fontSize = 20
        scoreTotal.position = CGPointMake(210, self.frame.height-50)
        
        // set up the highscore
        let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.fontSize = 20
        highScoreLabel.position = CGPointMake(scoreLabel.position.x + 50, scoreLabel.position.y - 100)
        highScoreLabel.zPosition = layers.buttonLevel + 1
        highScoreLabel.name = "highscore"
        
        // create the highscore backing
        let highScoreBtn = SKSpriteNode(imageNamed: "button.png")
        highScoreBtn.position = CGPointMake(highScoreLabel.position.x, highScoreLabel.position.y + 10)
        highScoreBtn.zPosition = layers.buttonLevel
        highScoreBtn.name = "highscore"
        
        // setup the coins display
        coinLabel = SKLabelNode(fontNamed: "Chalkduster")
        coinLabel.text = "Coins Earned: "
        coinLabel.fontSize = 20
        coinLabel.position = CGPointMake(scoreTotal.position.x + 200, self.frame.height-50)
        coinLabel.zPosition = layers.gameLevel + 1
        coinLabel.name = "coinlabel"
        
        // setup the display of the coins earned this run
        earnedCoins = SKLabelNode(fontNamed: "Chalkduster")
        earnedCoins.text = "\(coinsEarned)"
        earnedCoins.fontSize = 20
        earnedCoins.position = CGPointMake(coinLabel.position.x + 130, self.frame.height-50)
        
        // setup the total coins display
        totalCoinsLabel = SKLabelNode(fontNamed: "Chalkduster")
        totalCoinsLabel.text = "Coin Balance: "
        totalCoinsLabel.fontSize = 20
        totalCoinsLabel.position = CGPointMake(earnedCoins.position.x + 200, self.frame.height-50)
        totalCoinsLabel.zPosition = layers.gameLevel + 1
        totalCoinsLabel.name = "totalcoinslabel"
        
        // setup the display of the actual score
        totalCoinsOwned = SKLabelNode(fontNamed: "Chalkduster")
        totalCoinsOwned.text = "\(coinAmountHave)"
        totalCoinsOwned.fontSize = 20
        totalCoinsOwned.position = CGPointMake(totalCoinsLabel.position.x + 130, self.frame.height-50)
        
        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        objectsLayer.addChild(pauseLabel)
        objectsLayer.addChild(pauseBtn)
        objectsLayer.addChild(scoreLabel)
        objectsLayer.addChild(scoreTotal)
        objectsLayer.addChild(coinLabel)
        objectsLayer.addChild(earnedCoins)
        objectsLayer.addChild(totalCoinsLabel)
        objectsLayer.addChild(totalCoinsOwned)
        objectsLayer.addChild(highScoreLabel)
        objectsLayer.addChild(highScoreBtn)
        
        startGameElements()
    }
    
    // MARK: Initial Game Elements
    
    // add enemies to the scene
    func addEnemy(enemyLevel:Int) {
        
        // set speed that enemy shows up based on distance run
        enemySpeed = Double(distanceRan/300)
        
        // check to make sure our Speed is not greater than 3
        if enemySpeed >= 2.5 { enemySpeed = 2.5 }
        
        let activateEnemies = SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock({ self.spawnEnemy(enemyPosition, level: enemyLevel) }),
                SKAction.waitForDuration(3.0 - enemySpeed)
                ]))
        
        runAction(activateEnemies, withKey: "Spawn Enemy")
        
    }
    
    func startGameElements() {
        
        // start the player running
        
        /**                          **/
        /* Player Character Animation */
        /**                          **/
        
        /* Player Animation */
        // set the character sizing
        let charTexture = SKTexture(imageNamed: "player")
        let xSizeChar = charTexture.size().width*0.49
        let ySizeChar = charTexture.size().height*scale
        
        // create the texture atlas array
        var playerWalk = [SKTexture]()
        let numImages = playerTexture.textureNames.count
        for i in 0 ..< numImages {
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
        
        
        // run the addEnemy function to spawn enemies
        addEnemy(1)
        
        /**                                 **/
        /* Start the Game Animation Elements */
        /**                                 **/
        
        animateChar(player, frames: playerWalking, key: "animateWalkChar")
        
        
    }
    
    // MARK: Game Functions
    
    // function to spawn an enemy
    func spawnEnemy(at: CGPoint, level: Int) {
        
        // create enemy and spawn at starting location
        let newEnemy = enemy()
        newEnemy.position = at
        newEnemy.health = 4 + level
        self.addChild(newEnemy)
        
    }
    
    // function to check enemy health levels
    func enemyHit(enemyItem: enemy,bulletItem: bullet) {
        
        // remove elements
        if enemyItem.health <= 0 {
            enemyItem.removeFromParent()
        } else {
            enemyItem.health = enemyItem.health - bulletItem.damage
            //addScore()
        }
        
        bulletItem.removeFromParent()
        
        //print("\(enemy) was hit by the \(bullet)")
        
    }
    
    // function to pause the game
    func pauseGame(value: Bool) {
        
        // set the game state based on the boolean passed
        self.view!.paused = value
        
    }
    
    // MARK: Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // set up which touch we are getting
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        // verify the game is not paused before running game functions
        if !self.view!.paused {
            
            if touchedNode.name == "pausegame" {
                
                // add in our resume game option
                pauseLabel.text = "Resume Game"
                pauseLabel.name = "resumegame"
                pauseBtn.name = "resumegame"
                
                // pause the game - function needed to update before pausing correctly
                self.runAction(SKAction.runBlock({ self.pauseGame(true) }))
                
            } else {
                
                // shoot the projectile
                newPlayer.shoot()
                
            }
            
        } else {
            
            // run our resume functions
            if touchedNode.name == "resumegame" {
                
                // unpause the view first for the game to update the view properly
                self.view!.paused = false
                
                // add in our resume game option
                pauseLabel.text = "Pause Game"
                pauseLabel.name = "pausegame"
                pauseBtn.name = "pausegame"
                
            }
        }
        
    }
    
    // MARK: Collision Checks
    
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
                
                if firstBody.contactTestBitMask == enemyCategory {
                    
                    let firstContact = firstBody.node as! SKSpriteNode
                    let secondContact = secondBody.node as! SKSpriteNode
                    
                    // remove the bullet
                    secondContact.removeFromParent()
                    
                    // check to see if we can remove the enemy or not
                    //var enemyNode = firstContact as! enemy
                    firstContact.removeFromParent()
                    
                    // add our coin values
                    coinsEarned += enemyRewardTotal
                    earnedCoins.text = "\(coinsEarned)"
                
                    
                } else if firstBody.contactTestBitMask == bulletCategory {
                    
                    let secondContact = firstBody.node as! SKSpriteNode
                    let firstContact = secondBody.node as! SKSpriteNode
                    
                    // remove bullet
                    secondContact.removeFromParent()
                    
                    // check to see if we can remove the enemy
                    //var enemyNode = firstContact as! enemy
                    firstContact.removeFromParent()
                    
                    // add our coin values
                    coinsEarned += enemyRewardTotal
                    earnedCoins.text = "\(coinsEarned)"
                    
                }
                
                
            case enemyCategory | playerCategory:
                
                // Here we don't care which body is which, the scene is ending
                
                // remove elements to prevent this from running multiple times
                let firstNode = firstBody.node as! SKSpriteNode
                let secondNode = secondBody.node as! SKSpriteNode
                firstNode.removeFromParent()
                secondNode.removeFromParent()
                
                // remove current scene
                self.removeAllChildren()
                self.removeAllActions()
                self.scene?.removeFromParent()
                self.removeFromParent()
                
                // calculate distance coin function ??
                
                // set the highscrore if met
                if distanceRan > highScore { highScore = distanceRan }
                
                // add the coins earned on the run to the total amount
                coinAmountHave += coinsEarned
                
                // Transition to the Game Over Scene
                gameScene = UpgradeScene(size: scene!.size)
                let transition = SKTransition.crossFadeWithDuration(0.3)
                gameScene!.scaleMode = .AspectFill
                self.scene!.view?.presentScene(gameScene, transition: transition)
                
                
            case bulletCategory | worldCategory:
                
                // remove the coin element only
                if contact.bodyA.categoryBitMask == bulletCategory {
                    
                    // assign bullet as first contact
                    let firstNode = firstBody.node as! SKSpriteNode
                    
                    // remove elements
                    firstNode.removeFromParent()
                    
                } else {
                    
                    // assign bullet as first contact
                    let firstNode = secondBody.node as! SKSpriteNode
                    
                    //remove elements
                    firstNode.removeFromParent()
                    
                }
                
                
            default:
                
                // assigning default in case a different collision happens during testing
                fatalError("other collision: \(contactMask)")
            }
        }
    }

    // MARK: Frame Updates
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // set our lastUpdatedTime variable to an initial value upon Game start
        if lastUpdatedTime == nil { lastUpdatedTime = currentTime }
        let timeUpdate = currentTime - lastUpdatedTime

        // calculate our distance based on a time element for updated frames and change displayed distance
        distanceRan += 0.25
        let totalDistance = Int(round(distanceRan))  // rounding to make the distance a whole number for easier display
        scoreTotal.text = "\(totalDistance)"
        
        // reset the enemy speed based on distance ran
        if timeUpdate > 30 {
            
            removeActionForKey("Spawn Enemy")
            addEnemy(1)
            
            lastUpdatedTime = currentTime
            
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
