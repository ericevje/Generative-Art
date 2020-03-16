Boundary wall;
Ray ray;
Particle p;
Boundary[] walls;
int num_walls = 10;



void setup(){
  //frameRate(1);
  size(400, 400);
  walls = new Boundary[num_walls];
  for (int i = 0; i < walls.length; i++){
    walls[i] = new Boundary(random(width), random(height), random(width), random(height));
    println(walls[i].a, walls[i].b);
  }
  wall = new Boundary(300, 300, 300, 100);
  PVector pvec = new PVector(100, 200);
  ray = new Ray(pvec, 1.5);
  p = new Particle();
}

void draw(){
  background(0);
  for (int i = 0; i < walls.length; i++) {
    walls[i].show();
  }
  wall.show();
  //ray.show();
  p.show(walls);
}
