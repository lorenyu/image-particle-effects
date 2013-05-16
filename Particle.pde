class Particle {
  float x;
  float y;
  float z;
  float size;
  int timeElapsed;
  
  void init() {    
    y = random(223,height);
    z = (height - 223 + 1)/(y - 223 + 1)/(360 - 223);
    // z is in range (0,1]
    z = lerp(1, 30, z);
    // z goes from 1 to 50
    size = 1.0 / z;
    
    // 30, 50, 100, 1000
    int i = (int)random(0, 30 + 30 + 30 + 50 + 100 + 1000);
    if (i < 30) {
      x = 350 + random(-150, 150) / z;
    } else if (i < 30 + 30) {
      x = 350 + random(-100, 100) / z;
    } else if (i < 30 + 30 + 30) {
      x = 350 + random(-80, 80) / z;
    } else if (i < 30 + 30 + 30 + 50) {
      x = 350 + random(-35, 35) / z;
    } else if (i < 30 + 30 + 30 + 50 + 100) {
      x = 350 + random(-15, 15) / z;
    } else {
      x = width/2 + random(-width /2 * (360 - 223), width /2 * (360 - 223)) / z;
    }
  }
  
  void draw() {
    ellipse(x, y, 7*size, size);
  }
  
  void tick() {
  }
  
  void resetAnimation() {
  }
}
