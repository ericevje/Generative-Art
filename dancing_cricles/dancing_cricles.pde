import peasy.*;

int rows;
int cols;

PVector[][] grid;
float inc = 0.01;
float xoff;
float yoff;
float zoff;

PeasyCam cam;

void setup(){
  size(800, 800);
  background(0);
  rows = floor(height/scl);
  cols = floor(width/scl);
  grid = new PVector[cols+2][rows+2];
  
  rows = floor(height/scl);
  cols = floor(width/scl);
  grid = new PVector[cols+2][rows+2];
  
  for (int y = 0; y <= rows + 1; y++){
    for (int x = 0; x <= cols + 1; x++){
      grid[x][y] = new PVector(x*scl, y*scl);
      point(grid[x][y].x, grid[x][y].y);
      //print(grid[x][y]);
    }
  }
}

void draw(){
  
}
