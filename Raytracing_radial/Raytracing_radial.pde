Boundary wall;
Ray ray;
ArrayList<Particle> particles;;
ArrayList<Boundary> walls;
int num_walls = 50000;
float xoff = 0;
float yoff = 0;
float zoff = 0;
int counter = 0;
PImage img;
PImage img_og;
PImage mask_img;
Contours contour_worker;
float rotation = 0;
PShape master_line;

void setup(){
  size(800, 800);
  background(0);
  particles = new ArrayList<Particle>();
  particles.add(new Particle(random(width), random(height)));
  walls = new ArrayList<Boundary>();
  walls.add(rotate_line(width/2, rotation));
  rotation += 0.1;
  Boundary top = new Boundary(0, 0, width, 0);
  Boundary bottom = new Boundary(0, height, width, height);
  Boundary left = new Boundary(0, 0, 0, height);
  Boundary right = new Boundary(width, 0, width, height);
  
  //walls.add(top);
  //walls.add(bottom);
  //walls.add(left);
  //walls.add(right);
}

void draw(){
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).show(walls);
    }
    //  for (int i = 0; i < walls.size(); i++) {
    //  walls.get(i).show();
    //}
    
    if(random(100) < 50){
      //print(particles.size() + "\t");
      Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height));
      //Particle p = new Particle(random(width), random(height));
      for(int i = particles.size(); i <= 0; i--){
        if (particles.get(i).rays.size() == 0){
          particles.remove(i);
        }
      }
      //println(particles.size());
      particles.add(p);
    }
    xoff += 0.05;
    
    counter ++;
    if (counter%50 == 0){
      walls.set(0, rotate_line(width*2, rotation));
      rotation += 0.1;
    }
  
}

Boundary rotate_line(float radius, float angle){;
  PVector start;
  PVector end;
  
  PVector master = new PVector(width/2 + random(-(width/20), width/20), height/2 + random(-(width/20), width/20));
  start = PVector.fromAngle(angle + random(-PI/100, PI/100));
  start.setMag(radius+random(-(radius/20), radius/20));
  start.add(master);
  
  end = PVector.fromAngle(angle + PI + random(-PI/100, PI/100));
  end = PVector.fromAngle(angle + PI);
  end.setMag(radius+random(-(radius/20), radius/20));
  end.setMag(radius);  
  end.add(master);
  
  Boundary b = new Boundary(start.x, start.y, end.x, end.y);
  return b;
}

void mousePressed(){
  noLoop();
  saveFrame("image.tiff");
  background(255);
  push();
  translate(width/2, height/2);
  rectMode(CENTER);
  noStroke();
  fill(0);
  rect(0, 0, width-width/5, width-width/5);
  saveFrame("mask.tiff");
  pop();
  background(0);
  PImage fin = loadImage("image.tiff");
  PImage mask = loadImage("mask.tiff");
  mask.filter(INVERT);
  fin.mask(mask);
  image(fin, 0, 0);
  saveFrame();
}
