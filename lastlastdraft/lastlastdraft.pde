float angle;
float red;
float green;
float blue;
float r; 
float startGrow;
int NBALLS = 2000;  // Number of balls are in the sketch (try changing to higher or lower numbers).

Ball[] balls;

void setup() {
  size(800, 800, P3D);
  frameRate(25);
  balls = new Ball[NBALLS];
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(0);
  red = random(2,255);
  green = random(2,255);
  blue = random(2,255);

  //sphere lighting
  lights(); 
  lightSpecular(200, 200, 200);
  specular(255, 255, 255);
  shininess(30);
  float hw = width/4;
  float hh = height/4;
 
  pushMatrix();
  translate(width/2, height/2, 0); //center position
  noStroke();
  
  directionalLight(255, 255, 255,hw,hh,-3);
  
  startGrow++;  
 
  if (startGrow > 0 && r<300)
  {    
    r = r + 4;
    fill(red,green,blue);    
    sphere(r);
    popMatrix();
    rotateY(radians(angle)); //rotates sphere by its center
    pushMatrix();
  } 
  
  popMatrix();
  if (r > 300)
  {
     r = 301; //terminates startGrow method
    // rotateY(radians(angle));
     angle = angle++;
     fill(red,green,blue);    
  }    
 
  fill(red,green,blue);    
    
  angle = angle + 2; //rotation
  
  if (r > 299 ) //confetti appears
  { 

    for (Ball ball : balls) {
      ball.draw();
    }

    // Check to see if any balls have collided
    for (int i=0; i<balls.length; i++) {

      // Compare each ball with any untested others
      for (int j=i+1; j<balls.length; j++) {
        if (balls[i].hasCollidedWith(balls[j])) {
          balls[i].bounce(balls[j]);
        }
  
      }
    }
    // Move all the balls by one step.
    for (Ball ball : balls)
    {
      ball.move();
    }
    
    loop();
  }
}
