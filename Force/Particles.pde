
/*
	If the particle is near the atom, the orbit state changes. 
	If I could simulate a real orbit with force (not that I haven't tried), I would be intelligent and happy
	but i'm not, yet... (intelligent)
	So This is a just a false orbit, where the electron is moving ellipticaly around the atom. 
	(no, i'm not using Atom, i'm using Sublime Text)


*/

class Particle {

	PVector position, velocity, acceleration;

	int mass, partColor, orbitRadiusX, orbitRadiusY;
	float orbiVal, orbitDirectionAndSpeed;

  // Toggle the particle's orbit: free in the frame or attached to the kernel?
	boolean isInOrbit;

  // For cool tracing effect
	ArrayList<PVector> history;

	Particle(int m, PVector pos, boolean statique){
		position = pos;
		velocity = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
		acceleration = new PVector(0,0);

		mass = m;
		partColor = (int)random(10, 75);
  
  
    int max;
    int test = (int)random(10);
 
     // One chance out of 10 that the ellipse will be greater.. for some reason
    if(test == 9){       
      max = 550;
    }
    else max = 250;
    
    // Shaping the orbit
		orbitRadiusX = (int)random(0, max);
		orbitRadiusY = (int)random(0, max);
		orbiVal = random(0, PI*2);
		orbitDirectionAndSpeed = random(-0.018, 0.018);

    history = new ArrayList<PVector>();
    
    // Not in orbit at the "creation"
		isInOrbit = false;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}


	void update(PVector destination){

		// Verify if the particle is entering atom orbit (dist between "this" and "destination": the kernel)
		PVector dif = PVector.sub(destination, position);

		float d = dif.mag();

		// If it's close enough: change the bool (enter orbit)
		if(d < 50 && atome.mass > mass){

			// Make sure the increment only happens once
			if(!isInOrbit){
				atome.mass+=mass*0.05;
				atome.variationIncrement*=2;
			}
			isInOrbit = true;
		}


    // If it's not in orbit, stay free
		if(!isInOrbit){
			velocity.add(acceleration);
			position.add(velocity);
			acceleration.mult(0);
		}

    // or else...
		else {
			position.x = sin(orbiVal)*orbitRadiusX + destination.x;
			position.y = cos(orbiVal)*orbitRadiusY + destination.y;

			orbiVal+=orbitDirectionAndSpeed;
      PVector v = new PVector(position.x, position.y);
      history.add(v);
      
      // Limiting the trace to 50 copies
      if(history.size() > 50) {
        history.remove(0);
      }

		}

	}

	void display() {
		noStroke();
		fill(partColor);
		ellipse(position.x, position.y, mass/2, mass/2);
    fill(0);
    
    // Shadow effet    
    ellipse(position.x+10, position.y+15, mass/2, mass/2);
    for(int i = 0 ; i < history.size() ; i++){
      PVector v = history.get(i);
      int clr = (int)map(i, 0, history.size(), 0, 255);
      fill(255,255,255,clr);
      ellipse(v.x, v.y, mass/2, mass/2);
      fill(0);
      ellipse(v.x+10, v.y+15, mass/2, mass/2);
    }
		
	}


}