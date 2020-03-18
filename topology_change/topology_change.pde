Boundary wall;
Ray ray;
Particle[] particles;
Boundary[] walls;
int num_walls = 100;
float[] points = {0,0};
float x1off = 0;
float x2off = 100;
float y1off = 200;
float y2off = 300;




void setup(){
  //frameRate(1);
  fullScreen();
  //size(500, 500);
  particles = new Particle[1];
  particles[0] = new Particle(width/2, height/2);
  walls = new Boundary[num_walls]; 
}

void draw(){
  background(255);
  
  for (int i = 0; i < walls.length; i++){
    float x1 = map(noise(x1off), 0, 1, 0, width);
    float y1 = map(noise(y1off), 0, 1, 0, height);
    float x2 = map(noise(x2off), 0, 1, 0, width);
    float y2 = map(noise(y2off), 0, 1, 0, height);
    //walls[i] = new Boundary(random(width), random(height), random(width), random(height));
    walls[i] = new Boundary(x1, y1, x2, y2);
    x1off += 0.01; x2off += 0.01; y1off += 0.01; y2off += 0.01; 
    
  }
  
  Boundary top = new Boundary(0, 0, width, 0);
  Boundary bottom = new Boundary(0, height, width, height);
  Boundary left = new Boundary(0, 0, 0, height);
  Boundary right = new Boundary(width, 0, width, height);
  
  walls = (Boundary[]) append(walls, top);
  walls = (Boundary[]) append(walls, bottom);
  walls = (Boundary[]) append(walls, left);
  walls = (Boundary[]) append(walls, right);
  
  for (int i = 0; i < particles.length; i++) {
    particles[i].show(walls);
  }
    for (int i = 0; i < walls.length; i++) {
    walls[i].show();
  }
  for (int i = 0; i < points.length - 1; i += 2){
    stroke(0, 20);
    point(points[i], points[i+1]);
  }
}

void mousePressed() {
  Particle p = new Particle(mouseX, mouseY);
    particles = (Particle[]) append(particles, p);
}
