Boundary wall;
Ray ray;
Particle[] particles;
ArrayList<Boundary> walls;
int num_walls = 5000;
//float[] points = {0,0};
float xoff = 0;
float yoff = 0;
float zoff = 0;
int counter = 0;
PImage img;
PImage img_og;
Contours contour_worker;


void settings(){
  img = loadImage("https://uploads5.wikiart.org/images/paul-gauguin/where-do-we-come-from-what-are-we-where-are-we-going-1897.jpg!Large.jpg");
  //img = loadImage("https://media.npr.org/assets/img/2014/05/08/simp2006_homerarmscrossed_f_custom-ec94cc7a10463aa8260b2c5a9a3ebea29c7ecbfe-s800-c85.jpg");
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
  img.filter(INVERT);
  img.filter(POSTERIZE, 3);
  
  contour_worker = new Contours(img, walls, num_walls);
  contour_worker.edge_detect();
  contour_worker.draw_lines();
  contour_worker.clean_up();
  walls = contour_worker.boundaries;
}

void draw(){
    //println(frameRate);
    for (int i = 0; i < particles.length; i++) {
      particles[i].show(walls);
    }
    //  for (int i = 0; i < walls.size(); i++) {
    //  walls.get(i).show();
    //}
    
    if(random(100) < 25){
      Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height));
      particles = (Particle[]) append(particles, p);
    }
    xoff += 0.05;
    
    counter ++;
    if (counter%10 == 0){
      for (int i = 0; i < 4; i++){
        walls.remove(walls.size() - 1);
      }
      
      for (int i = 0; i < walls.size(); i++){
        int divisor = 65;
        float x1 = map(noise(zoff), 0, 1, -width/divisor, width/divisor) + walls.get(i).a.x;
        float y1 = map(noise(zoff+10), 0, 1, -height/divisor, height/divisor) + walls.get(i).a.y;
        float x2 = map(noise(zoff+20), 0, 1, -width/divisor, width/divisor) + walls.get(i).b.x;
        float y2 = map(noise(zoff+30), 0, 1, -height/divisor, height/divisor) + walls.get(i).b.y;
        walls.set(i, new Boundary(x1, y1, x2, y2));
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
  saveFrame();
}
