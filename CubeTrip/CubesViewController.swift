//
//  CubesViewController.swift
//  CubeTrip
//
//  Created by Manjit Bedi on 2014-11-13.
//  Copyright (c) 2014 coldharbourmedia. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class CubesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.camera?.zFar = 400.0
        
        // place the camera a bit back from the cubes
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 150)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blueColor()
        
        // create the cubes
        self.createCubes(scene)
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // This code works but it needs more work to space and align the nodes properly.
    func createCubes(scene: SCNScene) {
        
        let boxSize : CGFloat = 2.0;
        let numShapes = 5
        
        let myBox = SCNBox(width: boxSize, height: boxSize, length: 0.2, chamferRadius: 0)
        let distanceFromOrigin : Float = (Float)((boxSize*6*5)/2)
        
        for count in 1...6 {
            let nodeCollection = SCNNode()
            
            switch count {
                
            case 1:
                nodeCollection.position = SCNVector3(x:  0, y:  0, z: -distanceFromOrigin)
                
            case 2:
                nodeCollection.position = SCNVector3(x:  0, y:  0, z: distanceFromOrigin)
                
            // need to rotate
            case 3:
                nodeCollection.position = SCNVector3(x: -distanceFromOrigin, y:  0, z:  0)
                nodeCollection.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI_2))
                
            case 4:
                nodeCollection.position = SCNVector3(x: distanceFromOrigin, y:  0, z:  0)
                nodeCollection.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI_2))
                
            case 5:
                nodeCollection.position = SCNVector3(x:  0, y: -distanceFromOrigin, z:  0)
                nodeCollection.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI_2))
                
            default:
                nodeCollection.position = SCNVector3(x:  0, y:  distanceFromOrigin, z:  0)
                nodeCollection.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI_2))
            }
            
            for x in 1...numShapes{
                for y in 1...numShapes {
                    let node = SCNNode(geometry: myBox)
                    let offset: Int8 = (Int8)(-distanceFromOrigin)
                    node.position = SCNVector3(x: Float(offset + x*6), y: Float(offset + y*6), z:0)
                    nodeCollection.addChildNode(node)
                }
            }
            
            scene.rootNode.addChildNode(nodeCollection)
        }
        
        let cubesScene: SCNScene = SCNScene(named:"cubes.dae")!
        let node = SCNNode()

        let nodeArray = cubesScene.rootNode.childNodes
        
        for child in nodeArray {
            let childNode = child as SCNNode
            childNode.position =  SCNVector3(x:  0, y:  0, z: -distanceFromOrigin)
            node.addChildNode(childNode)
        }
        scene.rootNode.addChildNode(node)
    }
}
