class Particle{
  PVector pos;
  Ray[] rays;
  Ray[] temp_rays;
  int num_rays = 180; //Must evenly divide 360
  int step_size = 360 / num_rays;
  
  Particle(float x, float y){
    pos = new PVector(x, y);
    rays = new Ray[num_rays];
    int i = 0;
    for (int r = 0; r < 360; r += step_size){
      color col = color(255, 255, 255, 255);
      rays[i] = new Ray(pos, radians(r), col, -1);
      i++;
    }
  }
  
  
  void show(Boundary[] walls){
    temp_rays = new Ray[1];
    temp_rays[0] = new Ray(new PVector(0, 0), 0, 0, -1);
    for (int i = 0; i < rays.length; i++){
      float shortest = 1000000;
      PVector nearest = null;
      Boundary near_bound = null;
      int wall_index = -1;
      PVector pt_closest = new PVector(0, 0);
      for (int j= 0; j < walls.length; j++){
        PVector pt = rays[i].cast(walls[j]);
        //println(j, rays[i].wall_index);
        if (pt != null && j != rays[i].wall_index){
          float d = abs(pt.dist(rays[i].pos));
          if (d < shortest){
            nearest = pt;
            shortest = d;
            near_bound = walls[j];
            wall_index = j;
            pt_closest = pt;
          }
        }
      }
      stroke(255);
      points = append(points, pt_closest.x);
      points = append(points, pt_closest.y);
      
      if (nearest != null){
        stroke(rays[i].col);
        line(rays[i].pos.x, rays[i].pos.y, nearest.x, nearest.y);
        float theta_inc = refract(near_bound, rays[i]);
        float alpha = alpha(rays[i].col) * 0.9;
        float red = red(int(rays[i].col)) * 0.9;
        //println(red, "0", 255, alpha);
        
        if (alpha > 2){
          Ray inc_ray = new Ray(nearest, theta_inc, color(red, 0, 255, alpha), wall_index);
          temp_rays = (Ray[]) append(temp_rays, inc_ray);
        }
      }
    }
    rays = temp_rays;
  }
  
  void update(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  
  float refract(Boundary wall, Ray ray){
    float theta_ray = ray.dir.heading();
    float theta_inc = theta_ray;
    if (random(100) < 50){
      float y = wall.b.y - wall.a.y;
      float x = wall.b.x - wall.a.x;
      float theta_wall = atan(y / x);
      theta_inc = -(theta_ray - 2*theta_wall);
      return theta_inc;
    }
    else{
      return theta_inc;
    }
  }
}
