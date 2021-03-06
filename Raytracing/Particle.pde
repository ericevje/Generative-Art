class Particle{
  PVector pos;
  ArrayList<Ray> rays;
  int num_rays = 18; //Must evenly divide 360
  int step_size = 360 / num_rays;
  
  Particle(float x, float y){
    pos = new PVector(x, y);
    rays = new ArrayList<Ray>();
    int i = 0;
    for (int r = 0; r < 360; r += step_size){
      color col = color(255, 255, 255, 255);
      rays.add(new Ray(pos, radians(r), col, -1));
      i++;
    }
  }
  
  
  void show(ArrayList<Boundary> walls){
    ArrayList<Ray> temp_rays;
    temp_rays = new ArrayList<Ray>();
    
    for (int i = 0; i < rays.size(); i++){
      float shortest = 1000000;
      PVector nearest = null;
      Boundary near_bound = null;
      int wall_index = -1;
      PVector pt_closest = new PVector(0, 0);
      boolean found = false;
      for (int j= 0; j < walls.size(); j++){
        PVector pt = rays.get(i).cast(walls.get(j));
        if (pt != null && j != rays.get(i).wall_index){
          float d = abs(pt.dist(rays.get(i).pos));
          if (d < shortest){
            nearest = pt;
            shortest = d;
            near_bound = walls.get(j);
            wall_index = j;
            pt_closest = pt;
            found = true;
          }
        }
      }
      if (found){
        stroke(0, 1);
        point(pt_closest.x, pt_closest.y);
        stroke(39, 41, 37, 2);
        line(pt_closest.x, pt_closest.y, rays.get(i).pos.x, rays.get(i).pos.y);
      }
      
      
      if (nearest != null){
        stroke(rays.get(i).col);
        float theta_inc = refract(near_bound, rays.get(i));
        float alpha = alpha(rays.get(i).col) * 0.9;
        float red = red(int(rays.get(i).col)) * 0.9; 
        
        if (alpha > 2){
          Ray inc_ray = new Ray(nearest, theta_inc, color(red, 0, 255, alpha), wall_index);
          //temp_rays = (Ray[]) append(temp_rays, inc_ray);
          temp_rays.add(inc_ray);
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
