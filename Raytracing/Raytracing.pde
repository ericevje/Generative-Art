Boundary wall;
Ray ray;
Particle[] particles;
Boundary[] walls;
int num_walls = 100;
float[] points = {0,0};
float xoff = 0;
float yoff = 0;
float zoff = 0;
float sum = 0;



void setup(){
  //frameRate(1);
  fullScreen();
  //size(800, 800);
  particles = new Particle[1];
  particles[0] = new Particle(width/2, height/2);
  walls = new Boundary[num_walls];
  
  for (int i = 0; i < walls.length; i++){
    walls[i] = new Boundary(random(width), random(height), random(width), random(height)); 
  }
  
  Boundary top = new Boundary(0, 0, width, 0);
  Boundary bottom = new Boundary(0, height-1, width, height-1);
  Boundary left = new Boundary(0, 0, 0, height);
  Boundary right = new Boundary(width, 0, width, height);
  
  walls = (Boundary[]) append(walls, top);
  walls = (Boundary[]) append(walls, bottom);
  walls = (Boundary[]) append(walls, left);
  walls = (Boundary[]) append(walls, right);
}

void draw(){
    println(points.length);
    background(255);
    
    for (int i = 0; i < particles.length; i++) {
      particles[i].show(walls);
    }
    //  for (int i = 0; i < walls.length; i++) {
    //  walls[i].show();
    //}
    for (int i = 0; i < points.length - 1; i += 2){
      stroke(0, 75);
      point(points[i], points[i+1]);
    }
    
    Particle p = new Particle(map(noise(xoff, yoff, zoff), 0, 1, 0, width), map(noise(xoff+100, yoff+100, zoff+100), 0, 1, 0, height));
    xoff += 0.01; yoff += 0.01;
    particles = (Particle[]) append(particles, p);
    
    for (int i = 0; i < 4; i++){
      walls = (Boundary[]) shorten(walls);
    }
    
    for (int i = 0; i < walls.length; i++){
      float x1 = map(noise(zoff), 0, 1, -width/23, width/21) + walls[i].a.x;
      float y1 = map(noise(zoff+100), 0, 1, -height/23, height/21) + walls[i].a.y;
      float x2 = map(noise(zoff+200), 0, 1, -width/23, width/21) + walls[i].b.x;
      float y2 = map(noise(zoff+300), 0, 1, -height/23, height/21) + walls[i].b.y;
      walls[i] = new Boundary(x1, y1, x2, y2);
      zoff += 0.1;
      
    }
    
    Boundary top = new Boundary(0, 0, width, 0);
    Boundary bottom = new Boundary(0, height, width, height);
    Boundary left = new Boundary(0, 0, 0, height);
    Boundary right = new Boundary(width, 0, width, height);
    
    walls = (Boundary[]) append(walls, top);
    walls = (Boundary[]) append(walls, bottom);
    walls = (Boundary[]) append(walls, left);
    walls = (Boundary[]) append(walls, right);
  
}

void mousePressed() {
  saveFrame();
}
