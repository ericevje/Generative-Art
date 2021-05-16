import processing.pdf.*;


PVector ln;
PVector ln_old;
float ln_length = 1;
int offset = 0;
float angle = 0;

Paintbrush brush;



void setup(){
  //frameRate(1);
  size(800, 800);
  background(0);
  ln = PVector.fromAngle(-3*PI/4);
  ln.setMag(ln_length);
  ln_old = new PVector(ln.x, ln.y);
  color col_1 = color(150,200,165, 50);
  color col_2 = color(200,135, 50, 50);
  brush = new Paintbrush(400, col_1, col_2, 2, new PVector(0, 0));
  beginRecord(PDF, "everything.pdf");
}

void draw(){
  for (int i = 0; i < 80; i++){
      brush.update_brush();
  }
  translate(0, height);
  brush.show();
}

void mousePressed(){
  saveFrame();
  endRecord();
  exit();
}
