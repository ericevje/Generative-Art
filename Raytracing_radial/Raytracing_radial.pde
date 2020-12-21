Boundary wall;
Ray ray;
ArrayList<Particle> particles;;
ArrayList<Boundary> walls;
int num_walls = 50000;
float xoff = 0.005;
float yoff = 0.005;
float zoff = 0;
int counter = 0;
int num_frames = 30;
PImage img;
PImage img_og;
PImage mask_img;
//Contours contour_worker;
float rotation = 0;
PShape master_line;
float z_rot = 0;
float z_plane = 0;

void setup(){
  size(1000, 1000, P3D);
  particles = new ArrayList<Particle>();
  particles.add(new Particle(random(width), random(height), z_plane));
  walls = new ArrayList<Boundary>();
  walls.add(rotate_line(width/2, rotation, z_plane));
  rotation += 0.1;
  
  loadPixels();
  for (int y = 0; y < height; y++){
    for (int x = 0; x < width; x++){
      int pix_value = (x + y*width);
      float grey_scale = (int(map(noise(x*xoff, y*yoff), 0, 1, 100, 120)));
      
      pixels[pix_value] = color(grey_scale, 255);
    }
  }
  updatePixels();
}

void draw(){

    rotateX(-.6);
    rotateY(.6);
    translate(0, 0, -900);
    perspective();
    
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).show(walls);
    }
    //  for (int i = 0; i < walls.size(); i++) {
    //  walls.get(i).show();
    //}
    
    if(random(100) < 50){
      Particle p = new Particle(map(noise(xoff), 0, 1, 0, width), map(noise(xoff+100), 0, 1, 0, height), z_plane);
        if (particles.size() > 10){
          particles.remove(0);
        }
      particles.add(p);
    }
    xoff += 0.05;
    counter ++;
    
    if (counter % 100 == 0){
      walls.set(0, rotate_line(width, rotation, z_plane));
      z_plane += 50;
      rotation += 0.1;
      println(z_plane, rotation);
    }  
}

Boundary rotate_line(float radius, float angle, float z_plane){;
  PVector start;
  PVector end;
  PVector master = new PVector(width/2, height/2, z_plane);
  start = PVector.fromAngle(angle + random(-PI/100, PI/100));
  start.setMag(radius+random(-(radius/50), radius/50));
  start.add(master);
  end = PVector.fromAngle(angle + PI);
  end.setMag(radius+random(-(radius/20), radius/20));
  end.setMag(radius);  
  end.add(master);
  
  Boundary b = new Boundary(start.x, start.y, end.x, end.y, z_plane);
  //println(b.a.x, b.a.y, b.a.z, b.b.x, b.b.y, b.b.z);
  return b;
}

void mousePressed(){
  saveFrame();
}
