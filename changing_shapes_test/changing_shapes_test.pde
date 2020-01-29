//Change shape based on key pressed

class key_object {
  
  color r, g, b;
  float shape_height;
  float shape_length;
  
  key_object(){
    stroke(255);
    ellipse(100,100,100,100);
  }
  
  void shape_define(){
    if (((int)key > (int)'a') && ((int)key < (int)'m')) {
      int[] color_array = {(int)random(255), (int)random(255), (int)random(255)};
      println(color_array);
      stroke(color_array[0], color_array[1], color_array[2]);
      fill(color_array[0], color_array[1], color_array[2]);
      ellipse(width/2, height/2, random(width/2), random(height/2));
    }
    else{
      int[] color_array = {(int)random(255), (int)random(255), (int)random(255)};
      stroke(color_array[0], color_array[1], color_array[2]);
      fill(color_array[0], color_array[1], color_array[2]);
      rectMode(CENTER);
      rect(width/2, height/2, random(width/2), random(height/2));
    }
  }
  
  void fade(){
    
  }
}

key_object object;

void setup(){
  size(800, 800);
  object = new key_object();
}

void draw(){
  background(0);
  if (keyPressed == true){
    object.shape_define();
  }
  else{
    stroke(255);
    fill(0);
    ellipse(width/2, height/2, width/8, height/8);
  }
  delay(50);
}
