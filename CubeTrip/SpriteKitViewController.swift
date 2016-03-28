//
//  SpriteKitViewController.swift
//  CubeTrip
//
//  Created by Manjit Bedi on 2016-03-26.
//  Copyright © 2016 coldharbourmedia. All rights reserved.
//

import UIKit
import SpriteKit

class SpriteKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        // Create and configure the scene.
        if let scene = ExperimentScene(fileNamed:"Experiment") {
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
