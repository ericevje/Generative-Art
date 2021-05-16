
  
// Spherical Geometry
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/025-spheregeometry.html
// https://youtu.be/RkuBWEkBrZA
// https://editor.p5js.org/codingtrain/sketches/qVs1hxt

import peasy.*;

PeasyCam cam;

PVector[][] globe;
int total = 300;
float offset = 0;
//color col_1 = color(0, 5, 30);
//color col_2 = color(20, 20, 100);
color col_1 = color(0,0,0);
color col_2 = color(30, 30, 30);

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 800);
  lights();
  colorMode(HSB);
  globe = new PVector[total+1][total+1];
  //background(0);
  loadPixels();
  color col;
  for (int y = 0; y < height; y++){
    for (int x = 0; x < width; x++){
      if (y > random(0, height)){
        col = col_1;
      } else{
        col = col_2;
      }
      //color pix_col = lerpColor(col1, col2, map(y + random(-width, width), 0, height, 0, 1));
      pixels[x + y * width] = col;
    }
  }
  updatePixels();
}

void draw() {
  //translate(width/2, height/2);
  offset += 0.1;
  rotateX(offset * 0.02);
  rotateY(offset * 0.09);
  //rotateZ(offset * 0.5); 
  //background(0);
  noStroke();
  lights();
  //float r = 200;
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, 0, TWO_PI);
      
      float xoff = sin(lat) * cos(lon) + tan(offset) + 1;
      float yoff = sin(lat) * cos(lon) + sin(offset) + 1;
      float zoff = cos(lat) + sin(offset) + 1;
      
      float r = map(noise(xoff, yoff, zoff), 0, 1, 200, 400);
      
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      globe[i][j] = new PVector(x, y, z);
      stroke(255, 1);
      //strokeWeight(4);
      point(x, y, z);
    }
  }
}

void keyPressed(){
  saveFrame();
}
