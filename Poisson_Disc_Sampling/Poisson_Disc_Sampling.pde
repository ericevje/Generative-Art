int r = 10;
int k = 30;
ArrayList <PVector> grid;
ArrayList <PVector> active;
float w = r/sqrt(2);




void setup(){
  size(400, 400);
  background(0);
  strokeWeight(4);
  
  //Step 0
  active = new ArrayList<PVector>();
  grid = new ArrayList<PVector>();
  int cols = floor(width / w);
  int rows = floor(height / w);
  for (int i = 0; i < cols*rows; i++){
    grid.add(new PVector(-1, -1));
  }
  
  //Step 1
  PVector p = new PVector(random(width), random(height));
  int i = floor(p.x/w);
  int j = floor(p.y/w);
  grid.set(i + j*cols, p);
  active.add(p);
  
}

void draw(){
  
  if(active.size() > 0){
    int rand_i = floor(random(active.size() - 1));
    PVector q = active.get(rand_i);
    for (int n = 0; n < k; n++){
      PVector sample = PVector.random2D();
      float m = random(r, 2 * r);
      sample.setMag(m);
      sample.add(q);
      
      boolean ok = true;
      int col = floor(sample.x / w);
      int row = floor(sample.y / w);
      for (int i = -1; i <=1; i++){
        for (int j = -1; j <= 1; j++){
          PVector neighbor = grid.get(i + j * col);
          if (neighbor.x != -1);{
            float d = PVector.dist(sample, neighbor);
            if (d < r){
              ok = false;
            }
          }
        }
      }
      if(ok){
        grid.set(col + row*col, sample);
        active.add(sample);
        break;
      }
    }
  }
  for (int i = 0; i < grid.size(); i++){
    if (grid.get(i).x != -1){
      stroke(255);
      strokeWeight(4);
      point(grid.get(i).x, grid.get(i).y);
    }
  }
}
