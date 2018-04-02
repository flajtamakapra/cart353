// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Particles + Forces

// A very basic Repeller class

// --** and a very basic tweak to add strength and G manipulation
class Repeller {
  
  // Gravitational Constant
  float G;
  // position
  PVector position;
  float r = 10;

 
  Repeller(float g)  {
    ///position = new PVector(x,y);
    G = g;
  }
  
  Repeller()  {
    G = 10;
  }
  
  void setG(float newG){
    G = newG;

  }
  
  void setPosition(PVector newPos) {
    position = newPos;
  }

  // Calculate a force to push particle away from repeller
  PVector repel(Particle p) {
    PVector dir = PVector.sub(position, p.position);      // Calculate direction of force
    float d = dir.mag();                       // Distance between objects
    dir.normalize();                           // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    d = constrain(d,5,100);                    // Keep distance within a reasonable range
    float force = -2 * G / (d * d);            // Repelling force is inversely proportional to distance
    dir.mult(force);                           // Get force vector --> magnitude * direction
    return dir;
  }  
  
       // Will attract particles
  PVector attract(Particle p) {    
    
    PVector force = PVector.sub(position, p.position);   
    float d  = force.mag();
    d = constrain(d, 0.0, 25.0);  
    force.normalize();
    float strength = (G * p.mass) / (d*d);
    force.mult(strength);

    return force;

  }
}
