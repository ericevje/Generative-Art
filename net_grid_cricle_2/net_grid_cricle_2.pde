import peasy.*;

import processing.pdf.*;


int scl = 15;
float mult = 100.0/scl;
int rows;
int cols;
PVector[][] grid;
PVector[][] circle_vertical;
PVector[][] circle_horizontal;
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

PeasyCam cam;


void setup(){
  cam = new PeasyCam(this, 3000);
  lights();
  //frameRate(20);
  size(1000,1000, P3D);
  //size(800,800, PDF, "test.pdf");
  rows = floor(height/scl);
  cols = floor(width/scl);
  grid = new PVector[cols+2][rows+2];
  circle_vertical = new PVector[cols][2];
  circle_horizontal = new PVector[rows][2];
  
  for (int y = 0; y <= rows + 1; y++){
    for (int x = 0; x <= cols + 1; x++){
      grid[x][y] = new PVector(x*scl, y*scl);
      point(grid[x][y].x, grid[x][y].y);
      //print(grid[x][y]);
    }
  }
  
  for (int r_2 = 0; r_2 < cols; r_2++){
    int r = int(width/2);
    int R_2 = r_2 * scl;
    int x = r - R_2;
    int y = int(sqrt(2*r*R_2 - pow(R_2, 2)));
    
    circle_vertical[r_2][0] = new PVector(x + width/2, y + width/2);
    int opposite_y = -y + height/2;
    circle_vertical[r_2][1] = new PVector(x + width/2, opposite_y);
  }
  
  for (int r_2 = 0; r_2 < rows; r_2++){
    int r = height/2;
    int R_2 = r_2 * scl;
    int y = r - R_2;
    int x = int(sqrt(2*r*R_2 - pow(R_2, 2)));
    
    circle_horizontal[r_2][0] = new PVector(x + width/2, y + height/2);
    int opposite_x = -x + width/2;
    circle_horizontal[r_2][1] = new PVector(opposite_x, y + height/2);
  }
}

void draw(){
  background(white);
  mult = mult * 0.99;
  println(mult);
  translate(-width/2, -height/2);
  PVector[][] cur_grid = new PVector[cols+2][rows+2];
  PVector[][] cur_circle_vertical = new PVector[circle_vertical.length][2];
  PVector[][] cur_circle_horizontal = new PVector[circle_horizontal.length][2];
  zoff += inc;
  yoff = 0;
  for (int y = 0; y <= cols + 1; y++){
    xoff = 0;
    for (int x = 0; x <= rows + 1; x++){
      float mag = map(noise(xoff, yoff, zoff), 0, 1, -width/(mult*scl), width/(mult*scl));
      float dir = map(noise(yoff, xoff, zoff+.05), 0, 1, 0, 6*PI);
      PVector p = PVector.fromAngle(dir);
      p.setMag(mag);
      //PVector p = new PVector(0, 0);
      cur_grid[x][y] = new PVector(grid[x][y].x + p.x, grid[x][y].y + p.y);
      //point(cur_grid[x][y].x, cur_grid[x][y].y);
      xoff += inc;
    }
    yoff += inc;
  }

  for (int point = 0; point < circle_vertical.length; point++){
    for (int i = 0; i < circle_vertical[point].length; i++){
      xoff = inc * circle_vertical[point][i].x * cols / width;
      yoff = inc * circle_vertical[point][i].y * rows / height;
      float mag = map(noise(xoff, yoff, zoff), 0, 1, -width/(mult*scl), width/(mult*scl));
      float dir = map(noise(yoff, xoff, zoff+.05), 0, 1, 0, 6*PI);
      PVector p = PVector.fromAngle(dir);
      p.setMag(mag);
      //PVector p = new PVector(0, 0);
      cur_circle_vertical[point][i] = new PVector(circle_vertical[point][i].x + p.x, circle_vertical[point][i].y + p.y);
    }
  }
  
  for (int point = 0; point < circle_horizontal.length; point++){
    for (int i = 0; i < circle_horizontal[point].length; i++){
      xoff = inc * circle_horizontal[point][i].x * cols / width;
      yoff = inc * circle_horizontal[point][i].y * rows / height;
      float mag = map(noise(xoff, yoff, zoff), 0, 1, -width/(mult*scl), width/(mult*scl));
      float dir = map(noise(yoff, xoff, zoff+.05), 0, 1, 0, 6*PI);
      PVector p = PVector.fromAngle(dir);
      p.setMag(mag);
      //PVector p = new PVector(0, 0);
      cur_circle_horizontal[point][i] = new PVector(circle_horizontal[point][i].x + p.x, circle_horizontal[point][i].y + p.y);
    }
  }
  
  
  //for (int x = 0; x < circle_vertical.length; x++){
  //for (int y = int(7*circle_horizontal.length/16); y < 9*circle_horizontal.length/16; y++){
  //  ellipseMode(CENTER);
  //  ellipse(circle_horizontal[y][0].x, circle_horizontal[y][0].y, 10, 10);
  //  ellipse(circle_horizontal[y][1].x, circle_horizontal[y][1].y, 10, 10);
  //}
  //for (int y = 0; y < circle_vertical.length; y++){
  //  ellipseMode(CENTER);
  //  fill(0);
  //  ellipse(circle_vertical[y][0].x, circle_vertical[y][0].y, 10, 10);
  //  ellipse(circle_vertical[y][1].x, circle_vertical[y][1].y, 10, 10);
  //}
  
  //draw horiztonal lines
  for (int y = 1; y < rows; y++){
    noFill();
    beginShape();
    boolean first_step = true;
    int x = 0;
    for (x = 0; x < cols; x++){
      if ((circle_horizontal[y][0].x >= grid[x][y].x) && (circle_horizontal[y][1].x <= grid[x][y].x)){
        if (first_step == true){
          curveVertex(cur_circle_horizontal[cols - y][1].x-1, cur_circle_horizontal[cols - y][1].y);
          curveVertex(cur_circle_horizontal[cols - y][1].x, cur_circle_horizontal[cols - y][1].y);
        }
        first_step = false;
        curveVertex(cur_grid[x][y].x, cur_grid[x][y].y);
      }
   }
   curveVertex(cur_circle_horizontal[cols - y][0].x, cur_circle_horizontal[cols - y][0].y);
   curveVertex(cur_circle_horizontal[cols - y][0].x+1, cur_circle_horizontal[cols - y][0].y);
   endShape();
  }
  
  // Draw vertical lines
  for (int x = 1; x < cols; x++){
    noFill();
    beginShape();
    boolean first_step = true;
    int y = 0;
    for (y = 0; y < rows; y++){
      if ((circle_vertical[x][0].y >= grid[x][y].y) && (circle_vertical[x][1].y < grid[x][y].y)){
        if (first_step == true){
          //curveVertex(cur_grid[x][y-1].x, cur_grid[x][y-1].y);
          curveVertex(cur_circle_vertical[cols - x][1].x, cur_circle_vertical[cols - x][1].y-1);
          curveVertex(cur_circle_vertical[cols - x][1].x, cur_circle_vertical[cols - x][1].y);
        }
        first_step = false;
        curveVertex(cur_grid[x][y].x, cur_grid[x][y].y);
      }
   }
   curveVertex(cur_circle_vertical[cols - x][0].x, cur_circle_vertical[cols - x][0].y);
   curveVertex(cur_circle_vertical[cols - x][0].x, cur_circle_vertical[cols - x][0].y+1);
   endShape();
  }
  
  // Draw outline
  beginShape();
  curveVertex(cur_circle_vertical[1][1].x, cur_circle_vertical[1][1].y);
  for (int i = 0; i < cur_circle_vertical.length; i++){
      curveVertex(cur_circle_vertical[i][0].x, cur_circle_vertical[i][0].y);
  }
  for (int y = int(7*circle_horizontal.length/16); y < 9*circle_horizontal.length/16; y++){
    //curveVertex(circle_horizontal[y][0].x, circle_horizontal[y][0].y, 10);
    curveVertex(cur_circle_horizontal[y][1].x, cur_circle_horizontal[y][1].y, 10);
  }
  for (int i = cur_circle_vertical.length - 1; i >= 0; i--){
    curveVertex(cur_circle_vertical[i][1].x, cur_circle_vertical[i][1].y);
  }
  curveVertex(cur_circle_vertical[1][0].x, cur_circle_vertical[1][0].y);
  endShape();
  
  saveFrame("movie/frame-#####.png");
}

void mousePressed(){
  saveFrame();
}
