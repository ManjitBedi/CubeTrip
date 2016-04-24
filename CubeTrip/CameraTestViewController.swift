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
    var skyCamera: SCNNode!
    var roadCamera: SCNNode!
    var someObject: SCNNode!
    var secondObject: SCNNode!
    
    @IBOutlet weak var scnView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        
        if let scene = SCNScene(named: "CameraAnimation.scn") {
            self.scene = scene
            
            // set the scene to the view
            scnView.scene = self.scene
            
            // allows the user to manipulate the camera
            scnView.allowsCameraControl = true
            
            // show statistics such as fps and timing information
            scnView.showsStatistics = true
            
            self.skyCamera = self.scene!.rootNode.childNodeWithName("skyCamera", recursively: true)!
            self.roadCamera = self.scene!.rootNode.childNodeWithName("roadCamera", recursively: true)!
            self.someObject = self.scene!.rootNode.childNodeWithName("someObject", recursively: true)!
            self.secondObject = self.scene!.rootNode.childNodeWithName("smallBox", recursively: true)!
            
            addTrees()
            addRoadToFun()
            
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
                for index in 1...3 {
                    for index2 in 1...4 {
                        var node:SCNNode
                        var yOffset:Float
                        if arc4random_uniform(2) == 1 {
                            yOffset = 0.0
                            node = treeNode2.clone()
                        } else {
                            yOffset = 0.3
                            node = treeNode.clone()
                        }
                        
                        // in a line spaced out.
                        node.position = SCNVector3Make(Float(index) * 4 - 8.0, yOffset, 2 * Float(index2) - 1.0)
                        
                        // apply some random scaling to the height of the trees
                        let lowerBound = 5
                        let upperBound = 15
                        let rndValue = Float(lowerBound + Int(arc4random()) % (upperBound - lowerBound))/10.0
                        
                        node.scale = SCNVector3Make(1, rndValue , 1)
                        self.scene?.rootNode.addChildNode(node)
                    }
                }
            }
        }
    }
    

    // This is making me think:
    // Ideally, I would use an editor to paint the road & then import the data into the app.
    // I am using a SCN file created in Xcode; the nodes are added manully 1 by 1 into the scene file.
    // The nodes all contain the string "road" to make them searchable in the SCN file.
    func addRoadToFun() {
        // get all the nodes named road & attach a road object to them.
        if let scene = self.scene,

            // The road tile is 3 units long
            // the nodes are spaced out 3 units from each other in the scn file.
            
            // this is a  dirt road tile
            roadScn = SCNScene(named: "roads.scnassets/roadTile_015.obj"),
            roadNode = roadScn.rootNode.childNodes.first,
            
            // This is corner dirt road tile
            cornerRoadScn = SCNScene(named: "roads.scnassets/roadTile_016.obj"),
            cornerRoadNode = cornerRoadScn.rootNode.childNodes.first

        {
            scene.rootNode.enumerateChildNodesUsingBlock(){
                node, stop in
                if node.name!.containsString("-x") {
                    print(node.position)
                    node.addChildNode(roadNode.clone())
                } else if node.name!.containsString("-e-to-s") {
                    print(node.position)
                    node.rotation = SCNVector4Make(0, 1, 0, Float(M_PI))
                    node.addChildNode(cornerRoadNode.clone())
                } else if node.name!.containsString("-z") {
                    print(node.position)
                    node.rotation = SCNVector4Make(0, 1, 0, Float(M_PI_2))
                    node.addChildNode(roadNode.clone())
                }

                stop[0] = false
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func actionSkyCamera(sender: AnyObject) {
        scnView.pointOfView = skyCamera
        scnView.allowsCameraControl = true
    }
    
    @IBAction func actionRoadCamera(sender: AnyObject) {
        scnView.pointOfView = roadCamera
        scnView.allowsCameraControl = false
    }
    
    
    // Move the road camera node along the nodes that represent the road.
    // In the SCN file, the road nodes contain the string "road"
    @IBAction func actionMoveCameraAlongRoad(sender: AnyObject) {
        if let scene = self.scene {
            var actions:[SCNAction] = []
            scene.rootNode.enumerateChildNodesUsingBlock(){
                node, stop in
                if node.name!.containsString("road") {
                    var position = node.position
                    position.y += 2.0
                    let moveTo = SCNAction.moveTo(position, duration: 3.0)
                    actions.append(moveTo)
                }
                
                stop[0] = false
            }
            
            // Point the camera East
            roadCamera.rotation = SCNVector4Make(0, 1, 0, Float(-M_PI_2))

            let sequence = SCNAction.sequence(actions)
            roadCamera.runAction(sequence)
        }
    }
    
    // Animate the "some object" node along the road nodes and hae the road
    // camera node track the object.  Ideally, I want the camera object
    // to move with the node.
    
    @IBAction func actionMoveObjectAlongRoad(sender: AnyObject) {
        if let scene = self.scene {
            
            scnView.pointOfView = roadCamera
            
            var actions: [SCNAction] = []
            var cameraActions: [SCNAction] = []
            
            scene.rootNode.enumerateChildNodesUsingBlock(){
                node, stop in
                if node.name!.containsString("road") {
                    var position = node.position
                    
                    position.x -= 0.5
                    position.y += 2.0
                    position.z -= 1.0
                    
                    let moveTo = SCNAction.moveTo(position, duration: 2.0)
                    actions.append(moveTo)
                    
                    position.z -= 1.0
                    position.y += 4.0
                    let cameraMoveTo = SCNAction.moveTo(position, duration: 2.0)
                    cameraActions.append(cameraMoveTo)
                }
                
                stop[0] = false
            }
            
            let targetNodeConstraint = SCNLookAtConstraint(target: someObject)
            targetNodeConstraint.gimbalLockEnabled = true
            
            let sequence = SCNAction.sequence(actions)
            someObject.position = SCNVector3Make(-6.0, 1, -4.5)
            someObject.runAction(sequence)
            
            let sequence2 = SCNAction.sequence(actions)
            roadCamera.position = SCNVector3Make(-7.0, 1, -6.5)
            roadCamera.runAction(sequence2)
            
            let followObjectConstraint = SCNTransformConstraint(inWorldSpace: true, withBlock: { (node, matrix) -> SCNMatrix4 in
                let transformMatrix = SCNMatrix4MakeTranslation( self.someObject.position.x - 1.0, self.someObject.position.y, self.someObject.position.z + 1.0)
                let scaleMatrix =  SCNMatrix4Scale (transformMatrix, 0.2, 0.2, 0.2)
                return scaleMatrix
            })
            
            
            // Position the object behind the other object & rotate it to face east
            let followObjectConstraint2 = SCNTransformConstraint(inWorldSpace: true, withBlock: { (node, matrix) -> SCNMatrix4 in
                let transformMatrix = SCNMatrix4MakeTranslation( self.someObject.position.x - 0.4, self.someObject.position.y, self.someObject.position.z)
                let scaleMatrix =  SCNMatrix4Scale (transformMatrix, 0.2, 0.2, 0.2)
                return scaleMatrix
            })
            
            roadCamera.constraints = [followObjectConstraint, targetNodeConstraint]
            secondObject.constraints = [followObjectConstraint2]
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
