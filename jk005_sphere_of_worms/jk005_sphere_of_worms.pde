import processing.opengl.*;

int NUM_POINTS = 270;
Points[] points = new Points[NUM_POINTS];
int Radius = 500; 
float s = 0;
float t = 0;
float X, Y, Z, DIAM, rX, rY, circle_y_mov, circle_z_mov;
int zView, zViewInc;

//========================================
void setup() {
  size(1280, 720, OPENGL);
  frameRate(30);

  for (int i = 0; i < NUM_POINTS; i++) {    
    s += 12;  
    t += 1;   
    float radianS = radians(s);
    float radianT = radians(t);

    X = 0 + (Radius * cos(radianS) * sin(radianT));
    Y = 0 + (Radius * sin(radianS) * sin(radianT));
    Z = 0 + (Radius * cos(radianT));

    DIAM = random(30, 150);
    rX = random(-5, 5);
    rY = random(-5, 5);
    circle_y_mov = 0.5;
    circle_z_mov = 1.0;
    points[i] = new Points(X, Y, Z, DIAM, rX, rY, circle_y_mov, circle_z_mov);
  }
  zView =  -width*2;
  zViewInc = 6;
}
//========================================
void draw() {
  background(0);
  translate(0, 0, zView);
  zView += zViewInc;
  if (zView < -width*2 || zView >width/10*6) {
    zViewInc *= -1;
  }
  translate(width/2, height/2, 0);  
  rotateY(frameCount * 0.003);
  rotateX(frameCount * 0.004);
  for (int i = 0; i < NUM_POINTS; i++) {
    points[i].display();
    points[i].move();
  }
  println(frameRate);
}

