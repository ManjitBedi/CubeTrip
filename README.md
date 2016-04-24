##CubeTrip

This started out a experiment with using SceneKit to display some cubes; it is now doing more than that.  I keep adding new scenes as try things out.

Experimenting with Scene Kit, Sprite Kit and Swift. This is a proof of concept for some visual ideas.

1) Cubes 
Some shapes created in at run-time & some shapes read in from a DAE file.  It is kind of ropey to be perfectly honest.  😀  It was my first project with learning SceneKit

2) Experimenting with multiple shapes & animating them.  

* Actions for rotations are set up to loop in the SCN file for the 3D obejcts in the scene
* A skybox is set at run-time by passing in a array of 6 PNG file names.  The star field was created using some open source software. 

http://alexcpeterson.com/spacescape/

3) Sprite Kit 

* this experiment shows a moving sprite texture with a light node; the texture is using a mask value set in the SK scene file that matches the light node.


Note: ideally, the light node would be tied to the movement of the light wave in the fragment shader. That probably would require quite a bit of re-factoring.  😬

4) Scene Kit - camera movement & object tracking

* create a scene from placing nodes in a SCN file & then at run-time associate
.OBJ files for the road, terrain & trees

* a path is created by using the road nodes in the SCN file.
* added some objects to the scene
* there are 2 cameras
* the road & nature objects are from a public domain collection of 3D assets (donations welcome)

http://kenney.nl/assets/3d-road-tiles

Note: this first pass was a good result but it is not very maintainable.  Things to do differently.

* Use shape primtives for the objects that specify the node for the road in the SCN file - to be able to see them!
* change the way the 3D objects are attached to nodes;  I should check how anchor points work in this context.  When rotating the objects;  it seems they are being rotated from a corner & not the centre of the object.
* There is a problem with the tree & road meshes having the materials turn on & off.  What am I missing?

It took some thinking & experimenting; I got a camera to move with a node & follow the object using scene constraints.

