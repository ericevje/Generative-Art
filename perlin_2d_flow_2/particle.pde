class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector prev_pos;
  int maxspeed = 80;
  color stroke_color = color(0, 0, 0, 5);
  
  Particle(){
    pos = new PVector(random(width), random(height));
    prev_pos = new PVector(pos.x, pos.y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void update(color stroke_col, int max_spe){
    vel.add(this.acc);
    vel.limit(maxspeed);
    pos.add(this.vel);
    acc.mult(0);
    stroke_color = stroke_col;
    maxspeed = max_spe;
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
      
  void draw_line(){
    stroke(stroke_color);
    strokeWeight(1);
    strokeCap(SQUARE);
    line(pos.x, pos.y, prev_pos.x, prev_pos.y);
  }
  
  void show(){
    draw_line();
    reset_prev();
  }
  
  void reset_prev(){
    prev_pos.x = pos.x;
    prev_pos.y = pos.y;
  }
  
  void edges(){
    if (pos.x > width){
      pos.x = 0;
      reset_prev();
    }
    if (pos.x < 0){
      pos.x = width;
      reset_prev();
    }
    if (pos.y > height){
      pos.y = 0;
      reset_prev();
    }
    if (pos.y < 0){
      pos.y = height;
      reset_prev();
    }
  }
  
  void follow(PVector[] flowfield){
    float x = pos.x;
    float y = pos.y;
    
    int particle_column = int(floor(x / scl));
    if (particle_column == cols){
      particle_column = cols - 1;
    }
    int particle_row = int(floor(y / scl));
    if (particle_row == rows){
      particle_row = rows - 1;
    }
    //println(particle_column, particle_row);
    int index = particle_column + particle_row * cols;
    //println(index);
    
    PVector force = flowfield[index];
    //print(force);
    applyForce(force);
  }
}
