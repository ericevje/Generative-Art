float xoff = 0;
float yoff = 0;
float zoff = 0;

void setup() {
  size(200, 200);
  pixelDensity(1);
}

void draw(){
  yoff = 0;
  zoff += 0.01;
  loadPixels();
  for(int y = 0; y < height; y++){
    xoff = 0;
    for(int x = 0; x < width; x++){
      int index = (x + y * width);
      float r_value = noise(xoff, yoff, zoff) * 255;
      int r = int(r_value);
      color pixel_color = color(r, r, r, 255);
      pixels[index] = pixel_color;
      xoff += 0.01;
    }
    yoff += 0.01;
  }
  updatePixels();
}
