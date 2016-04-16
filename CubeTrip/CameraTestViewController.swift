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
import Darwin

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
     first objects attached to the root node?
    */
    func addTrees() {
        if let treeScene = SCNScene(named: "nature.scnassets/Tree_01.obj"),
           treeScene2 = SCNScene(named: "nature.scnassets/Oak_Green_01.obj") {
            print("tree scene \(treeScene) number of nodes \(treeScene.rootNode.childNodes.count)")
            if let treeNode = treeScene.rootNode.childNodes.first,
                treeNode2 = treeScene2.rootNode.childNodes.first {
                for index in 1...10 {
                    for index2 in 1...10 {
                        var node:SCNNode
                        if arc4random_uniform(2) == 1 {
                            node = treeNode2.clone()
                        } else {
                            node = treeNode.clone()
                        }
                        
                        // in a line spaced out.
                        node.position = SCNVector3Make(Float(index) * 5 - 10.0, 0, 2 * Float(index2) - 5.0)
                        self.scene?.rootNode.addChildNode(node)
                    }
                }
            }
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
