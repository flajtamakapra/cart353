/*

  Just a vertical line moving from left to right (or vice versa)

*/

class Accelerator {

  PVector position;
  PVector acceleration;
  PVector velocity;
  boolean isAlive;
  int intensity;
  
  Accelerator(PVector mouse, PVector direction){
    position = mouse;
    velocity = direction;
    intensity = (int)random(1000);
    isAlive = true;
  }
  
  void update(){
    if(position.x > width || position.x < 0) {
      velocity.x = -velocity.x;
    }
    position.add(velocity);
    
    
    // Dying from natural death
    if(intensity>0){
        intensity--;
     }
     else {
       isAlive = false;
     }
    
    
  }
  
  void draw() {
    
    stroke(map(intensity, 0, 1000, 10, 255));
    noFill();
    line(position.x, 0, position.x, height);
  
  }
  
  
  
}