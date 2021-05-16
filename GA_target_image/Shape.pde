class Shape{
  ArrayList<PVector> points;
  color col;

  Shape() {
    int pt_count = 3;
    points = new ArrayList<PVector>();
    for (int i = 0; i < pt_count; i++){
      points.add(new PVector(random(0, width/2), random(0, height/2)));
    }
    col = color(random(255), random(255), random(255), random(255));
  }
  
  void show(){
    beginShape();
    noStroke();
    fill(col);
    for (PVector vector: points){
      vertex(vector.x, vector.y);
    }
    endShape();
  }
}
