Mallet mallet;
int cols;
int rows;
float scl = 4;
PVector[] flowfield;




void setup(){
  size(400, 400);
  background (0);
  mallet = new Mallet();
  cols = floor(width / scl);
  rows = floor(height / scl);
  flowfield = new PVector[rows*cols];
}


void draw(){
  
  mallet.show();
  
}
