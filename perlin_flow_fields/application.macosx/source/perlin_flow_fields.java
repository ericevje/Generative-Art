import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class perlin_flow_fields extends PApplet {

float xoff = 0;
float yoff = 0;
float zoff = 0;

public void setup() {
  
  
}

public void draw(){
  yoff = 0;
  zoff += 0.01f;
  loadPixels();
  for(int y = 0; y < height; y++){
    xoff = 0;
    for(int x = 0; x < width; x++){
      int index = (x + y * width);
      float r_value = noise(xoff, yoff, zoff) * 255;
      int r = PApplet.parseInt(r_value);
      int pixel_color = color(r, r, r, 255);
      pixels[index] = pixel_color;
      xoff += 0.01f;
    }
    yoff += 0.01f;
  }
  updatePixels();
}
  public void settings() {  size(200, 200);  pixelDensity(1); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "perlin_flow_fields" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
