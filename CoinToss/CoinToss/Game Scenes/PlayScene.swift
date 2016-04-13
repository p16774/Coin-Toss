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
        startBtn = SKSpriteNode(imageNamed: "button.png")
        startBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        startBtn.zPosition = layers.buttonLevel
        startBtn.name = "upgradegame"
        
        // create the start button label
        startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "Upgrade Game"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        startLabel.zPosition = layers.buttonLevel + 1
        startLabel.name = "upgradegame"
        
        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        objectsLayer.addChild(startBtn)
        objectsLayer.addChild(startLabel)
        
        startGameElements()
    }
    
    // MARK: Initial Game Elements
    
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
        
        // add enemies to the scene
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock({ self.spawnEnemy(enemyPosition, level: 1) }),
                SKAction.waitForDuration(3.0)
                ])
            ))
        
        
        
        /**                                 **/
        /* Start the Game Animation Elements */
        /**                                 **/
        
        animateChar(player, frames: playerWalking, key: "animateWalkChar")
        
        
    }
    
    // MARK: Game Functions
    
    func spawnEnemy(at: CGPoint, level: Int) {
        
        // create enemy and spawn at starting location
        let newEnemy = enemy()
        newEnemy.position = at
        newEnemy.health = 5
        self.addChild(newEnemy)
        
    }
    
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
    
    // MARK: Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* TURN THIS FUNCTION INTO A PAUSE BUTTON IF TIME ALLOWS */
        
        // set up which touch we are getting
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        if touchedNode.name == "upgradegame" {
            
            // remove current scene
            self.removeAllChildren()
            self.removeAllActions()
            self.scene?.removeFromParent()
            self.removeFromParent()
            
            // Transition to the Game Over Scene
            gameScene = UpgradeScene(size: scene!.size)
            let transition = SKTransition.crossFadeWithDuration(0.3)
            gameScene!.scaleMode = .AspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        } else {
            
            // shoot the projectile
            newPlayer.shoot()
            
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
                    var enemyNode = firstContact as! enemy
                    
                    
                
                    
                } else if firstBody.contactTestBitMask == bulletCategory {
                    
                    let secondContact = firstBody.node as! SKSpriteNode
                    let firstContact = secondBody.node as! SKSpriteNode
                    
                    // remove bullet
                    secondContact.removeFromParent()
                    
                    // check to see if we can remove the enemy
                    var enemyNode = firstContact as! enemy
                    
                    
                }
                
            case enemyCategory | playerCategory:
                
                // Here we don't care which body is which, the scene is ending
                
                // remove elements to prevent this from running multiple times
                let firstNode = firstBody.node as! SKSpriteNode
                let secondNode = secondBody.node as! SKSpriteNode
                firstNode.removeFromParent()
                secondNode.removeFromParent()
                
                // run the game over functions
                //gameOver()
                
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
