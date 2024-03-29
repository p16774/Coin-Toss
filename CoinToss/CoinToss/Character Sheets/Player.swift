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

class hero: character {
    
    var life = 10  // define the values required by the protocols used ( pTargetable here )
    
    override init() {
        
        super.init()
        
        // override any values here
        health = 5         //change the default scorePoints from 1 to 5
        
        let texture = SKTexture(imageNamed: "player")
        let xSize = texture.size().width              // Create The texture for the top ( visible sprite )
        let ySize = texture.size().height
        let charSize = CGSize(width: xSize, height: ySize)
        
        /* removing physics as this is just a stand in body
         
         self.physicsBody = SKPhysicsBody(texture: texture, size: charSize)
         self.physicsBody?.dynamic = false
         self.physicsBody?.affectedByGravity = false            // ( physical body stuff )
         self.physicsBody?.mass = 1.0
         self.physicsBody?.allowsRotation = false
         
         */
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
    
    func shoot() {
        
        let newBullet = bullet()
        newBullet.position = bulletPosition
        coinLayer.addChild(newBullet)
        

        
    }
    
}
