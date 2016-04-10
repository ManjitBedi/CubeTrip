//
//  CameraTestViewController.swift
//  CubeTrip
//
//  Created by Manjit Bedi on 2016-04-08.
//  Copyright © 2016 coldharbourmedia. All rights reserved.
//

import UIKit
import SceneKit
import SceneKit.ModelIO

class CameraTestViewController: UIViewController {

    var scene: SCNScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        
        if let scene = SCNScene(named: "CameraAnimation.scn") {
            self.scene = scene

            // retrieve the SCNView
            let scnView = self.view as! SCNView
            
            // set the scene to the view
            scnView.scene = self.scene
            
            // allows the user to manipulate the camera
            scnView.allowsCameraControl = true
            
            // show statistics such as fps and timing information
            scnView.showsStatistics = true
            
            self.addTrees()
            
            // configure the view
            scnView.backgroundColor = UIColor.blackColor()
            
            self.scene!.background.contents = ["Skybox_right1", "Skybox_left2", "Skybox_top3", "Skybox_bottom4", "Skybox_front5", "Skybox_back6"];
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     This is interesting,  you can load a obj files from scene kit asset catalog.
     Does this mean the object has been convrted to a SceneKit scene?
     There is only one object in the scene so it is safe to jut get the
     first objects attached to the root node.
     
     TODO: create nodes at different postions and attach a tree to each node.
     
    */
    func addTrees() {
        if let treeScene = SCNScene(named: "nature.scnassets/Tree_01.obj") {
            print(treeScene)
            self.scene?.rootNode.addChildNode(treeScene.rootNode.childNodes.first!)
        }
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
