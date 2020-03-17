class Ray{
   PVector pos;
   PVector dir;
   color col;

  Ray(PVector pos_1, float rad, color col_incoming){
    pos = pos_1;
    dir = PVector.fromAngle(rad);
    col = col_incoming;
  }
  
  void show(Boundary wall){
    stroke(col);
    push();
    translate(pos.x, pos.y);
    line(0, 0, dir.x * 300, dir.y * 300);
    pop();
    
    PVector pt  = cast(wall);
    if (pt != null) {
      fill(255);
      ellipse(pt.x, pt.y, 10, 10);
    } 
  }
  
  PVector cast(Boundary wall){
    //println(pos, dir, wall.a, wall.b);
    float x1 = wall.a.x;
    float y1 = wall.a.y;
    float x2 = wall.b.x;
    float y2 = wall.b.y;
    
    float x3 = pos.x;
    float y3 = pos.y;
    float x4 = pos.x + dir.x;
    float y4 = pos.y + dir.y;
    
    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0){
      return null;
    }
    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = -1 * (((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den);
    //println(den, t, u);
    
    
    if (t > 0 && t < 1 && u > 0){
      PVector pt = new PVector();
      pt.x = x1 + t * (x2 - x1);
      pt.y = y1 + t * (y2 - y1);
      return pt;
    }
    else{
      //println("not in range");
      return null;
    }
  }
  
  //void setDir(float x, float y){
  //  dir.x = x - pos.x;
  //  dir.y = y - pos.y;
  //  dir.normalize();
  //}
  
  
    
}
