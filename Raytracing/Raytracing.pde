Boundary wall;
Ray ray;
Particle p;



void setup(){
  //frameRate(1);
  size(400, 400);
  wall = new Boundary(300, 300, 300, 100);
  PVector pvec = new PVector(100, 200);
  ray = new Ray(pvec, 1.5);
  p = new Particle();
}

void draw(){
  background(0);
  wall.show();
  //ray.show();
  p.show(wall);
}

void point(){
 PVector pt = ray.cast(wall);
 if (pt != null) {
   fill(255);
   ellipse(pt.x, pt.y, 10, 10);
 }
 println(pt);
}
