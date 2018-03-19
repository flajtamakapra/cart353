/* Rilla's solution for exercise 4.9 in Daniel Shiffman's The Nature of Code,
based heavily on Shiffman's code for example 4.7.

Exercise 4.9
Expand the above example to include many repellers (using an array or ArrayList). */

ParticleSystem psMouth;
ParticleSystem psLeftEye;
ParticleSystem psRightEye;

Face face;
Repeller faceRepMouth = new Repeller();
Repeller faceRepLeftEye = new Repeller();




// OSC library
import oscP5.*;
OscP5 oscP5;
boolean searching = false;

void setup() {
  size(1920,1080);
  // OSC receiver - from openFrameworks program
  oscP5 = new OscP5(this, 8338);
  
  face = new Face();
  
  psMouth = new ParticleSystem(new PVector(width/2,50));
  psLeftEye = new ParticleSystem(new PVector(width/2,50));

}

void draw() {
  background(255);
  
  
  // Apply gravity force to all Particles
 // PVector gravity = new PVector(random(-1,1),random(-1,1));
  psLeftEye.applyRepeller(faceRepLeftEye);
  psMouth.applyRepeller(faceRepMouth);
  

      if(face.found > 0) {

        translate(face.posePosition.x,face.posePosition.y); 
        PVector mouthPos = new PVector(random(-face.mouthWidth, face.mouthWidth), random(-face.mouthHeight, face.mouthHeight));
        faceRepMouth.setPosition(mouthPos);
        psMouth.addParticle(mouthPos, 10.0);       
        PVector eyePos = new PVector(random(-face.eyeLeft, face.eyeLeft)-20, random(-face.eyeLeft, face.eyeLeft)-100);
        faceRepLeftEye.setPosition(eyePos);
        psLeftEye.addParticle(eyePos, 14.0);
        

    }

  // now call run on the particle system
  psMouth.run();
  psLeftEye.run();
}

// Randomise the particles position within limits or location
void randomiseParticlesPosition(){
  
}

// OSC CALLBACK FUNCTIONS
void oscEvent(OscMessage m) {
  face.parseOSC(m);
}
