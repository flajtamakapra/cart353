// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float lifespanDecrement;
  float numPoints;
  int outsideRadius;
  
  float mass = 1; // Let's do something better here!

  Particle(PVector l, float decrement) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l;
    lifespan = 255.0;
    lifespanDecrement = decrement;
    numPoints = (int)random(2,5);
    outsideRadius = (int)random(2,10);
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= lifespanDecrement;
  }

  // Method to display
  void display() {
// Shape drawing
    float angle = random(PI*2);
    float angleStep = 360.0/numPoints;
    fill(127,lifespan);
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

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
