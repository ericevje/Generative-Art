Boundary wall;
Ray ray;
Particle[] particles;
Boundary[] walls;
int num_walls = 400;
//float[] points = {0,0};
float xoff = 0;
float yoff = 0;
float zoff = 0;
int counter = 0;



void setup(){
  background(255);
  //frameRate(1);
  fullScreen();
  //size(4000, 3000);
  //size(400, 300);
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
    println(frameRate);
    for (int i = 0; i < particles.length; i++) {
      particles[i].show(walls);
    }
    //  for (int i = 0; i < walls.length; i++) {
    //  walls[i].show();
    //}
    
    if(random(100) < 25){
      Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height));
      particles = (Particle[]) append(particles, p);
    }
    xoff += 0.05;
    
    counter ++;
    if (counter%3 == 0){
      for (int i = 0; i < 4; i++){
        walls = (Boundary[]) shorten(walls);
      }
      
      for (int i = 0; i < walls.length; i++){
        float x1 = map(noise(zoff), 0, 1, -width/23, width/21) + walls[i].a.x;
        float y1 = map(noise(zoff+100), 0, 1, -height/23, height/21) + walls[i].a.y;
        float x2 = map(noise(zoff+200), 0, 1, -width/23, width/21) + walls[i].b.x;
        float y2 = map(noise(zoff+300), 0, 1, -height/23, height/21) + walls[i].b.y;
        walls[i] = new Boundary(x1, y1, x2, y2);
        zoff += 0.005;
        
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
  
}

void mousePressed() {
  saveFrame();
}
