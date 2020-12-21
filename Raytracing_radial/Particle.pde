class Particle{
  PVector pos;
  ArrayList<Ray> rays;
ArrayList<Ray> temp_rays;
  int num_rays = 18; //Must evenly divide 360
  int step_size = 360 / num_rays;
  
  Particle(float x, float y, float z){
    pos = new PVector(x, y, z);
    rays = new ArrayList<Ray>();
    for (int r = 0; r < 360; r += step_size){
      color col = color(255, 255);
      rays.add(new Ray(pos, radians(r), col, -1));
    }
  }
  
  
  void show(ArrayList<Boundary> walls){
    temp_rays = new ArrayList<Ray>();
    for (int i = 0; i < rays.size(); i++){
      //println(rays.get(i).pos.x, rays.get(i).pos.y, rays.get(i).pos.z + "\t");
      float shortest = width + height;
      PVector nearest = null;
      Boundary near_bound = null;
      int wall_index = -1;
      PVector pt_closest = new PVector(0, 0);
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
          }
        }
      }
      if (nearest != null){
          //stroke(rays.get(i).col);
          float theta_inc = refract(near_bound, rays.get(i));
          float alpha = alpha(rays.get(i).col) * 0.9;
          float red = red(int(rays.get(i).col)) * 0.9;
          stroke(255, 255);
          point(pt_closest.x, pt_closest.y, z_plane);
          stroke(255, 5);
          line(pt_closest.x, pt_closest.y, z_plane, rays.get(i).pos.x, rays.get(i).pos.y, z_plane);
          
          
          //if (alpha > 2){
          //  stroke(255, 255);
          //  point(pt_closest.x, pt_closest.y, z_plane);
          //  stroke(255, 5);
          //  line(pt_closest.x, pt_closest.y, z_plane, rays.get(i).pos.x, rays.get(i).pos.y, z_plane);
          //  Ray inc_ray = new Ray(nearest, theta_inc, color(red, 0, 255, alpha), wall_index);
          //  temp_rays.add(inc_ray);
          //}
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
    if (random(100) < 75){
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
