int cols, rows;
int scl = 20;
int w = 1200;
int h = 1000;

float[][] terrain;

float flying = 0;
float rotateX = PI/3;
float rotateZ = 0;
float xoff_rot = 0;


float max_height = 200;
float min_height = -200;

void setup(){
  size(600,600,P3D);

  cols = w/ scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
  //frameRate(30);
  
}

void draw(){
  
  flying -= 0.1;
  
  float yoff = flying;
  float yoff_rot = 0;
  //rotateX = map(noise(xoff_rot, yoff_rot), 0, 1, PI/2, PI/6);
  //rotateZ = map(noise(xoff_rot, yoff_rot), 0, 1, 0, PI/2);
  rotateZ += 0.005;
  xoff_rot += 0.005;
  println(xoff_rot);
  //println(rotate);
  for (int y = 0; y < rows; y++){
    float xoff = 0;
    for (int x = 0; x <cols; x++){
      //rotate = map(noise(xoff, yoff), 0, 1, 0, PI);
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, min_height, max_height);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  background(120);
  //frameRate(1);
  
  translate(width/2, height/2, 50);
  rotateX(PI/3);
  rotateZ(rotateZ);
  
  translate(-w/2, -h/2);
  
  
  for (int y = 0; y < rows - 1; y++){
    
    for (int x = 0; x <cols - 1; x++){
      int red;
      int green;
      int blue;
      if (terrain[x][y] > 0){
        red = 255;
        //red = int((terrain[x][y]/max_height)*255);
        green = int(255 - (terrain[x][y]/max_height)*255);
        blue = green;
        //println(red, green, blue);
      }
      else{
        blue = 255;
        //blue = int((terrain[x][y]/min_height)*255);
        red = int(255 - (terrain[x][y]/min_height)*255);
        green = red;
        //println(red, green, blue);
      }
      
      fill(120);
      stroke(red, green, blue);
      
      beginShape(TRIANGLE);
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      vertex((x+1)*scl, y*scl, terrain[x+1][y]);
      endShape();
      
      beginShape(TRIANGLE);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      vertex((x+1)*scl, (y+1)*scl, terrain[x+1][y+1]);
      vertex((x+1)*scl, y*scl, terrain[x+1][y]);
      endShape();
    }
    endShape();
  }
}
