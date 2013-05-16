class Particle {
  float x;
  float y;
  float z;
  float size;
  int timeElapsed;
  int ANIMATION_TIME = 9;
  
  Particle() {
    init();
    timeElapsed = (int)random(ANIMATION_TIME);
  }
  
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
    
    timeElapsed = 0;
  }
  
  void draw() {
    if (timeElapsed < ANIMATION_TIME / 2) {
      ellipse(x, y, lerp(0, 14 * size, (float)timeElapsed / (ANIMATION_TIME / 2)), lerp(0, 2 * size, (float)timeElapsed / (ANIMATION_TIME / 2)));
    } else {
      ellipse(x, y, lerp(14 * size, 0, (float)(timeElapsed - ANIMATION_TIME / 2) / (ANIMATION_TIME / 2)), lerp(2 * size, 0, (float)(timeElapsed - ANIMATION_TIME / 2) / (ANIMATION_TIME / 2)));
    }
  }
  
  void tick() {
    timeElapsed++;
    
    if (timeElapsed >= ANIMATION_TIME) {
      init();
    }
  }
  
  void resetAnimation() {
  }
}
