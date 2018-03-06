
/*



*/

class Particle {

	PVector position, velocity, acceleration;

	int mass, partColor;
  int limit = 2;
  float numPoints;
  int outsideRadius;
  
	
	Particle(int m, PVector pos, int clr){
		position = pos;
		velocity = new PVector(random(-1, 1), random(-1, 1));
		acceleration = new PVector(0,0);

		mass = m;
		partColor = clr;
    numPoints = (int)random(2, 5);
    outsideRadius = (int)random(2,10);
  }

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

  void update(){
      velocity.add(acceleration);
      velocity.limit(limit);
      position.add(velocity);
      acceleration.mult(0);
  
  }
  
  void shake(int amp){
    amp = abs(amp);
    this.position.x += random(-amp,amp);
    this.position.y += random(-amp*2,amp*2);
  }

	void display() {
// Shape drawing


    float angle = random(PI*2);
    float angleStep = 360.0/numPoints;
    fill(partColor);
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


}