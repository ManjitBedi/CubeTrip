//
//  MultiplesViewController.swift
//  CubeTrip
//
//  Created by Manjit Bedi on 2016-07-03.
//  Copyright © 2016 coldharbourmedia. All rights reserved.
//

import UIKit
import SceneKit

class MultiplesViewController: UIViewController {
    
    var scene: SCNScene?
    @IBOutlet weak var scnView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // create a new scene
        if let scene = SCNScene(named: "Multiples.scn") {
            self.scene = scene
            
            // set the scene to the view
            scnView.scene = self.scene
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
