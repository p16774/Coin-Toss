//
//  Player.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/3/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class hero: character, pTargetable {
    
    var life = 10  // define the values required by the protocols used ( pTargetable here )
    
    override init() {
        
        
        super.init()   //  initialize the default values from the SuperClass ( character )
        
        // override any values here
        scorePoints = 5         //change the default scorePoints from 1 to 5
        
        let texture = SKTexture(imageNamed: "player")
        let xSize = texture.size().width*scale                // Create The texture for the top ( visible sprite )
        let ySize = texture.size().height*scale
        let charSize = CGSize(width: xSize, height: ySize)
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: charSize)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        self.physicsBody?.mass = 1.0
        self.physicsBody?.allowsRotation = false
        self.name = "player"
        
        let top = SKSpriteNode(texture: texture, size: charSize)
        top.zPosition = layers.playerLevel
        top.name = "startPlayer"
        top.color = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        top.colorBlendFactor = 1.0
        // add the top sprite
        self.addChild(top)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func takeDmg(damage: Int) {
        life -= damage
        print("You lost \(damage) hit points")
        
        if life <= 0 {
            charIsDead()
            print("You are dead now")
        }
    }
    
    
    func shoot() {
        
        let newBullet = bulletPlayer()
        newBullet.position = CGPoint(x: 50, y: 0)
        self.addChild(newBullet)
        newBullet.physicsBody?.velocity = CGVector(dx: 350, dy: 0)
        
    }
    
}
