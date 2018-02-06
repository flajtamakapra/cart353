// Visual output, result of LiveCam processing

class Output {
  
  // This is drawing hundreds of lines who will respond to the input.
  // detailx and detaily are the amount of lines and the space between them
  int detailx, detaily;   
  
  // Declared on constructor
  Output(int dx, int dy) {
    this.detailx = dx;
    this.detaily = dy;
    
      
  }
  void draw(int intensite) {
    
    // Noise data
    float xOff = 0.0;
    float yOff = 0.0;
    float zOff = 0.0;
    float seedOff = 0.0;
    int maxSeed = 10;


    // Gaussian noise to fluctuate lighting between 10 and 100
    // This plays with alpha value. 
    float noiseAlpha = abs(randomGaussian()*100)+10;
      
    // Changing the seed, to the red graduation sligthly change constantly  
    maxSeed += 1000;
    strokeWeight(20);
    
    for(int i = 0 ; i < 500/detaily ; i++){
      
      // Setting up the noise seed for this row.
      float nSeed = map(noise(seedOff), 0, 1, 0, maxSeed);
      noiseSeed((int)nSeed);

      beginShape(LINES);
      for(int j = 0 ; j < 500/detailx ; j++){
        
        
        // Perlin noise applied to the red value fluctuation on the column
        float nColorVal = map(noise(xOff, yOff), 0, 1, 0, 255);
        
        stroke((int)nColorVal,0,0, noiseAlpha);
        
        // 1d Perlin noise applied to the curve.
        float zValue = map(noise(zOff), 0, 1, -intensite, intensite);
        vertex(j*detaily, i*detailx, (int)zValue);   
        xOff+=0.0000000000000000001;  // Vvvvveeery subtle variation, the effect is smoother!
        zOff+=0.01;
         
      }
      yOff+=0.1;
      endShape(); 
    }
  }

}