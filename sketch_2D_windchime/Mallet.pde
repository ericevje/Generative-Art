class Mallet{
  
  PVector init_pos;
  
  Mallet(){
    init_pos = new PVector (width/2, height/2);
  }
  
  void show(){
    noStroke();
    fill(255);
    push();
    translate(init_pos.x, init_pos.y);
    ellipse(0, 0, 20, 20);
    pop();
  }
  
  
  
}
