// Central particle - kernel of the "atom"

class Attractor {
	

	// Movements
	PVector velocity, acceleration, position;
	float topSpeed = 0.2;

	// Visual
	int outsideRadius, insideRadius, mass;
	int nbElectronsInOrbit = 0;

	// The shape changing speed variation of the kernel.
	float variationIncrement; 
  
  // Precision of the kernel's rendering
	int numPoints = 100;

	int G = 1;

	Attractor(int m, PVector pos){
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
    
    // Building kernel's shape, based on it's mass
		outsideRadius = mass = m;
		position = pos;		
    //variationIncrement = constrain(variationIncrement, 0.00001, 0.0001);
	}

	
	// Shape changing speed calculation
	//float sinVariation(int min, int max){
	//	return (int)map(sin(now+=variationIncrement), -1, 1, min, max);
	//}

	void applyForce(PVector force){
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	PVector attract(Particle p) {
		// Force direction
		PVector force = PVector.sub(position, p.position);

		// Distance
		float d  = force.mag();
		d = constrain(d, 0.0, 5500.0);

		// Unit vector for direction
		force.normalize();

		
		// Calcutate and Apply attraction
		float distanceEffect = (G * mass * p.mass) / (d*d);
		force.mult(distanceEffect);

		// Calculate and apply another attraction
		float repOrAtt = map(d, 0, 5500, 0.00, 1.5);
		float res = (G * mass * p.mass) * (repOrAtt);

		return force.mult(res);

	}

	// Update the attractor's position
	void update() {
		PVector mouse = new PVector(mouseX, mouseY);
		acceleration = PVector.sub(mouse, position);

//		float distance = constrain(acceleration.mag(), 0, 600);
		acceleration.normalize();

		velocity.add(acceleration);
		velocity.limit(topSpeed);
		position.add(velocity);
		acceleration.mult(0);

	}

	void display(){

    // Shape drawing
		float angle = random(PI*2);
		float angleStep = 360.0/numPoints;
		fill(255);
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