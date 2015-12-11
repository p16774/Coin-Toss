//
//  characterNodes.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/2/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import UIKit
import SpriteKit

class character: SKNode {
    
    // set up the global variables for use in our character models (both our player and enemies)
    var health = 1
    var charSize = CGSize(width: 50, height: 50)
    
    // setup our initializer
    override init() {
        super.init()
        
    }
    
    // function for error handling
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /* Various Global Character Functions */
    
    func charIsDead() {
        
    }

}
