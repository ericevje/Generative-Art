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
PImage img_temp;
PImage mask_img;
Contours contour_worker;


void settings(){
  //img = loadImage("IMG_3300.JPG");
  //img = loadImage("IMG_3939.JPG");
  img = loadImage("IMG_4822.JPG");
  img.resize(img.width/2, img.height/2);
  size(img.width, img.height);
}

void setup(){
  background(255);
  particles = new Particle[1];
  //particles[0] = new Particle(width/2, height/2);
  walls = new ArrayList<Boundary>();
  img_og = img.copy();
  
  contour_worker = new Contours(img, walls, num_walls);
  contour_worker.edge_detect();
  contour_worker.draw_lines();
  println("Pre cleanup: " + contour_worker.boundaries.size());
  contour_worker.clean_up();
  println("Post cleanup: " + contour_worker.boundaries.size());
  walls = contour_worker.boundaries;
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).show();
  }
  //saveFrame("sketch.jpg");
}

void draw(){
    //println(frameRate);
    //for (int i = 0; i < particles.length; i++) {
    //  particles[i].show(walls);
    //}

    
    //if(random(100) < 25){
    //  Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height));
    //  //Particle p = new Particle(random(width), random(height));
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

//void draw(){
//  background(255);
//  noLoop();
//}

void mousePressed() {
  saveFrame("sketch.jpg");
  //setup();
  //loop();
  background(255, 250, 250);
  masking();
  overlay();
  saveFrame();
  //noLoop();
}

void masking(){
  //draw();
  background(255);
  push();
  float rand_x = random(width/5);
  float rand_y = random(height);
  translate(rand_x, rand_y);
  float x = (width/2) - (rand_x - width/2);
  float y = (height/2) - (rand_y - height/2);
  stroke(0);
  fill(0);
  rectMode(CENTER);
  float bar_width = random(width/5, width/1.5);
  float bar_height = random(height/40, height/20);
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
  img_temp = img_og.copy();
  img_temp.mask(mask_img);
}

void overlay(){
  background(255);
  PImage sketch = loadImage("sketch.jpg");
  image(sketch, 0, 0);
  image(img_temp, 0, 0);
  
}
