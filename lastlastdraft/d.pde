class Ball {
  float x, y;                   // Ball position.
  float diameter;               // Ball diameter.
  color colour;                 // Ball colour.
  float dx, dy;                 // Movement increments.
 
  // Constructor - this is called whenever a new ball is created.
  Ball() {
    // Initialise the state of the ball with some random values.
    float minDiameter = sqrt(width*height/NBALLS/12.5);
    diameter = random(1.0, 2.0) * minDiameter;
    x = random(width*0.5, width*0.45);
    y = random(height*0.5, height*0.45);
    colour = color(random(5, 250), random(5, 250), random(5, 250));
    dx = random(-0.25, 0.25) * minDiameter;
    dy = random(-0.25, 0.25) * minDiameter;
  }
 
  void draw() {
    noStroke(); 
    fill(colour);
    circle(x, y, diameter);
  }
 
  void move() {
    // Make balls bounce off edge.   
    if (x <= diameter/2) dx = abs(dx);
    if (y <= diameter/2) dy = abs(dy);
    if (x >= width-diameter/2) dx = -abs(dx);
    if (y >= height-diameter/2) dy = -abs(dy);
 
    x += dx;
    y += dy;
  }
 
  boolean hasCollidedWith(Ball anotherBall) {
    return dist(x, y, anotherBall.x, anotherBall.y) <= (diameter+anotherBall.diameter)/2;
  }
 
  void bounce(Ball anotherBall) {
    // Calculate bounce angle of the two balls.
    float collisionAngle = atan2(anotherBall.y-y, anotherBall.x-x);
    float collisionX = cos(collisionAngle);
    float collisionY = sin(collisionAngle);
    float collisionXTangent = cos(collisionAngle+HALF_PI);
    float collisionYTangent = sin(collisionAngle+HALF_PI);
    float collisionPx = x + diameter/2*collisionX;
    float collisionPy = y + diameter/2*collisionY;
 
    float v1 = sqrt(dx*dx + dy*dy);
    float v2 = sqrt(anotherBall.dx*anotherBall.dx+anotherBall.dy*anotherBall.dy);
 
    float d1 = atan2(dy, dx);
    float d2 = atan2(anotherBall.dy, anotherBall.dx);
 
    float v1x = v1*cos(d1-collisionAngle);
    float v1y = v1*sin(d1-collisionAngle);
 
    float v2x = v2*cos(d2-collisionAngle);
    float v2y = v2*sin(d2-collisionAngle);
 
    dx = collisionX*v2x + collisionXTangent*v1y;
    dy = collisionY*v2x + collisionYTangent*v1y;
 
    x = collisionPx - 0.5*diameter*collisionX;
    y = collisionPy - 0.5*diameter*collisionY;
 
    anotherBall.dx = collisionX*v1x + collisionXTangent*v2y;
    anotherBall.dy = collisionY*v1x + collisionYTangent*v2y;
 
    anotherBall.x = collisionPx + 0.5*anotherBall.diameter*collisionX;
    anotherBall.y = collisionPy + 0.5*anotherBall.diameter*collisionY;
  }
}
