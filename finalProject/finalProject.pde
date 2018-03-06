
import oscP5.*;
import ddf.minim.*;

OscP5 oscP5;
Minim minim;
AudioInput in;


// our FaceOSC tracked face dat
Face face = new Face();

// Particles container
ArrayList<Particle> particules = new ArrayList<Particle>();
ArrayList<Particle> secondesParticules = new ArrayList<Particle>();

// All numbers
int nbParticules = 100;
int nbSecondesParticules = 500;

// Particles distribution (%)
int portionOeilDroit = 15*nbParticules/100;
int portionOeilGauche = 15*nbParticules/100;
int portionBouche = 60*nbParticules/100;
int portionNarineGauche = 5*nbParticules/100;
int portionNarineDroite = 5*nbParticules/100;
boolean isShaking = false;
boolean searching = false;


void setup() {
  //size(1920, 1080);
  fullScreen();
  frameRate(320);
  
  // OSC receiver - from openFrameworks program
  oscP5 = new OscP5(this, 8338);
  
  // Initiate all particles
  for(int i = 0 ; i < nbParticules ; i++){
    PVector pPos = new PVector(random(width), random(height));
    particules.add(new Particle((int)random(1,1.1), pPos,(int)random(100, 255)));
   }
  for(int i = 0 ; i < nbSecondesParticules ; i++){
    PVector pPos = new PVector(random(width), random(height));
    secondesParticules.add(new Particle((int)random(1,1.1), pPos, (int)random(10, 100)));
  }
  
  // Sound response
  minim = new Minim(this);
  minim.debugOn();
  
  in = minim.getLineIn(Minim.STEREO, 512);
   
   
}

void draw() {  
  background(0);
  stroke(255);

  // Makes them move
  for(int i = 0 ; i < particules.size() ; i++){
    particules.get(i).update();
    particules.get(i).display();   
  }  
  for(int i = 0 ; i < secondesParticules.size() ; i++){
    secondesParticules.get(i).update();
    secondesParticules.get(i).display();   
  }
  
  if(searching){
    // If receiving data from FaceOSC
  if(face.found > 0) {
    translate(face.posePosition.x, face.posePosition.y);
    scale(face.poseScale);
    noFill();
    stroke(255);

    // Iterate trough the first particles array, usefull to keep the proportions correctly.
    int iterateur = 0;
    for(int i = 0; i < portionBouche ; i++){
      
        PVector f = face.attract(particules.get(iterateur), random(-face.mouthWidth*6, face.mouthWidth*6),random(face.mouthHeight/2)+20);
        particules.get(iterateur).applyForce(f);
        particules.get(iterateur).update();
        iterateur++;
    }
    for(int i = 0 ; i < portionOeilGauche ; i++) {
      PVector f = face.attract(particules.get(iterateur), random(-face.eyeLeft*2, face.eyeLeft*2)-100,random(face.eyeLeft)-250);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;

    }
    for(int i = 0 ; i < portionOeilDroit ; i++ ) {
      PVector f = face.attract(particules.get(iterateur), random(-face.eyeRight*2, face.eyeRight*2)+100,random(face.eyeRight)-250);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    for(int i = 0 ; i < portionNarineGauche ; i++ ) {
      PVector f = face.attract(particules.get(iterateur), random(-face.nostrils*2, face.nostrils*2)-25,random(face.nostrils)-100);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    for(int i = 0 ; i < portionNarineDroite ; i++ ) {
      PVector f = face.attract(particules.get(iterateur), random(-face.nostrils*2, face.nostrils*2)+25,random(face.nostrils)-100);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    // Apply force on second particles set
    for(int i = 0 ; i < nbSecondesParticules ; i++) {
      PVector f = face.attract(secondesParticules.get(i), random(-face.jaw*150, face.jaw*150),random(-face.jaw*250, face.jaw*250)-100);
      secondesParticules.get(i).applyForce(f);
      secondesParticules.get(i).update();
    
    }
  
    
   

      for(int i = 0 ; i < in.bufferSize() ; i++) {
        int max = in.bufferSize();
        int min = particules.size();
        int mappedI = (int)map(i, 0, max, 0, min);
        mappedI = constrain(mappedI, 0, 99);
        particules.get(mappedI).shake((int)(in.left.get(i)*50));
      
      }  
     
  }
    
    
  }
  
}

// OSC CALLBACK FUNCTIONS
void oscEvent(OscMessage m) {
  face.parseOSC(m);
}

void mouseClicked() {
  searching = !searching;
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}