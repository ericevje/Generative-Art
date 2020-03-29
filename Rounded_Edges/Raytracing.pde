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
  img = loadImage("IMG_3300.JPG");
  img.resize(img.width/4, img.height/4);
  //img = loadImage("https://media3.s-nbcnews.com/j/newscms/2019_41/3047866/191010-japan-stalker-mc-1121_06b4c20bbf96a51dc8663f334404a899.fit-760w.JPG");
  //img = loadImage("https://s.ftcdn.net/v2013/pics/all/curated/RKyaEDwp8J7JKeZWQPuOVWvkUjGQfpCx_cover_580.jpg?r=1a0fc22192d0c808b8bb2b9bcfbf4a45b1793687");
  //img = loadImage("https://i.pinimg.com/originals/c6/b7/3f/c6b73f7256d50419f05c7a3d281b60ef.jpg");
  //img = loadImage("https://uploads5.wikiart.org/images/paul-gauguin/where-do-we-come-from-what-are-we-where-are-we-going-1897.jpg!Large.jpg");
  //img = loadImage("https://media.npr.org/assets/img/2014/05/08/simp2006_homerarmscrossed_f_custom-ec94cc7a10463aa8260b2c5a9a3ebea29c7ecbfe-s800-c85.jpg");
  //img = loadImage("https://i.pinimg.com/originals/d1/2b/da/d12bda1cecb3e9b45ac3efa377cf0140.jpg");
  //img_og = img.copy();
  size(img.width, img.height);
}

void setup(){
  //frameRate(1);
  //fullScreen();
  //size(4000, 3000);
  //size(400, 300);
  //background(img);
  background(255);
  particles = new Particle[1];
  particles[0] = new Particle(width/2, height/2);
  walls = new ArrayList<Boundary>();
  img_og = img.copy();
  //img.filter(GRAY);
  //img.filter(INVERT);
  //img.filter(POSTERIZE, 10);
  //img.filter(THRESHOLD, 0.5);
  //image(img, 0, 0);
  
  contour_worker = new Contours(img, walls, num_walls);
  contour_worker.edge_detect();
  contour_worker.draw_lines();
  println("Pre cleanup: " + contour_worker.boundaries.size());
  contour_worker.clean_up();
  println("Post cleanup: " + contour_worker.boundaries.size());
  walls = contour_worker.boundaries;
}

void draw(){
    //println(frameRate);
    //for (int i = 0; i < particles.length; i++) {
    //  particles[i].show(walls);
    //}
    //  for (int i = 0; i < walls.size(); i++) {
    //  walls.get(i).show();
    //}
    
    //if(random(100) < 25){
    //  //Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height));
    //  Particle p = new Particle(random(width), random(height));
    //  particles = (Particle[]) append(particles, p);
    //}
    xoff += 0.05;
    
    counter ++;
    if (counter%10 == 0){
      for (int i = 0; i < 4; i++){
        walls.remove(walls.size() - 1);
      }
      
      for (int i = 0; i < walls.size(); i++){
        int divisor = 200;
        float x1 = random(-width/divisor, width/divisor) + walls.get(i).a.x;
        float y1 = random(-width/divisor, width/divisor) + walls.get(i).a.y;
        float x2 = random(-width/divisor, width/divisor) + walls.get(i).b.x;
        float y2 = random(-width/divisor, width/divisor) + walls.get(i).b.y;
        
        //float x1 = map(noise(zoff), 0, 1, -width/divisor, width/divisor) + walls.get(i).a.x;
        //float y1 = map(noise(zoff+10), 0, 1, -height/divisor, height/divisor) + walls.get(i).a.y;
        //float x2 = map(noise(zoff+20), 0, 1, -width/divisor, width/divisor) + walls.get(i).b.x;
        //float y2 = map(noise(zoff+30), 0, 1, -height/divisor, height/divisor) + walls.get(i).b.y;
        //walls.set(i, walls.get(i));
        walls.set(i, new Boundary(x1, y1, x2, y2));
        //println(noise(zoff));
        zoff += 0.005;
      }
      
      Boundary top = new Boundary(0, 0, width, 0);
      Boundary bottom = new Boundary(0, height, width, height);
      Boundary left = new Boundary(0, 0, 0, height);
      Boundary right = new Boundary(width, 0, width, height);
      
      walls.add(top);
      walls.add(bottom);
      walls.add(left);
      walls.add(right);
    }
  
}

void mousePressed() {
  noLoop();
  saveFrame("sketch.jpg");
  masking();
  overlay();
  saveFrame();
  
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
  mask_img.filter(INVERT);
  img_og.mask(mask_img);
}

void overlay(){
  background(255);
  PImage sketch = loadImage("sketch.jpg");
  image(sketch, 0, 0);
  image(img_og, 0, 0);
  
}
