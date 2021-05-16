class BubbleGrid{
  
  float zoff = 0;
  int rows = 1;
  int cols = 1;
  PVector cell;
  PVector[][] offsets;
  
  BubbleGrid(){
    cell = new PVector(width/cols, height/rows);
    offsets = new PVector[cols][rows];
    for (int y = 0; y < rows; y++){
      for (int x = 0; x < cols; x++){
        offsets[x][y] = new PVector(random(-cell.x/15, cell.x/15), random(-cell.x/15, cell.x/15));
      }
    }
    
  }
  
  void show(float zoff){
    for (int y = 0; y < rows; y++){
      for (int x = 0; x < cols; x++){
        beginShape();
        noFill();
        stroke(255, 5);
        for (float a = 0; a < TWO_PI; a+= 0.01){
          resetMatrix();
          translate((cell.x * x) + (cell.x/2) + offsets[x][y].x, (cell.y * y) + (cell.y/2) + offsets[x][y].y);
          //println((cell.x * x) + (cell.x/2), (cell.y * y) + (cell.y/2));
          float xoff = cos(a) + (cell.x*x) + (cell.x/2);
          float yoff = sin(a) + (cell.y*y) + (cell.y/2);
          float r = map(noise(xoff, yoff, zoff), 0, 1, cell.x/20, cell.x/2);
          float xpos = r * cos(a);
          float ypos = r * sin(a);
          //println(xpos, ypos);
          //point(xpos, ypos);
          vertex(xpos, ypos);
        }
        endShape();
      }
    }  
  }
}
