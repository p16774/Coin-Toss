//
//  GameCenter.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/28/16.
//  Copyright © 2016 Nathan Wharry. All rights reserved.
//

import GameKit

public var achievementDict = [String: GKAchievement]()

// function designed to help report achievement to Game Center
public func reportAchievement(identifier: String, percent: Double) {
    
    // create our achievement variable
    let achievement = GKAchievement(identifier: identifier)
    
    // make sure the achievement hasn't already been completed then report it
    if !completedAchievement(identifier) {
        achievement.percentComplete = percent
        achievement.showsCompletionBanner = true
    
        // submit achievement
        GKAchievement.reportAchievements([achievement]) { (error) -> Void in
            if error == nil {
                pullAchievements()
            } else {
                print("Error in reporting achievements: \(error)")
                return
            }
        }
    }
}
    
// function to pull the achievements and store them in memory
public func pullAchievements(completion: (() -> Void)? = nil) {
    
    // call the loadAchievement function from Game Center
    GKAchievement.loadAchievementsWithCompletionHandler { (achievements, error) -> Void in
        guard error == nil, let achievements = achievements else {
            print("Error in loading achievements: \(error)")
            return
        }
        
        // loop the pulled achievements and store the identifier in our array
        for achievement in achievements {
            if let id = achievement.identifier {
                achievementDict[id] = achievement
            }
        }
        
        print(achievementDict)
        
        // call the completion to end the Game Center function
        completion?()
    }
}
    
// function to check if an achievement has already been completed to prevent it from getting reported again
public func completedAchievement(identifier: String) -> Bool{
    if let achievement = achievementDict[identifier] {
        if achievement.percentComplete != 100 {
            return false
        } else {
            return true
        }
    }
    
    // default 
    return false
    
}
