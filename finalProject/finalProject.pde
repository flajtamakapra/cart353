/*
Jeremie Desmarais
Particles reacting to Computer Vision:
Face detection and contour tracing. 

1st version need to be runned with FaceOSC 
Receiving face details via OSC. 

Click anywhere on the screen to activate particles face tracking

A poetic look of the presence of humanity and inviduals in the virtual world as a reflection
of itself


 -----** Update for assignment 4: Added different reactions from the particles: 
  - On the mouth and the nostrils: There is a breathing effect, particles go out and go in.


*/


// OSC library
import oscP5.*;

// Sound lib
import ddf.minim.*;

OscP5 oscP5;
Minim minim;
AudioInput in;


// our FaceOSC tracked face dat
//Face face = new Face();
Face mouth = new FaceMouth();

// Particles container
//ArrayList<Particle> particules = new ArrayList<Particle>();
//ArrayList<Particle> secondesParticules = new ArrayList<Particle>();
//ArrayList<Particle> breathe = new ArrayList<Particle>();


ParticleSystem mouthParticles, eyesParticles, nostrilsParticles, backgroundParticles;


// All numbers
int nbParticules = 100;
int nbSecondesParticules = 500;
int breatheParticules = 100;

// Particles distribution (%)
int portionOeilDroit = 15*nbParticules/100;
int portionOeilGauche = 15*nbParticules/100;
int portionBouche = 60*nbParticules/100;
int portionNarineGauche = 5*nbParticules/100;
int portionNarineDroite = 5*nbParticules/100;
boolean isShaking = false;
boolean searching = false;


void setup() {
  size(1920, 1080);
  //fullScreen();
  frameRate(320);
  
  // OSC receiver - from openFrameworks program
  oscP5 = new OscP5(this, 8338);
  mouthParticles = new ParticleSystem(new PVector((int)random(width), (int)random(height)));
  eyesParticles = new ParticleSystem(new PVector((int)random(width), (int)random(height)));
  nostrilsParticles = new ParticleSystem(new PVector((int)random(width), (int)random(height)));
  backgroundParticles = new ParticleSystem(new PVector((int)random(width), (int)random(height)));
  
  
  //// Initialize all particles
  //for(int i = 0 ; i < nbParticules ; i++){
  //  PVector pPos = new PVector(random(width), random(height));
  //  particules.add(new Particle((int)random(1,1.1), pPos,(int)random(100, 255)));
  // }
  //for(int i = 0 ; i < nbSecondesParticules ; i++){
  //  PVector pPos = new PVector(random(width), random(height));
  //  secondesParticules.add(new Particle((int)random(1,1.1), pPos, (int)random(10, 100)));
  //}
  //for(int i = 0 ; i < breatheParticules ; i++){
  //  PVector pPos = new PVector(random(-mouth.orWidth, mouth.orWidth), random(-mouth.orHeight, mouth.orHeight));
  //  breathe.add(new Particle((int)random(1,1.1), pPos, (int)random(10, 100)));  
  //}

    
  
  
  // Sound response
  minim = new Minim(this);
  minim.debugOn();
  
  in = minim.getLineIn(Minim.STEREO, 512);
   
   
}

void draw() {  
  background(0);
  stroke(255);

  // Makes them move
  //for(int i = 0 ; i < particules.size() ; i++){
  //  particules.get(i).update();
  //  particules.get(i).display();   
  //}  
  //for(int i = 0 ; i < secondesParticules.size() ; i++){
  //  secondesParticules.get(i).update();
  //  secondesParticules.get(i).display();   
  //}
  
  PVector gravity = new PVector(0,0);
  mouthParticles.applyForce(gravity);
  

  
  // A switch to enable / disable searching - for the presentation
  if(searching){
      // If receiving data from FaceOSC
      if(mouth.found > 0) {
        translate(mouth.posePosition.x, mouth.posePosition.y);
        scale(mouth.poseScale);
        noFill();
        stroke(255);
        mouthParticles.applyRepeller(mouth);
        
        soundReaction();
      }
  }
  
}
// OSC CALLBACK FUNCTIONS
void oscEvent(OscMessage m) {
  mouth.parseOSC(m);
}

void mouseClicked() {
  searching = !searching;
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
