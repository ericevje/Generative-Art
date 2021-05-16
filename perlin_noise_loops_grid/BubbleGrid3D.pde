class BubbleGrid3D{
  
  //float zoff = 0;
  int rows = 1;
  int cols = 1;
  int depth = 1;
  PVector cell;
  PVector[][] offsets;
  
  BubbleGrid3D(){
    cell = new PVector(width/cols, height/rows, width/depth);
    offsets = new PVector[cols][rows];
    for (int y = 0; y < rows; y++){
      for (int x = 0; x < cols; x++){
        for (int z = 0; z < depth; z++){
          offsets[x][y] = new PVector(random(-cell.x/15, cell.x/15), random(-cell.x/15, cell.x/15));
        }
      }
    }
    
  }
  
  void show_sphere(){
    resetMatrix();
    translate(width/2, height/2);
    fill(255);
    noStroke();
    sphere(200);
  }
  
  void show(float zoff){
    beginShape();
    noFill();
    stroke(255, 5);
    for (float a = -PI/2; a < PI/2; a+= .01){
      float xoff = cos(a) + 1;
      float yoff = sin(a) + 1;
      float r = map(noise(xoff, yoff, zoff), 0, 1, width/20, width/2);
  
      float xpos = r * cos(a);
      float ypos = r * sin(a);
      vertex(xpos, ypos);
      point(xpos, ypos);
    }
    endShape();
  }
}
