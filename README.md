##CubeTrip

This started out a experiment with using SceneKit to display some cubes; it is now doing more than that.  I keep adding new scenes as try things out.

Experimenting with Scene Kit, Sprite Kit and Swift. This is a proof of concept for some visual ideas.

1) Cubes 
Some shapes created in at run-time & some shapes read in from a DAE file.  It is kind of ropey to be perfectly honest.  😀  It was my first project with learning SceneKit

2) Experimenting with multiple shapes & animating them.  Also using a Skybox.

* Actions for rotations are set up to loop in the SCN file for the 3D obejcts in the scene


3) Sprite Kit 

* this experiment shows a moving srite texture with a light node; the texture is using a mask value set in the SK scene file that matches the light node.

4) Scene Kit - camera movement & object tracking

* WIP: create a scene from placing nodes in a SCN file & then at run-time associate
.OBJ files for the road, terrain & trees

* TODO: set up way points (maybe just re-use the road nodes) & have the camera move along them in a loop

* TODO: add some objects to the scene, have the camera move along the way points & track object
