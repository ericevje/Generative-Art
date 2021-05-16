class Boundary{
  PVector a;
  PVector b;
  
  Boundary(float x1, float y1, float x2, float y2){
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
  }
  
  void show(){
    stroke(28, 36, 18, 255);
    float line_length = abs(PVector.dist(a, b));
    float max_length = ((width+height)/2)/25;
    println(line_length/max_length*5);
    strokeWeight(5 - (line_length/max_length)*4);
    line(a.x, a.y, b.x, b.y);
  }
}

    
