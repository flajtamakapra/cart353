
// Distribute particles according to the percentages declared at the begining.
void distribute(FaceMouth orifice) {
  /*
    fnct de dist idéale:
    Entrée: Nombre de particules à placer
    Entrée: Tableau d'index, réinitialisé à chaque frame. 
    
    void distribute(FaceOrifice o, int nbParticulesAPlacer, arrayList<Particle> p){
      for(int i = 0 ; i < nbParticulesAPlacer ; i++) {
        PVector f = o.attract(p.get(i), 
      }
    
    }
    
     
  
  
  
  */
  
  
  /*
  
  // Iterate trough all the particles arrays, usefull to keep the proportions correctly.
    int iterateur = 0;
    for(int i = 0; i < portionBouche ; i++){
      
      PVector f = orifice.attract(particules.get(iterateur), random(-orifice.mouthWidth, orifice.mouthWidth),random(orifice.mouthHeight));
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;
    }
    for(int i = 0 ; i < portionOeilGauche ; i++) {
      PVector f = orifice.attract(particules.get(iterateur), random(-orifice.eyeLeft, orifice.eyeLeft*2)-100,random(orifice.eyeLeft)-200);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;

    }
    for(int i = 0 ; i < portionOeilDroit ; i++ ) {
      PVector f = orifice.attract(particules.get(iterateur), random(-orifice.eyeRight*2, orifice.eyeRight*2)+100,random(orifice.eyeRight)-250);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    for(int i = 0 ; i < portionNarineGauche ; i++ ) {
      PVector f = orifice.attract(particules.get(iterateur), random(-orifice.nostrils*2, orifice.nostrils*2)-25,random(orifice.nostrils)-100);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    for(int i = 0 ; i < portionNarineDroite ; i++ ) {
      PVector f = orifice.attract(particules.get(iterateur), random(-orifice.nostrils*2, orifice.nostrils*2)+25,random(orifice.nostrils)-100);
      particules.get(iterateur).applyForce(f);
      particules.get(iterateur).update();
      iterateur++;    
    }
    // Apply force on second particles set
    for(int i = 0 ; i < nbSecondesParticules ; i++) {
      PVector f = orifice.attract(secondesParticules.get(i), random(-orifice.jaw*150, orifice.jaw*150),random(-orifice.jaw*250, orifice.jaw*250)-100);
      secondesParticules.get(i).applyForce(f);
      secondesParticules.get(i).update();
    
    }  */
}


// Audio Reaction
void soundReaction() {
  
    // take some particles and make them move with AudioInput
      for(int i = 0 ; i < in.bufferSize() ; i++) {
        int max = in.bufferSize();
        int min = particules.size();
        int mappedI = (int)map(i, 0, max, 0, min);
        mappedI = constrain(mappedI, 0, 99);
        particules.get(mappedI).shake((int)(in.left.get(i)*50));
      
      }
      
}
