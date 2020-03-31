Boundary wall;
Ray ray;
Particle[] particles;
ArrayList<Boundary> walls;
int num_walls = 50000;
//float[] points = {0,0};
float xoff = 0;
float yoff = 0;
float zoff = 0;
int counter = 0;
PImage img;
PImage img_og;
PImage mask_img;
Contours contour_worker;


void settings(){
  //img = loadImage("IMG_3300.JPG");
  //img.resize(img.width/5, img.height/5);
  //img = loadImage("https://media3.s-nbcnews.com/j/newscms/2019_41/3047866/191010-japan-stalker-mc-1121_06b4c20bbf96a51dc8663f334404a899.fit-760w.JPG");
  //img = loadImage("https://s.ftcdn.net/v2013/pics/all/curated/RKyaEDwp8J7JKeZWQPuOVWvkUjGQfpCx_cover_580.jpg?r=1a0fc22192d0c808b8bb2b9bcfbf4a45b1793687");
  //img = loadImage("https://i.pinimg.com/originals/c6/b7/3f/c6b73f7256d50419f05c7a3d281b60ef.jpg");
  img = loadImage("https://uploads5.wikiart.org/images/paul-gauguin/where-do-we-come-from-what-are-we-where-are-we-going-1897.jpg!Large.jpg");
  //img = loadImage("https://media.npr.org/assets/img/2014/05/08/simp2006_homerarmscrossed_f_custom-ec94cc7a10463aa8260b2c5a9a3ebea29c7ecbfe-s800-c85.jpg");
  //img = loadImage("https://i.pinimg.com/originals/d1/2b/da/d12bda1cecb3e9b45ac3efa377cf0140.jpg");
  //img_og = img.copy();
  size(img.width, img.height);
}

void setup(){
  img_og = img.copy();
}

void draw(){
  background(255);
  contour_worker = new Contours(img);
  contour_worker.edge_detect();
  contour_worker.draw_shapes();
  color background_col = contour_worker.background_color();
  //for(int i = 0; i < contour_worker.edges.size(); i++){
  //  stroke(0);
  //  point(contour_worker.edges.get(i).x, contour_worker.edges.get(i).y);
  //}
  loadPixels();
  for (int p = 0; p < pixels.length; p++){
    if (red(pixels[p]) == 255){
      pixels[p] = background_col;
    }
  }
  updatePixels();
  saveFrame("rounds.tiff");
  background(255);
  noStroke();
  fill(0);
  rectMode(CENTER);
  rect(width/2, height/2, width-(width/20), height-(width/20));
  saveFrame("mask.tiff");
  background(255);
  for(int i = 0; i < contour_worker.edges.size(); i++){
    stroke(0);
    point(contour_worker.edges.get(i).x, contour_worker.edges.get(i).y);
  }
  PImage rounds = loadImage("rounds.tiff");
  PImage mask = loadImage("mask.tiff");
  mask.filter(INVERT);
  rounds.mask(mask);
  image(rounds, 0, 0);
  saveFrame();
  noLoop();
}

void mousePressed() {
  println("mouse pressed");
  saveFrame("sketch.jpg");
  background(255);
  img = loadImage("sketch.jpg");
  loop();
}

void masking(){
  background(255);
  push();
  translate(mouseX, mouseY);
  float x = (width/2) - (mouseX - width/2);
  float y = (height/2) - (mouseY - height/2);
  stroke(0);
  fill(0);
  rectMode(CENTER);
  float bar_width = random(width/2, width);
  float bar_height = random(0, height/10);
  rect(0, 0, bar_width, bar_height);
  pop();
  push();
  translate(x, y);
  stroke(0);
  fill(0);
  rectMode(CENTER);
  rect(0, 0, bar_width, bar_height);
  pop();
  saveFrame("mask.jpg");
  mask_img = loadImage("mask.jpg");
  //mask_img.filter(INVERT);
  img_og.mask(mask_img);
}

void overlay(){
  background(255);
  PImage sketch = loadImage("sketch.jpg");
  image(sketch, 0, 0);
  image(img_og, 0, 0);
  
}
