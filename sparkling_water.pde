/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */
 
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */ 

PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(640, 360);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("Clouds_over_the_Atlantic_Ocean.jpg");  // Load the image into the program
  noStroke();
  fill(255,255,255);
  
  frameRate(5);
}

void draw() {
  // Displays the image at point (0, height/2) at half of its size
  image(img, 0, 0, 640, 360);
  
  
  for (int i = 0; i < 1000; i++) {
    float y = random(223,height);
    float z = (height - 223 + 1)/(y - 223 + 1)/(360 - 223);
    // z is in range (0,1]
    z = lerp(1, 30, z);
    // z goes from 1 to 50
    float size = 1.0 / z;
    float x = width/2 + random(-width /2 * (360 - 223), width /2 * (360 - 223)) / z;
    ellipse(x, y, 7*size, size);
    if (i % 32 == 0) {
      x = 350 + random(-150, 150) / z;
      ellipse(x, y, 7*size, size); 
    }
    if (i % 32 == 0) {
      x = 350 + random(-100, 100) / z;
      ellipse(x, y, 7*size, size); 
    }
    if (i % 32 == 0) {
      x = 350 + random(-80, 80) / z;
      ellipse(x, y, 7*size, size); 
    }
    if (i % 20 == 0) {
      x = 350 + random(-35, 35) / z;
      ellipse(x, y, 7*size, size); 
    }
    if (i % 10 == 0) {
      x = 350 + random(-15, 15) / z;
      ellipse(x, y, 7*size, size); 
    }
//    float z = random(10.0, 100.0);
//    float x = random(50.0);
//    float size = 100/z;
//    x /= z;
//    float y = lerp(227, 360, 100.0/z);
//    rect(x, y, size, size);
  }
}
