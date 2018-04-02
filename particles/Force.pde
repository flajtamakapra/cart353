/*  
 Force object: might be a repeller or an attractor. 
 
 
 */


class Force {

  PVector position;
  int G = 10;
  

  Force(int gForce) {
    
    G = gForce;
  }
  
  void setPosition(PVector newPos) {
    position = newPos;
  }

  PVector repel(Particle p) {
    PVector repellingForce = createForce(p, -2, 5, 100);
    return repellingForce;
  }

  PVector attract(Particle p) {
    PVector attractingForce = createForce(p, 2, 15, 30);
    return attractingForce;  

}

  // Creating the force, the core
  PVector createForce(Particle p, int multiplier, int constrainMin, int constrainMax) {
    PVector dir = PVector.sub(position, p.position);        // Calculate direction of force
    float d = dir.mag();                                    // Distance between objects
    dir.normalize();                                        // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    d = constrain(d, constrainMin, constrainMax);           // Keep distance within a reasonable range
    float force = multiplier * G / (d * d);                 // Repelling force is inversely proportional to distance
    dir.mult(force);                                        // Get force vector --> magnitude * direction
    return dir;
  }
}
