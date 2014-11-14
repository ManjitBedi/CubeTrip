//
//  GameViewController.swift
//  CubeTrip
//
//  Created by Manjit Bedi on 2014-11-13.
//  Copyright (c) 2014 coldharbourmedia. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera a bit back from the cubes
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 90)
        
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
        let scnView = self.view as SCNView
        
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
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // This code works but it needs more work to space and align the nodes properly.
    func createCubes(scene: SCNScene) {
        
        var boxSize : CGFloat = 2.0;
        var numShapes = 5
        
        let myBox = SCNBox(width: boxSize, height: boxSize, length: 0.2, chamferRadius: 0)
        var distanceFromOrigin : Float = (Float)((boxSize*6*5)/2)
        
        for count in 1...6 {
            var nodeCollection = SCNNode()
            
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
                    var offset: Int8 = (Int8)(-distanceFromOrigin)
                    node.position = SCNVector3(x: Float(offset + x*6), y: Float(offset + y*6), z:0)
                    nodeCollection.addChildNode(node)
                }
            }
            
            scene.rootNode.addChildNode(nodeCollection)
        }
    }
}
