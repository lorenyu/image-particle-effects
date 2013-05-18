float next;
boolean hasNext = false;

float randomNormal() {
  return randomNormal(0.0);
}

float randomNormal(float mean) {
  return randomNormal(mean, 1.0);
}

float randomNormal(float mean, float stddev) {
  if (hasNext) {
    hasNext = false;
    return next;
  }
  
  float u = random(1);
  float v = random(1);
  float x = sqrt(-2 * log(u)) * cos(2 * TWO_PI * v);
  next = sqrt(-2 * log(u)) * sin(2 * TWO_PI * v);
  next = mean + next * stddev;
  hasNext = true;
  
  return mean + x * stddev;
}
