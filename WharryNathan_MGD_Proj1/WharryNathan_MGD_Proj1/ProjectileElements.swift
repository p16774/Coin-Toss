//
//  ProjectileElements.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/4/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class projectile: SKNode {
    
    override init() {
        super.init()   //  initialize the default values from the SuperClass ( SKNode )
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTop(withTexture: SKTexture) {   // Function for adding the visible texture
        
        let xSize = withTexture.size().width            // Create The texture for the top ( visible sprite )
        let ySize = withTexture.size().height
        let size = CGSize(width: xSize, height: ySize)
        
        self.physicsBody = SKPhysicsBody(texture: withTexture, size: size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = false            // ( physical body stuff )
        self.physicsBody?.mass = 0.1
        self.name = "projectile"
        self.physicsBody?.categoryBitMask = 0x1 << 0
        let top = SKSpriteNode(texture: withTexture, size: size)
        top.zPosition = layers.bulletLevel                        // set zPosition
        top.color = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        top.colorBlendFactor = 1.0
        // add the top sprite to the SKNode
        self.addChild(top)
        
    }
    
}

class bulletPlayer: projectile {
    
    var texture: SKTexture!
    
    override init() {
        super.init()
        
        self.addTop(playerBullet)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
