//
//  GameViewController.swift
//  CoinToss
//
//  Created by Nathan Wharry on 4/8/16.
//  Copyright (c) 2016 Nathan Wharry. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBAction func gameCenterBtn(sender: AnyObject) {
        
        // pause gamescene but check if the game is running first
        if gameRunning == true {
        
            // add in our resume game option
            pauseLabel.text = "Resume Game"
            pauseLabel.name = "resumegame"
            pauseBtn.name = "resumegame"
            
        }
        
        // show the leaderboards from GameCenter
        showLeaderboard()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        
        // authenticate player to gamecenter
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController : UIViewController?, error : NSError?) -> Void in
            
            // if not logged in present the login controller else show the banner they are logged in
            if ((viewController) != nil) {
            
                self.presentViewController(viewController!, animated: true, completion: nil)
            
            }else{
                
                print((GKLocalPlayer.localPlayer().authenticated))
            
            }
        }
    }
    
    // function that will show the leaderboard when button is clicked on the screen
    func showLeaderboard() {
        
        // set the viewcontroller and delegate to show view
        let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = self
        
        // set the leaderboards as the first page to pull up
        gcViewController.viewState = GKGameCenterViewControllerState.Leaderboards
        
        // identify the iTunes connect leaderboard it should be displaying
        gcViewController.leaderboardIdentifier = "IADCoinToss2016Distance"
        
        // show the viewcontroller
        self.showViewController(gcViewController, sender: self)
        self.navigationController?.pushViewController(gcViewController, animated: true)
        
    }
    
    // function to remove the viewcontroller when the user clicks done
    func gameCenterViewControllerDidFinish(gcViewController: GKGameCenterViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
