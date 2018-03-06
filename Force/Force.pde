/*

Particle system:

There is a kernel, Atome, just one. 
Particles gravitate around the kernel.
When the particles get close to the kernel, if it's mass is inferior, it enter into kernel's orbit.
and can't get out.

The kernel movement is controled by the mouse.
By clicking, we create accelerator lines.
When the accelerator and the kernel's paths are crossing, the line is influencing the kernel's acceleration.

*/

Attractor atome;                    // The Kernel

// Particles container
ArrayList<Particle> particules = new ArrayList<Particle>();

// Accelerator container
ArrayList<Accelerator> accelerateurs = new ArrayList<Accelerator>();


int maxParts = 1000;
//int now = 0;
//int monde;

//float noiseScale = 0.02;

void setup() {
	size(1920, 1080);
 // fullScreen();
	frameRate(320);
  
  // Initiate the kernel
	PVector atomPos = new PVector(width/2, height/2);
	atome = new Attractor(10, atomPos);

  // Create all particles
	for(int i = 0 ; i < maxParts ; i++) {
		PVector pPos = new PVector(random(width), random(height));
		particules.add(new Particle((int)random(1, 15), pPos, false));
	}
}

void draw() {
	background(10);

  // Updating positions
	PVector atomeForce = new PVector(mouseX, mouseY);
	atome.applyForce(atomeForce);
	atome.update();
	atome.display();

	for(int i = 0 ; i < particules.size() ; i++){
		PVector f = atome.attract(particules.get(i));
		particules.get(i).applyForce(f);
		particules.get(i).update(atome.position);
    particules.get(i).display();

	}

  // Updating accelerator's movement and existence
  for(int i = 0 ; i < accelerateurs.size() ; i++) {   
    accelerateurs.get(i).update();
    accelerateurs.get(i).draw();
    
    // Crossing atom's path
    if(accelerateurs.get(i).position.x == atome.position.x){atome.applyForce(accelerateurs.get(i).velocity);}
    
    // Remove from container if dead
    if(!accelerateurs.get(i).isAlive){accelerateurs.remove(i);}
    
  }
}

void mouseClicked() {
  
  // Creating a new accelerator on mouse click and push into container
  PVector m = new PVector(mouseX, mouseY);
  PVector d = new PVector(random(-1, 1), 0);
  accelerateurs.add(new Accelerator(m, d));
}