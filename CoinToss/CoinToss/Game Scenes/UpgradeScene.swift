//
//  GameScene.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/8/16.
//  Copyright (c) 2016 Nathan Wharry. All rights reserved.
//

import SpriteKit

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
        startBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        startBtn.zPosition = layers.buttonLevel
        startBtn.name = "endgame"
        
        // create the start button label
        startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "End Game"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        startLabel.zPosition = layers.buttonLevel + 1
        startLabel.name = "endgame"
        
        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        objectsLayer.addChild(creditsImage)
        objectsLayer.addChild(startBtn)
        objectsLayer.addChild(startLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // set up which touch we are getting
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        if touchedNode.name == "endgame" {
            
            // remove current scene
            self.removeAllChildren()
            self.removeAllActions()
            self.scene?.removeFromParent()
            self.removeFromParent()
            
            // Transition to the Game Over Scene
            gameScene = GameScene(size: scene!.size)
            let transition = SKTransition.crossFadeWithDuration(0.3)
            gameScene!.scaleMode = .AspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        } else {
            
            // shoot the projectile
            
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
