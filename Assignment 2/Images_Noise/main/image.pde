class Image {
  
  // Loading image, number of pixels in image, number of showed pixels in image.
  PImage imgSrc;
  PImage imgDest;
  PVector origin;
  
  Image(String filename) {
    imgSrc =  loadImage(filename);
    imgDest = createImage(imgSrc.width, imgSrc.height, RGB);
    
  }
  
  void update(float distance, IntList pix, int index){
    // Redraw the image with new set of pixels.
    imgSrc.loadPixels();
    imgDest.loadPixels();
    
      for (int i = index ; i < (int)distance ; i ++) {
        imgDest.pixels[pix.get(i)] = imgSrc.pixels[pix.get(i)];
      }
    imgDest.updatePixels();
    image(imgDest, 0, 0);
  }
  
  // Reseting the pixels to white
  void reset() {
   imgDest.loadPixels();
   for (int i = 0 ; i < width*height ; i++){
     imgDest.pixels[i] = color(255,255,255,0);
   }
   imgDest.updatePixels();
   
   
  }
  
  // Modulate add colored noise 
  void modulate() {
    imgSrc.loadPixels();
    imgDest.loadPixels();
    
    for(int i = 0 ; i < width*height ; i+=random(1,10)) {
      imgDest.pixels[i] = color(random(100,120), random(100,120), random(100,120));
    }
    imgDest.updatePixels();
    image(imgDest, 0, 0);
  }
}