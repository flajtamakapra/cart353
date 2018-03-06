//
// a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// this example includes a class to abstract the Face data
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//
import oscP5.*;

// a single tracked face from FaceOSC
class Face {
  
  // num faces found
  int found;
  
  // pose
  float poseScale;
  PVector posePosition = new PVector();
  PVector poseOrientation = new PVector();
  
  // gesture
  float mouthHeight, mouthWidth;
  float eyeLeft, eyeRight;
  float eyebrowLeft, eyebrowRight;
  float jaw;
  float nostrils;
  
  // Attraction properties
  int G = 40;
  int mass = 10;
  
  Face() {}
  
  
  // Will attract particles
  PVector attract(Particle p, float w, float h) {
    
    // Attraction's position
    PVector position = new PVector(posePosition.x+w, posePosition.y+h);
        
    // Force direction
    PVector force = PVector.sub(position, p.position);

    // Distance
    float d  = force.mag();
    d = constrain(d, 0.0, 25.0);

    // Unit vector for direction
    force.normalize();

    
    // Calcutate and Apply attraction
    float strength = (G * mass * p.mass) / (d*d);
    force.mult(strength);

    return force;

  }

  // parse an OSC message from FaceOSC
  // returns true if a message was handled
  
  // Also, mapping all coordinates to fit the sketch: FaceOSC sketch being 640x480 (too small)
  boolean parseOSC(OscMessage m) {
    
    if(m.checkAddrPattern("/found")) {
        found = m.get(0).intValue();
        return true;
    }      
          
    // pose
    else if(m.checkAddrPattern("/pose/scale")) {
        poseScale = m.get(0).floatValue();
        poseScale*=2;
        return true;
    }
    else if(m.checkAddrPattern("/pose/position")) {
        posePosition.x = m.get(0).floatValue();
        posePosition.y = m.get(1).floatValue();
        posePosition.x = map(posePosition.x, 0, 640, 0, width);
        posePosition.y = map(posePosition.y, 0, 480, 0, height);
        return true;
    }
    else if(m.checkAddrPattern("/pose/orientation")) {
        poseOrientation.x = m.get(0).floatValue();
        poseOrientation.y = m.get(1).floatValue();
        poseOrientation.z = m.get(2).floatValue();
        return true;
    }
    
    // gesture
    else if(m.checkAddrPattern("/gesture/mouth/width")) {
        mouthWidth = m.get(0).floatValue();
        mouthWidth = map(mouthWidth, 0, 640, 0, width);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/mouth/height")) {
        mouthHeight = m.get(0).floatValue();
        mouthHeight = map(mouthHeight, 0, 480, 0, height);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eye/left")) {
        eyeLeft = m.get(0).floatValue();
        eyeLeft = map(eyeLeft, 0, 640, 0, width);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eye/right")) {
        eyeRight = m.get(0).floatValue();
        eyeRight = map(eyeRight, 0, 640, 0, width);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/left")) {
        eyebrowLeft = m.get(0).floatValue();
        eyebrowLeft = map(eyebrowLeft, 0, 640, 0, width);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/right")) {
        eyebrowRight = m.get(0).floatValue();
        eyebrowRight = map(eyebrowRight, 0, 640, 0, width);
        return true;
    }
    else if(m.checkAddrPattern("/gesture/jaw")) {
        jaw = m.get(0).floatValue();
        return true;
    }
    else if(m.checkAddrPattern("/gesture/nostrils")) {
        nostrils = m.get(0).floatValue();
        return true;
    }
    
    return false;
  }

  
  // get the current face values as a string (includes end lines)
  String toString() {
    return "found: " + found + "\n"
           + "pose" + "\n"
           + " scale: " + poseScale + "\n"
           + " position: " + posePosition.toString() + "\n"
           + " orientation: " + poseOrientation.toString() + "\n"
           + "gesture" + "\n"
           + " mouth: " + mouthWidth + " " + mouthHeight + "\n"
           + " eye: " + eyeLeft + " " + eyeRight + "\n"
           + " eyebrow: " + eyebrowLeft + " " + eyebrowRight + "\n"
           + " jaw: " + jaw + "\n"
           + " nostrils: " + nostrils + "\n";
  }

  
};