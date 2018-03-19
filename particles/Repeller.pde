// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Particles + Forces

// A very basic Repeller class
class Repeller {
  
  // Gravitational Constant
  float G;
  // position
  PVector position;
  float r = 10;
 
  Repeller(float x, float y)  {
    position = new PVector(x,y);
    G = 10;
  }
  
  Repeller()  {
    
  }

  // Display pourrait être l'assemblement de particules: attract
  void display() {    
    stroke(0);
    strokeWeight(2);
    fill(175);
    ellipse(position.x,position.y,48,48);
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
    
    // Force direction
    PVector force = PVector.sub(position, p.position);

    // Distance
    float d  = force.mag();
    d = constrain(d, 0.0, 25.0);

    // Unit vector for direction
    force.normalize();

    // Calcutate and Apply attraction
    float strength = (G * 10 * p.mass) / (d*d);
    force.mult(strength);

    return force;

  }
}
