/*
  Particles follow the face found in the webcam
 Particles flow differently depending of the orifice "gravity"
 
 
 *to do
 When sound comes vis the microphone, the mouth's particles go crazy
 
 
 **
 Started from the shiffmans's particlesSystem example and Rilla Khaled's modifications.
 
 
 */




// Sound lib
import ddf.minim.*;

// OSC library
import oscP5.*;



OscP5 oscP5;
Minim minim;
AudioInput in;

ParticleSystem psMouth = new ParticleSystem(100);
ParticleSystem psLeftEye = new ParticleSystem(25);
ParticleSystem psRightEye = new ParticleSystem(25);
ParticleSystem psLeftNostril = new ParticleSystem(10);
ParticleSystem psRightNostril = new ParticleSystem(10);

Face face;
Force faceForce = new Force(80);
Force leftEyeForce = new Force(100);
Force rightEyeForce = new Force(40);
Force leftNostrilForce = new Force(40);
Force rightNostrilForce = new Force(40);





void setup() {
  size(1920, 1080);
  // OSC receiver - from openFrameworks program
  oscP5 = new OscP5(this, 8338);
  face = new Face();

  //psMouth = new ParticleSystem(new PVector(width/2,50));
  // Sound response
  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO, 512);
}

void draw() {
  background(0);


  // Apply gravity force to all Particles
  // PVector gravity = new PVector(random(-1,1),random(-1,1));



  if (face.found > 0) {

    PVector mouthPos = new PVector(random(-face.mouthWidth, face.mouthWidth)*5, random(-face.mouthHeight, face.mouthHeight)/3);
    placeParticles(mouthPos, psMouth, faceForce);

    PVector leftEyePos = new PVector(random(-face.eyeLeft, face.eyeLeft)+75, -200);
    placeParticles(leftEyePos, psLeftEye, leftEyeForce);

    PVector rightEyePos = new PVector(random(-face.eyeRight, face.eyeRight)-75, -200);
    placeParticles(rightEyePos, psRightEye, rightEyeForce);

    PVector leftNostrilPos = new PVector(random(-face.nostrils, face.nostrils)-30, -100);
    placeParticles(leftNostrilPos, psLeftNostril, leftNostrilForce);

    PVector rightNostrilPos = new PVector(random(-face.nostrils, face.nostrils)+30, -100);
    placeParticles(rightNostrilPos, psRightNostril, rightNostrilForce);
  }

  // now call run on the particle system
  psMouth.run();
  psLeftEye.run();
  psRightEye.run();
  psLeftNostril.run();
  psRightNostril.run();
  soundReaction();
}

// Randomise the particles position within limits or location
void placeParticles(PVector particlesWithin, ParticleSystem ps, Force f) {
  particlesWithin.add(face.posePosition);
  f.setPosition(particlesWithin);
  ps.applyForce(f);
}

// Audio Reaction
void soundReaction() {
  float total = 0;
  // take some particles and make them move with AudioInput
  for (int i = 0; i < in.bufferSize(); i++) {
    total+=in.left.get(i);
  }

  total = map(total, -15, 15, 200, 0);
}

// OSC CALLBACK FUNCTIONS
void oscEvent(OscMessage m) {
  face.parseOSC(m);
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
