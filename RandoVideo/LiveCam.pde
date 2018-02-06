class LiveCam {
  int x,y,w,h;
  Capture cam;
  String[] cameras = Capture.list();
  

  
  LiveCam() {

    cam = new Capture(RandoVideo.this, cameras[6]);

    
    cam.start();
    
  }
  
  void draw() {
    if(cam.available()){
     cam.read(); 
    }   
   //image(cam, 0,0);
       w = cam.width;
    h = cam.height;
  }
  void loadPixels() {
    cam.loadPixels();
  }
  void updatePixels() {
    cam.updatePixels();
  }
  
  
}