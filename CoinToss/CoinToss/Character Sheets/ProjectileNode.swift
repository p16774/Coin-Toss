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
    
    // setup the damange variable
    var damage:Int = 0
    
    // setup our initializer
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}