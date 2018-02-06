// Program detecting any red object in the field of cam.
// Change cam array value if this doesnt work (mine is using the 6th one, go figure)


import processing.video.*;

LiveCam cam;
Output visual;


void setup() {
  size(1400,1200, P3D);
    
    // Cam object
    cam = new LiveCam(); 
    // Visual Object
    visual = new Output(1, 1);
}

void draw() {
  background(0); 
  int intensite = 0; // Intesity is raising the more red appear in the livecam  

  //Placing the output
  translate(650, height/3, -100);
  rotateX(radians(60.0));
  rotateZ(radians(30.0));
  cam.draw();
     
     
  // Look for any red pixel, increment intensite when red pixels found   
  cam.loadPixels();
    for (int x = 0 ; x < cam.w ; x++) {
      for (int y = 0 ; y < cam.h ; y++) {
        color c = cam.cam.get(x, y);
        if(red(c) >=200 && green(c) < 100 && blue(c) < 100) {
          intensite++;
        }
      }
    }
    cam.updatePixels();
    
    
    visual.draw(intensite);


  
}