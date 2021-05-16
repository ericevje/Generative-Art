
float zoff = 0;
float za = 0;
float r = 5;
float r_2 = 5;

BubbleGrid grid;

void setup(){
  size(800, 800);
  //cam = new PeasyCam(this, 200);
  
  grid = new BubbleGrid();
  //println(cell.x, cell.y);
  //background(255);
  //beginRecord(PDF, "circle_grid.pdf");
  
  loadPixels();
  color col;
  for (int y = 0; y < height; y++){
    for (int x = 0; x < width; x++){
      if (y > random(0, height)){
        col = color(0);
      } else{
        col = color(15);
      }
      //color pix_col = lerpColor(col1, col2, map(y + random(-width, width), 0, height, 0, 1));
      pixels[x + y * width] = col;
    }
  }
  updatePixels();
  //translate(width/2, height/2);
  //noStroke();
  //lights();
  //sphere(200);
}


void draw(){
  grid.show(zoff);
  zoff += 0.01;
}


void mousePressed(){
  saveFrame();
  //endRecord();
  exit();  
}
