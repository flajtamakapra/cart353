class FaceMouth extends Face {
  
  float orWidth, orHeight;
  
  FaceMouth(){

  }
  
  // Will attract particles
  PVector attract(Particle p) {
    this.orWidth = random(-mouthWidth, mouthWidth)*6;
    this.orHeight = random(-mouthHeight, mouthHeight)*6;
    
    // Attraction's position
    PVector position = new PVector(posePosition.x+orWidth, posePosition.y+orHeight);
        
    // Force direction
    PVector force = PVector.sub(position, p.position);

    // Distance
    float d  = force.mag();
    d = constrain(d, 0.0, 25.0);

    // Unit vector for direction
    force.normalize();

    
    // Calcutate and Apply attraction
    float strength = (G * mass * p.mass) / (d*d);
    force.mult(strength);

    return force;

  }
  

  
}
