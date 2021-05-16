import processing.pdf.*;

int scl = 5;
float mult = 5.0/scl;
int rows;
int cols;
PVector[][] grid;
float inc = 0.01;
float xoff;
float yoff;
float zoff;
float rotation;

color white = #f8f1f1;
color light_blue = #a3d2ca;
color dark_blue = #5eaaa8;
color orange = #db6400;

boolean save_images = false;


void setup(){
  //frameRate(20);
  size(500,500);
  //size(800,800, PDF, "test.pdf");
  rows = floor(height/scl);
  cols = floor(width/scl);
  grid = new PVector[cols][rows];
  for (int y = 0; y < rows; y++){
    for (int x = 0; x < cols; x++){
      grid[x][y] = new PVector(x*scl, y*scl);
      point(grid[x][y].x, grid[x][y].y);
    }
  }
  //loadPixels();
  //color col;
  //for (int y = 0; y < height; y++){
  //  for (int x = 0; x < width; x++){
  //    if (y > random(0, 3 * height)){
  //      col = dark_blue;
  //    } else{
  //      col = white;
  //    }
  //    //color pix_col = lerpColor(col1, col2, map(y + random(-width, width), 0, height, 0, 1));
  //    pixels[x + y * width] = col;
  //  }
  //}
  //updatePixels();
  //background(white);
}

void draw(){
  //background(white);
  ////println(frameRate);
  //PVector[][] cur_grid = new PVector[cols][rows];
  //zoff += inc;
  //yoff = 0;
  //for (int y = 0; y < rows; y++){
  //  xoff = 0;
  //  for (int x = 0; x < cols; x++){
  //    float mag = map(noise(xoff, yoff, zoff), 0, 1, -width/(mult*scl), width/(mult*scl));
  //    float dir = map(noise(yoff, xoff, zoff+.05), 0, 1, 0, 6*PI);
  //    PVector p = PVector.fromAngle(dir);
  //    p.setMag(mag);
  //    cur_grid[x][y] = new PVector(grid[x][y].x + p.x, grid[x][y].y + p.y);
  //    point(cur_grid[x][y].x, cur_grid[x][y].y);
  //    xoff += inc;
  //  }
  //  yoff += inc;
  //}
  
  //  for (int y = 1; y < rows-1; y++){
  //  noFill();
  //  beginShape();
  //  curveVertex(cur_grid[0][y].x, cur_grid[0][y].y);
  //  //stroke(255, 255, 255);
  //  color cur_color = lerpColor(light_blue, orange, random(0, 1));
  //  for (int x = 1; x < cols-1; x++){
  //    curveVertex(cur_grid[x][y].x, cur_grid[x][y].y);
  //  }
  //  curveVertex(cur_grid[cols - 1][y].x, cur_grid[cols - 1][y].y);
  //  endShape();
  //}
  
  //for (int x = 1; x < cols-1; x++){
  //  beginShape();
  //  curveVertex(cur_grid[x][0].x, cur_grid[x][0].y);
  //  //stroke(255, 255, 255);
  //  color cur_color = lerpColor(light_blue, orange, random(0, 1));
  //  for (int y = 1; y < rows-1; y++){
  //    curveVertex(cur_grid[x][y].x, cur_grid[x][y].y);
  //  }
  //  curveVertex(cur_grid[x][rows-1].x, cur_grid[x][rows-1].y);
  //  endShape();
  //}
  if (save_images == true){
    println("saving frame");
    saveFrame();
  }
}

void mousePressed(){
  save_images = true;
}
