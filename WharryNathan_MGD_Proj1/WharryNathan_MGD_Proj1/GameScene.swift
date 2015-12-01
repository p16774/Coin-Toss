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
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let appHeader = SKLabelNode(fontNamed:"Chalkduster")
        appHeader.text = "Nathan Wharry's SpriteKit";
        appHeader.fontSize = 45
        appHeader.verticalAlignmentMode = .Top
        appHeader.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height);
        
        // Create the world bounds to prevent objects going off screen and allowing collisions
        let gameBorder = SKPhysicsBody(edgeLoopFromRect: self.frame)
        gameBorder.friction = 0
        self.physicsBody = gameBorder
        
        // create background image
        let bgImage = SKSpriteNode(imageNamed: "stonewall.png")
        bgImage.size = self.frame.size
        bgImage.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        
        // add a sprite coin image
        let coinImage = SKSpriteNode(imageNamed: "coinage.png")
        coinImage.position = CGPointMake(300, 300)
        coinImage.name = "coin"
        
        // add second coin image for collision check
        let coinImage2 = SKSpriteNode(imageNamed: "coinage.png")
        coinImage2.position = CGPointMake(700, 300)
        coinImage2.name = "bouncycoin"
        
        // create the coin physics body for collision check
        let coinPhysics = SKPhysicsBody(circleOfRadius: 18)
        coinImage2.physicsBody = coinPhysics
        coinPhysics.allowsRotation = false
        coinPhysics.affectedByGravity = true
        coinPhysics.friction = 0
        coinPhysics.restitution = 1
        coinPhysics.linearDamping = 0
        coinPhysics.angularDamping = 0
        
        // add the coin label
        let coinLabel = SKLabelNode(fontNamed: "Arial")
        coinLabel.text = "Push coin for sound!"
        coinLabel.fontSize = 25
        coinLabel.position = CGPointMake(300, 320)
        coinLabel.name = "coinlabel"
        
        // create the start button
        let startBtn = SKSpriteNode(imageNamed: "button.png")
        startBtn.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-200)
        startBtn.name = "startgame"
        
        // create the start button label
        let startLabel = SKLabelNode(fontNamed: "Charcoal")
        startLabel.text = "Start Game"
        startLabel.fontSize = 25
        startLabel.position = CGPointMake(self.frame.width/2, (self.frame.height/2)-210)
        startLabel.name = "startgame"
        

        
        self.addChild(bgImage)
        self.addChild(coinImage)
        self.addChild(coinLabel)
        self.addChild(coinImage2)
        self.addChild(startBtn)
        self.addChild(startLabel)
        self.addChild(appHeader)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        //var audioPlayer: AVAudioPlayer = AVAudioPlayer()
            
            // set up which touch we are getting
            let touch = touches.first! as UITouch
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
        
            // check for touched location name
            if touchedNode.name == "startgame" {
                
                // setup the start sound
                let playSound = SKAction.playSoundFileNamed("startgame.mp3", waitForCompletion: true)
                runAction(playSound)
                
                // implement code to start game
                
            } else if touchedNode.name == "coin" {
                
                // play file
                let playSound = SKAction.playSoundFileNamed("coins.mp3", waitForCompletion: true)
                
                /* I couldn't get this to ever play a file no matter how many times I tried to get the file placed right
                
                // set up the sound to play when touched
                let soundPath = NSBundle.mainBundle().pathForResource("coins", ofType: "mp3")
                print(soundPath)
                let touchSound = NSURL(fileURLWithPath: soundPath!)
                do { audioPlayer = try AVAudioPlayer(contentsOfURL: touchSound) } catch _ { return print("There was an error loading the file") }
                
                // play the file
                audioPlayer.play()*/
                runAction(playSound)
                
            }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
