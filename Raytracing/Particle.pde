class Particle{
  PVector pos;
  Ray[] rays;
  Ray[] temp_rays;
  int num_rays = 10; //Must evenly divide 360
  int step_size = 360 / num_rays;
  
  Particle(){
    pos = new PVector(width/2, height/2);
    rays = new Ray[num_rays];
    int i = 0;
    for (int r = 0; r < 360; r += step_size){
      color col = color(255, 255, 255, 255);
      rays[i] = new Ray(pos, radians(r), col);
      //println(i, r, rays[i].dir);
      i++;
    }
  }
  
  
  void show(Boundary[] walls){
    //fill(255);
    //temp_rays = new Ray[2];
    //PVector temp_pt = new PVector(random(width), random(height));
    //temp_rays[1] = new Ray(temp_pt, random(2*PI), color(255, 0, 0, 255));
    //temp_rays[1].show(walls[1]);
    //rays = (Ray[]) append(rays, temp_rays[1]);
    //println(rays.length);
    for (int i = 0; i < rays.length; i++){
      float shortest = 1000000;
      PVector nearest = null;
      Boundary near_bound = null; 
      for (int j = 0; j < walls.length; j++){
        PVector pt = rays[i].cast(walls[j]);
        if (pt != null){
          float d = abs(pt.dist(rays[i].pos));
          if (d < shortest){
            nearest = pt;
            shortest = d;
            near_bound = walls[j];
          }
        }
      }
      if (nearest != null){
        stroke(255);
        line(rays[i].pos.x, rays[i].pos.y, nearest.x, nearest.y);
        float theta_inc = refract(near_bound, rays[i]);
        Ray inc_ray = new Ray(nearest, theta_inc, color(250, 0, 0, 50));
        rays = (Ray[]) append(rays, inc_ray);
      }
    }
  }
  
  void update(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  
  float refract(Boundary wall, Ray ray){
    float theta_ray = ray.dir.heading();
    //println(theta_ray);
    float y = wall.b.y - wall.a.y;
    float x = wall.b.x - wall.a.x;
    float theta_wall = atan(y / x);
    float theta_inc = theta_ray - 2*theta_wall;
    //println(theta_ray, y, x, theta_wall, theta_inc);
    return theta_inc;
  }
}
