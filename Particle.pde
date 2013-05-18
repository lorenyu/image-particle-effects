class Particle {
  float x;
  float y;
  float z;
  float size;
  int timeElapsed;
  int ANIMATION_TIME = 11;
  
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
    
    if (random(5) < 3) {
      x = 344 + randomNormal(0, width / 20) / z;
    } else {
      x = 344 + randomNormal(0, width / 3) / z;
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
