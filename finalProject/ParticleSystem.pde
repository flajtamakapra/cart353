// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }


  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle(int m, PVector p, int c) {
    //particles.add(new Particle(origin));

    // we will spawn particles from the mouse to make it easy
    // to check if our repellers are working
    particles.add(new Particle(m, p ,c));
  }

  // A function to apply a force to all Particles
  void applyForce(PVector f) {
    for (Particle p : particles) {
      p.applyForce(f);
    }
  }

  void applyRepeller(Face r) {
    // for each particle in this system
    for (Particle p : particles) {
      // work out the repel force for this repeller
      PVector force = r.repel(p);        
      // apply that force to the particle
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
