float xoff = 0;
float yoff = 0;
float zoff = 0;
float inc = 0.1;
int cols;
int rows;
float scl = 4;
float count;
float zinc = 0.001;
float prev_avg_red = 256;
color stroke_color = color(0, 0, 0, 5);
float max_speed_black;
float max_speed_white;
float vec_mag_black;
float vec_mag_white;
float max_speed;
float vec_mag;

PVector[] flowfield;
Particle[] particles;

void setup() {
  // Must be >= 800x800
  size(800, 800);
  background(255);
  cols = floor(width / scl);
  rows = floor(height / scl);
  flowfield = new PVector[rows*cols];
  float flo_height = float(height);
  float flo_width = float(width);
  count = ((flo_width * flo_height) / (800.0 * 800.0)) * 1000.0;
  max_speed_black = (((flo_width + flo_height)/2.0) / 800.0) * 20.0;
  max_speed_white = (((flo_width + flo_height)/2.0) / 800.0) * 5.0;
  vec_mag_black = (((flo_width + flo_height)/2.0) / 800.0) * 10.0;
  vec_mag_white = (((flo_width + flo_height)/2.0) / 800.0) * 2.0;
  //inc = inc * pow((((flo_width + flo_height)/2.0) / 800.0), 1.9);
  scl = (((flo_width + flo_height)/2.0) / 800.0) * scl;
  
  println(width, height, count, max_speed_black, max_speed_white, vec_mag_black, vec_mag_white, scl);
  
  max_speed = max_speed_black;
  vec_mag = vec_mag_black;
  
  particles = new Particle[int(count + 1)];
  for (int i = 0; i < flowfield.length; i++){
      flowfield[i] = new PVector(0,0);
  }
  //println(flowfield.length);
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
  //println(avg_red);
  
  if (avg_red < 100 && avg_red < prev_avg_red) {
    stroke_color = color(255, 255, 255, 50);
    max_speed = max_speed_white;
    vec_mag = vec_mag_white;
    zinc *= -1;
    prev_avg_red = avg_red;
  }
  else if (avg_red >= 254 && avg_red > prev_avg_red) {
    background(255);
    stroke_color = color(0, 0, 0, 5);
    max_speed = max_speed_black; 
    vec_mag = vec_mag_black;
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
  println(zoff);
  pixel_intensity();
  for (int i = 0; i < count; i++){
    particles[i].follow(flowfield);
    particles[i].update(stroke_color, int(max_speed));
    particles[i].edges();
    particles[i].show();
  }
  //println(stroke_color, max_speed, vec_mag);
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
      xoff += inc;
    }
    yoff += inc;
  }
  //noLoop();
}
