class Boundary{
  PVector a;
  PVector b;
  
  Boundary(float x1, float y1, float x2, float y2, float z){
    a = new PVector(x1, y1, z);
    b = new PVector(x2, y2, z);
  }
  
  void show(){
    stroke(255);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
}

    
