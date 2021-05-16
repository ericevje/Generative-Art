import peasy.*;

//import processing.pdf.*;



BubbleGrid3D grid;
PeasyCam cam;
float zoff = 0;
float za = 0;
float r = 5;
float r_2 = 5;

void setup(){
  size(3000, 3000, P3D);
  cam = new PeasyCam(this, 3000);
  
  grid = new BubbleGrid3D();
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
        col = color(30);
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
  //background(0, 0, 0);
  println(frameRate);
  //background(0);

  noFill();
  stroke(255, 50);
  //translate(width/2, height/2);
  //push();
  //rotateY(map(noise(zoff), 0, 1, -PI, PI));
  ellipse(0, 0, r, r);
  //pop();
  //resetMatrix();
  //rotateX(map(noise(zoff), 0, 1, -PI, PI));
  ellipse(0, 0, r_2, r_2);
  //grid.show(zoff);
  za += .1;
  r += random(-1, 2);
  r_2 += random(-1, 3);
  zoff+=0.005;
}


//void mousePressed(){
//  saveFrame();
//  //endRecord();
//  exit();  
//}

void keyPressed(){
  saveFrame();
}
