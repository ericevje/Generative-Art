

void setup(){
  size(800, 800);
  loadPixels();
  for (int y = 0; y < 800; y ++){
    for (int x = 0; x < 800; x++){
      int index = x + y * 800;
      if (y % 2 == 0){
        pixels[index] = color(0, 0, 0);
        //pixels[index + 800] = color(0,0,0);
      }
      else{
        pixels[index] = color(255, 255, 255);
        //pixels[index + 800] = color(255, 255, 255);
      }
    }
  }
  updatePixels();
}

void draw(){
}

void mouseClicked(){
  saveFrame();
}
