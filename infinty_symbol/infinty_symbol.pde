import peasy.*;
PeasyCam cam;

Ring ring;
Symbol symbol;
PVector ring_pos;
float x = 0;
float scl = 0;
int framerate = 24;
float set_point = PI;
float min_error = 5.6e-4;




void settings(){
  size(800, 800, "processing.opengl.PGraphics3D");
}

void setup(){
  cam = new PeasyCam(this, 225);
  frameRate(framerate);
  symbol = new Symbol(50, 1, .6, .9, 0);
  symbol.calc_curve_coords();
}

void draw(){
  background(12, 12, 12);
  rotateZ(PI/2);
  //rotateX(PI/4);
  rotateY(PI/8);
  rotateX(scl);
  //rotateY(-PI/4);
  
  //draw_coordinates();
  symbol.show();
  
  symbol.advance_rings(set_point);
  float error = symbol.calc_error();
  println(error);
  if (abs(error) < min_error) {
    if (set_point > 3) {
      symbol.reset_rings();
      set_point = 0;
    }
    else {
      symbol.reset_rings();
      set_point = PI;
    }
  }
  scl += 0.025;
  
  
  //symbol.debug_show_guide_curves();
  //x = x + scl;
  
  //saveFrame("frame-#####.jpg");
  //if (x >= 2*PI){
  //  exit();
  //}
}

void draw_coordinates(){
  stroke(255, 0, 0); // x is red
  line(0, 100, 0, 0, 0, 0);
  
  stroke(0, 255, 0); // y is green
  line(0, 0, 0, 100, 0, 0);
  
  stroke(0, 0, 255); // z is blue
  line(0, 0, 0, 0, 0, 100);
}
    
