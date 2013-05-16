/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */
 
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */ 

PImage img;  // Declare variable "a" of type PImage
ArrayList<Particle> particles = new ArrayList();

void setup() {
  size(640, 360);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("Clouds_over_the_Atlantic_Ocean.jpg");  // Load the image into the program
  noStroke();
  fill(255,255,255);
  
  for (int i = 0; i < 1248; i++) {
    particles.add(new Particle());
  }
  
  frameRate(5);
}

void draw() {
  // Displays the image at point (0, height/2) at half of its size
  image(img, 0, 0, 640, 360);
  
  for (Particle particle : particles) {
    particle.init();
    particle.draw();
  }
}
