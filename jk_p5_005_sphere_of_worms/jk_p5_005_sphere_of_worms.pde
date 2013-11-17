// Nov 2013
// http://jiyu-kenkyu.org
// http://kow-luck.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://kow-luck.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// If you want to use this work as free, or encourage me,
// please contact me via http://kow-luck.com/contact

//========================================
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
//========================================
public class Points {
  int PointSize = 15;
  int Step = 10;
  color Alpha = 70;

  int moveMax = 100;
  float circle_x, circle_y, circle_z, circle_diam, 
  spX, spY, circle_y_mov, circle_z_mov;
  //========================================
  Points(float xpos, float ypos, float zpos, float diameter, 
  float speedX, float speedY, float cYm, float cZm) {
    circle_x = xpos;
    circle_y = ypos;
    circle_z = zpos;
    circle_diam = diameter;
    spX = speedX;
    spY = speedY;
    circle_y_mov = cYm;
    circle_z_mov = cZm;
  }
  //========================================
  public void display() {
    stroke(255, Alpha);
    strokeWeight(PointSize);
    pushMatrix();
    translate(circle_x, circle_y, circle_z);

    this.rotation();
    this.drawMe();
  }
  //========================================
  private void drawMe() {
    float startRadius= (circle_diam)/2;
    for (int angle = 0; angle < 230; angle += Step) {
      float radiusNoise = random(0, 8);
      float radius = startRadius + radiusNoise;
      float point_x =radius * cos(radians(angle)); 
      float point_y =radius * sin(radians(angle));

      point(point_x, point_y);
      radius += radiusNoise;
    }
    popMatrix();
  }
  //========================================
  private void rotation() {
    float rotX = spX/100;
    float rotY = spY/100;
    rotateX(frameCount * rotX);
    rotateY(frameCount * rotY);
  }
  //========================================
  public void move() {
    circle_y += circle_y_mov;
    circle_z += circle_z_mov;
    if (circle_z < -moveMax || circle_z > moveMax) {
      circle_z_mov *=-1;
    }
    if (circle_y < -moveMax || circle_y > moveMax) {
      circle_y_mov *= -1;
    }
  }
}

