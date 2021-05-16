class Shape{
  ArrayList<PVector> points;
  color col;

  Shape() {
    int pt_count = round(random(3));
    points = new ArrayList<PVector>();
    for (int i = 0; i < pt_count; i++){
      points.add(new PVector(random(-width/10, width + width/10), random(-height/10, 1.1*height)));
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
