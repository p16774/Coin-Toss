//
//  WinScene.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/10/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import SpriteKit
import AVFoundation
import AVKit

class WinScene: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        
        /* Setup for the scene */
        
        // create our game layers
        setupLayers()
        
        // create our game header
        let appHeader = SKLabelNode(fontNamed:"Chalkduster")
        appHeader.text = "Coin Attack";
        appHeader.fontSize = 45
        appHeader.verticalAlignmentMode = .Top
        appHeader.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height);
        
        // create our game win message
        let gameMessage = SKLabelNode(fontNamed:"Chalkduster")
        gameMessage.text = "YOU WIN!!!";
        gameMessage.fontSize = 60
        gameMessage.verticalAlignmentMode = .Top
        gameMessage.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height-150);

        
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


        /* Add Elements to the Parent View of GameScene */
        self.addChild(bgImage)
        self.addChild(bgImage2)
        self.addChild(walkingPath)
        self.addChild(walkingPath2)
        
        // create the restart button
        restartBtn = SKSpriteNode(imageNamed: "button.png")
        restartBtn.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        restartBtn.zPosition = layers.buttonLevel
        restartBtn.name = "restartgame"
        
        // create the restart button label
        restartLabel = SKLabelNode(fontNamed: "Charcoal")
        restartLabel.text = "Restart Game"
        restartLabel.fontSize = 25
        restartLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-10)
        restartLabel.zPosition = layers.buttonLevel + 1
        restartLabel.name = "restartgame"
        
        
        // add additional elements
        objectsLayer.addChild(appHeader)
        objectsLayer.addChild(gameMessage)
        objectsLayer.addChild(restartLabel)
        objectsLayer.addChild(restartBtn)


    }

    // function to create the Parent Node layers
    func setupLayers() {
        objectsLayer = SKNode()
        objectsLayer.name = "Objects Layer"
        addChild(objectsLayer)
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
        
        // run our resume functions
        if touchedNode.name == "restartgame" {
            
            // remove current scene
            self.removeAllChildren()
            self.removeAllActions()
            self.scene?.removeFromParent()
            self.removeFromParent()
            
            // reset the gamescene to start over
            gameScene = GameScene(size: scene!.size)
            let transition = SKTransition.doorsCloseHorizontalWithDuration(0.3)
            gameScene!.scaleMode = .AspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
            
        } else {
            
            // do nothing unless the Restart Button is hit
            
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