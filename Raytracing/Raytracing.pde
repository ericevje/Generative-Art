Boundary wall;
Ray ray;
Particle[] particles;
Boundary[] walls;
int num_walls = 10;
//Ray flat;
int time = millis();




void setup(){
  frameRate(10);
  size(500, 500);
  particles = new Particle[1];
  particles[0] = new Particle(width/2, height/2);
  walls = new Boundary[num_walls];
  for (int i = 0; i < walls.length; i++){
    walls[i] = new Boundary(random(width), random(height), random(width), random(height));
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

void draw(){
  background(100);
  for (int i = 0; i < walls.length; i++) {
    walls[i].show();
  }
  for (int i = 0; i < particles.length; i++) {
    particles[i].show(walls);
  }
}

void mousePressed() {
  Particle p = new Particle(mouseX, mouseY);
    particles = (Particle[]) append(particles, p);
    //println(particles.length);
}
