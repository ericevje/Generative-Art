import peasy.*;
PeasyCam cam;

Symbol symbol;
float scl = 0; // Used for X rotation
int framerate = 24; // Pins the framerate to 24 fps. The control system and max velocity and acceleration are tied to this 
float set_point = PI; // Starting setpoint for the symbol. PI equates to the infinty symbol 
float min_error = 5.6e-4; // Minimum average error required before changing to the next symbol conformation

void settings(){
  size(800, 800, "processing.opengl.PGraphics3D");
}

void setup(){
  cam = new PeasyCam(this, 225);
  frameRate(framerate);
  symbol = new Symbol(50, 100);
  symbol.calc_curve_coords();
}

void draw(){
  background(12, 12, 12);
  
  // Rotation
  rotateZ(PI/2);
  rotateY(PI/8);
  rotateX(scl);
  
  // For debugging. Shows unit axes
  //draw_coordinates();
  
  symbol.show();

  symbol.advance_rings(set_point);
  
  float error = symbol.calc_error();
  
  // For debugging
  println(error);
  
  if (abs(error) < min_error) {
    if (set_point > 3) { // catches when setpoint is set to PI. 
      symbol.reset_rings();
      set_point = 0;
    }
    else {
      symbol.reset_rings();
      set_point = PI;
    }
  }
  
  scl += 0.025;
}

void draw_coordinates(){
  stroke(255, 0, 0); // x is red
  line(0, 100, 0, 0, 0, 0);
  
  stroke(0, 255, 0); // y is green
  line(0, 0, 0, 100, 0, 0);
  
  stroke(0, 0, 255); // z is blue
  line(0, 0, 0, 0, 0, 100);
}
    
