/**************************
Random images mixer, by Jeremie Desmarais

2 images are randomly mixed. 
The mix is depending on the mouse position in the sketch.

Each image has a corner. 
They are sharing a list of random pixels (from 0 to width*height)

****************************/

int maxImg = 2;

// This the origin point from where to calculate the distance for each image.
PVector [] origins = new PVector[maxImg];

IntList pix = new IntList();    // List of pixels
Image[] images = new Image[maxImg];

void setup() {
  
  size(600, 400);
  
  origins[0] = new PVector(0,0);
  origins[1] = new PVector(width, height);
  
  // Setting up images array
  for(int i = 1 ; i <= maxImg ; i++) {
    images[i-1] = new Image("img" + i + ".jpg");
  }
  
  // Setting up the shared pix list.
  for(int i = 0 ; i < width*height ; i++){
    pix.append(i);    
  }
  pix.shuffle();
  
}

void draw() {
  pix.shuffle();
  float [] distance = new float[maxImg];
  float maxDist = dist(0,0,width,height);
  
  for(int i = 0 ; i < maxImg ; i++ ) {
    if(mouseX > 0 && mouseY > 0 && mouseX < width && mouseY < height){
      distance[i] = dist(origins[i].x, origins[i].y,mouseX, mouseY);
      distance[i] = map(distance[i], 0, maxDist, 0, width*height);  
    }
    
  }
  

  int index = 0;
  for (int i = 0 ; i < maxImg ; i++) {
   
    images[i].update(distance[i], pix, index);
    //index += distance[i];
    images[i].reset();
  }
  
 if(mousePressed == true) {
   images[1].modulate();
 }
}
void keyPressed() {
 if ( key == 's') {
   save("savedImage.jpg");
 }
}