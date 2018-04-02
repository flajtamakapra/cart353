// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position;
    particles = new ArrayList<Particle>();
  }

  ParticleSystem(int nbParticles) {
    particles = new ArrayList<Particle>();
    for (int i = 0; i < nbParticles; i++ ) {
      PVector pos = new PVector(random(width), random(height));
      particles.add(new Particle(pos, 0));
    }
  }
  
  ParticleSystem(int nbParticles, int limit) {
    particles = new ArrayList<Particle>();
    for (int i = 0; i < nbParticles; i++ ) {
      PVector pos = new PVector(random(width), random(height));
      particles.add(new Particle(pos, 0, limit));
    }
}


  void addParticle(PVector pos, float dec) {

    particles.add(new Particle(pos, dec));
  }

  // A function to apply a force to all Particles
  void applyForce(PVector f) {
    for (Particle p : particles) {
      p.applyForce(f);
    }
  }

  void applyRepeller(Force f) {
    // for each particle in this system
    for (Particle p : particles) {
      PVector force = f.repel(p);        
      p.applyForce(force);
    }
  }
  void applyForce(Force f) {
    for (Particle p : particles) {
      PVector force = f.attract(p);        
      p.applyForce(force);
    }
  }


  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
