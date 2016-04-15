//
//  GameScene.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/8/16.
//  Copyright (c) 2016 Nathan Wharry. All rights reserved.
//

import SpriteKit
import Foundation

// set up the alert messaging protocol to display messages on upgrade purchase
protocol ViewControllerDelegate
{
    func sendMessage(message:String);
}


class UpgradeScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        // setup the objects layer to hold the moveable game elements
        objectsLayer = SKNode()
        objectsLayer.name = "Objects Layer"
        addChild(objectsLayer)
        
        // create the background "dimming" effect with an image size
        creditsImage.size = self.frame.size
        creditsImage.anchorPoint = CGPointZero
        creditsImage.zPosition = layers.buttonLevel-1
        
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
        startBtn.position = CGPointMake(self.frame.width/4, self.frame.height/4)
        startBtn.zPosition = layers.buttonLevel
        startBtn.name = "endgame"
        
        // create the start button label
        startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "New Run"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/4, (self.frame.height/4)-10)
        startLabel.zPosition = layers.buttonLevel + 1
        startLabel.name = "newgame"

        
// MARK: Improvement Buttons
        
        // Coin Upgrade
        let coinUpgrade = SKLabelNode(fontNamed: "Charcoal")
        coinUpgrade.text = "Upgrade Coin"
        coinUpgrade.fontSize = 20
        coinUpgrade.position = CGPointMake(self.frame.width/4, ((self.frame.height/4)*3)-8)
        coinUpgrade.zPosition = layers.buttonLevel+1
        coinUpgrade.name = "coinupgrade"
        
        let coinBtn = SKSpriteNode(imageNamed: "button.png")
        coinBtn.position = CGPointMake(self.frame.width/4, (self.frame.height/4)*3)
        coinBtn.zPosition = layers.buttonLevel
        coinBtn.name = "coinupgrade"
        
        // Reward Upgrade
        let rewardUpgrade = SKLabelNode(fontNamed: "Charcoal")
        rewardUpgrade.text = "Upgrade Reward"
        rewardUpgrade.fontSize = 20
        rewardUpgrade.position = CGPointMake((self.frame.width/4)*3, ((self.frame.height/4)*3)-8)
        rewardUpgrade.zPosition = layers.buttonLevel+1
        rewardUpgrade.name = "rewardupgrade"
        
        let rewardBtn = SKSpriteNode(imageNamed: "button.png")
        rewardBtn.position = CGPointMake((self.frame.width/4)*3, (self.frame.height/4)*3)
        rewardBtn.zPosition = layers.buttonLevel
        rewardBtn.name = "rewardupgrade"
        
        // Purchase Grenade
        let grenadePurchase = SKLabelNode(fontNamed: "Charcoal")
        grenadePurchase.text = "Purchase Grenade"
        grenadePurchase.fontSize = 20
        grenadePurchase.position = CGPointMake((self.frame.width/4)*3, (self.frame.height/4)-8)
        grenadePurchase.zPosition = layers.buttonLevel+1
        grenadePurchase.name = "purchasegrenade"
        
        let grenadeBtn = SKSpriteNode(imageNamed: "button.png")
        grenadeBtn.position = CGPointMake((self.frame.width/4)*3, self.frame.height/4)
        grenadeBtn.zPosition = layers.buttonLevel
        grenadeBtn.name = "purchasegrenade"
        

// MARK: Improvement Cost Labels
        
        // coin improvement
        let coinCost = SKLabelNode(fontNamed: "Charcoal")
        coinCost.text = "\(coinUpgradePrice) coins (damage increased by 1)"
        coinCost.fontSize = 18
        coinCost.position = CGPointMake(coinBtn.position.x, coinBtn.position.y - 50)
        coinCost.zPosition = layers.buttonLevel + 1
        coinCost.name = "coinimprovementcost"
        
        // reward upgrade
        let rewardCost = SKLabelNode(fontNamed: "Charcoal")
        rewardCost.text = "\(rewardUpgradePrice) coins (coin reward increased by 1)"
        rewardCost.fontSize = 18
        rewardCost.position = CGPointMake(rewardBtn.position.x, rewardBtn.position.y - 50)
        rewardCost.zPosition = layers.buttonLevel + 1
        rewardCost.name = "rewardupgradecost"
        
        // grenade purchase
        let grenadeCost = SKLabelNode(fontNamed: "Charcoal")
        grenadeCost.text = "500 Coins (1 time use)"
        grenadeCost.fontSize = 18
        grenadeCost.position = CGPointMake(grenadeBtn.position.x, grenadeBtn.position.y - 50)
        grenadeCost.zPosition = layers.buttonLevel + 1
        grenadeCost.name = "grenadecost"
        

// MARK: Add Children
        
        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        objectsLayer.addChild(creditsImage)
        objectsLayer.addChild(startBtn)
        objectsLayer.addChild(startLabel)
        objectsLayer.addChild(coinUpgrade)
        objectsLayer.addChild(coinBtn)
        objectsLayer.addChild(coinCost)
        objectsLayer.addChild(rewardUpgrade)
        objectsLayer.addChild(rewardBtn)
        objectsLayer.addChild(rewardCost)
        objectsLayer.addChild(grenadePurchase)
        objectsLayer.addChild(grenadeBtn)
        objectsLayer.addChild(grenadeCost)
        
    }
    
    // function to display the alertcontroller
    func showAlert(header: String, message: String) {
        
        // populate our alert controller and display it
        let alertController = UIAlertController(title: "\(header)", message:
            "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        // display alert on the root viewcontroller (should only be 1)
        self.view?.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
// MARK: Begin Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // set up which touch we are getting
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        if touchedNode.name == "newgame" {
            
            // remove current scene
            self.removeAllChildren()
            self.removeAllActions()
            self.scene?.removeFromParent()
            self.removeFromParent()
            
            // reset the distance and run score
            distanceRan = 0
            coinsEarned = 0
            
            // Transition to the Game Over Scene
            gameScene = PlayScene(size: scene!.size)
            let transition = SKTransition.crossFadeWithDuration(0.3)
            gameScene!.scaleMode = .AspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        } else if touchedNode.name == "coinupgrade" {
            
            // verify if they have enough coins before purchase
            if coinAmountHave >= coinUpgradePrice {
                
                // reduce the amount of coins available
                coinAmountHave -= coinUpgradePrice
                
                // increase coin upgrade cost each purchase
                coinUpgradePrice += 50
                
                // increase the coin damage
                coinDamage += 1
                
                // display purchase sucess window
                showAlert("Coin Improvement", message: "Coin Damage increased to \(coinDamage)")

            } else {
                
                // display alert that you don't have enough coins
                showAlert("Coin Improvement", message: "Not enough coins. You need \(coinUpgradePrice-coinAmountHave) more coins.")
                
            }
            
        } else if touchedNode.name == "rewardupgrade" {
                
                // verify if they have enough coins before purchase
                if coinAmountHave >= rewardUpgradePrice {
                    
                    // reduce the amount of coins available
                    coinAmountHave -= rewardUpgradePrice
                    
                    // increase reward upgrade cost each purchase
                    rewardUpgradePrice += 100
                    
                    // increase the coin damage
                    enemyRewardTotal += 1
                    
                    // display purchase sucess window
                    showAlert("Reward Improvement", message: "Reward for killing enemies increased to \(enemyRewardTotal)")
                    
                } else {
                    
                    // display alert that you don't have enough coins
                    showAlert("Reward Improvement", message: "Not enough coins. You need \(rewardUpgradePrice-coinAmountHave) more coins.")
                    
                }
            
        } else if touchedNode.name == "purchasegrenade" {
            
            // verify if they have enough coins before purchase
            if coinAmountHave >= grenadePurchasePrice {
                
                // reduce the amount of coins available
                coinAmountHave -= grenadePurchasePrice
                
                // report that you have a grenade
                hasGrenade = true
                
                // display purchase sucess window
                showAlert("Grenade Power-up", message: "You have purchased the Grenade special. Use it to clear the screen when you are overrun with enemies.")
                
            } else {
                
                // display alert that you don't have enough coins
                showAlert("Grenade Power-up", message: "Not enough coins. You need \(grenadePurchasePrice-coinAmountHave) more coins.")
                
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
        
    }
    
}
