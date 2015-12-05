//
//  CharacterProtocols.swift
//  WharryNathan_MGD_Proj1
//
//  Created by Nathan Wharry on 12/2/15.
//  Copyright © 2015 Nathan Wharry. All rights reserved.
//

import Foundation
import SpriteKit


/* Reusable Character Protocols */

protocol pWeapon {
    
    // functions for the weapons in the game
    func shoot(taget: pTargetable)

}

protocol pTargetable {
    
    // functions for the targetable items in the game
    var life : Int { get set }
    func takeDmg(damage: Int)
    
}


/* Weapon Classes */

class Gun: pWeapon {
    
    func shoot(target: pTargetable) {
        target.takeDmg(1)
    }
    
}