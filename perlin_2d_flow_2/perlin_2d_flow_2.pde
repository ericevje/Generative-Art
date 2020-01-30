float xoff = 0;
float yoff = 0;
float zoff = 0;
int cols;
int rows;
int scl = 4;
int count = 500;
float zinc = 0.001;
float prev_avg_red = 256;
color stroke_color = color(0, 0, 0, 5);
int max_speed = 20;
int vec_mag = 10;

PVector[] flowfield;

Particle[] particles = new Particle[count];

void setup() {
  size(1000, 1000);
  background(255);
  cols = floor(width / scl);
  println(cols);
  rows = floor(height / scl);
  flowfield = new PVector[rows*cols];
  for (int i = 0; i < flowfield.length; i++){
      flowfield[i] = new PVector(0,0);
  }
  println(flowfield.length);
  //flowfield = new P[rows*cols];
  //println(flowfield.length);
  
  for (int i = 0; i < count; i++){
    particles[i] = new Particle();
  }
}

void pixel_intensity(){
  loadPixels();
  float avg_red = 0;
  int len = pixels.length;
  for (int i = 0; i < len; i++){
    color c1 = pixels[i];
    avg_red += red(c1);
  }
  avg_red = avg_red / len;
  println(avg_red);
  
  if (avg_red < 100 && avg_red < prev_avg_red) {
    stroke_color = color(255, 255, 255, 50);
    max_speed = 5;
    vec_mag = 2;
    zinc *= -1;
    prev_avg_red = avg_red;
  }
  else if (avg_red >= 254 && avg_red > prev_avg_red) {
    background(255);
    stroke_color = color(0, 0, 0, 5);
    max_speed = 20; 
    vec_mag = 10;
    zinc *= -1;
    prev_avg_red = avg_red;
  }
  else{
    prev_avg_red = avg_red;
  }
}

void mouseClicked() {
  saveFrame();
}
    

void draw(){
  //background(255);
  //println(frameRate);
  pixel_intensity();
  for (int i = 0; i < count; i++){
    particles[i].follow(flowfield);
    particles[i].update(stroke_color, max_speed);
    particles[i].edges();
    particles[i].show();
  }
  yoff = 0;
  zoff += zinc;
  //println(zoff, zinc);
  for(int y = 0; y < rows; y++){
    xoff = 0;
    for(int x = 0; x < cols; x++){
      int index = (x + y * cols);
      float r_value = map(noise(xoff, yoff, zoff), 0, 1, 0, 6*PI);
      PVector v = PVector.fromAngle(r_value);
      v.setMag(vec_mag);
      flowfield[index] = v;
      //push();
      //translate(x * scl, y * scl);
      //rotate(v.heading());
      //stroke(0, 50);
      //strokeWeight(1);
      //line(0, 0, scl, 0);
      //pop();
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  //noLoop();
}
