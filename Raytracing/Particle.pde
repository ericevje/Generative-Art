class Particle{
  PVector pos;
  Ray[] rays;
  
  Particle(){
    pos = new PVector(width/2, height/2);
    rays = new Ray[36];
    int i = 0;
    for (int r = 0; r < 360; r += 10){
      rays[i] = new Ray(pos, radians(r));
      i++;
    }
  }
  
  void show(Boundary[] walls){
    fill(255);
    //ellipse(pos.x, pos.y, 10, 10);
    for (int i = 0; i < rays.length; i++){
      for (int j = 0; j < walls.length; j++){
        //println(i, rays[i].pos, rays[i].dir);
        rays[i].show(walls[j]);
      }
    }
  }
    
  
}
