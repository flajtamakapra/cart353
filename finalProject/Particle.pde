
/*

Just a simple particle system. 

*/

class Particle {

	PVector position, velocity, acceleration;

	int mass, partColor;
  int limit = 2;
  float numPoints, lifespan, lsSpeed;
  int outsideRadius;  
	
	Particle(int m, PVector pos, int clr, float ls){
		position = pos;
		velocity = new PVector(random(-1, 1), random(-1, 1));
		acceleration = new PVector(0,0);
    lifespan = 255;
    lsSpeed = ls;
    mass = m;
		partColor = clr;
    numPoints = (int)random(2, 5);
    outsideRadius = (int)random(2,10);
  }

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}
  void run() {
    update();
    display();
  }
  
  void update(){
      velocity.add(acceleration);
      velocity.limit(limit);
      position.add(velocity);
      acceleration.mult(0);
      lifespan -= lsSpeed;
  
  }
  
  void shake(int amp){
    amp = abs(amp);
    this.position.x += random(-amp,amp);
    this.position.y += random(-amp*2,amp*2);
  }
  
  void setColor(int clr) {
    this.partColor = clr;
  }
  
  void setMass(int mass) {
    this.mass = mass;  
  }
  
  void setOutsideRadius(int radius) {
     this.outsideRadius = radius; 
  }



	void display() {
    
    // Shape drawing
    float angle = random(PI*2);
    float angleStep = 360.0/numPoints;
    fill(127,lifespan);
    noStroke();
    beginShape(TRIANGLE_STRIP);
      for(int i = 0 ; i < numPoints ; i++ ) {
        float px = position.x + cos(radians(angle)) * outsideRadius+(random(20)); // Make it live-like
        float py = position.y + sin(radians(angle)) * outsideRadius+(random(5));
        angle += angleStep;        
        vertex(px, py);
        px = position.x + cos(radians(angle));
        py = position.y + sin(radians(angle));
        vertex(px, py);
        angle+= angleStep;
        
      }
    endShape();	
	}

    // Is the particle still useful?
    boolean isDead() {
      if (lifespan < 0.0) {
        return true;
      } else {
        return false;
      }
    }


}
