class Paintbrush{
  
  ArrayList <Stroke> brush;
  color col_1;
  color col_2;
  PVector centerpoint;
  
  Paintbrush(int num_strokes, color inc_col_1, color inc_col_2, int spacing, PVector start_pt){
    brush = new ArrayList<Stroke>();
    for (int i = 0; i < num_strokes; i++){
      brush.add(new Stroke());
      brush.get(i).ln.add(new PVector(start_pt.x + spacing*i, start_pt.y));
    }
    col_1 = inc_col_1;
    col_2 = inc_col_2;
  }
  
  void update_brush(){
    for (int i = 0; i < brush.size(); i++){
      PVector prev_pos = brush.get(i).ln.get(brush.get(i).ln.size() - 1);
      brush.get(i).ln.add(new PVector(prev_pos.x - random(-1, 1), prev_pos.y - random(-1, 2)));
    }
  }
  
  void show(){
    //int count = 0;
    for(int i = 0; i < brush.size(); i++){
      //println("count: " + count);
      beginShape();
      float inter = map(i, 0, brush.size(), 0, 1);
      color c = lerpColor(col_1, col_2, inter);
      stroke(c);
      noFill();
      for(PVector point: brush.get(i).ln){
        //println(point.x, point.y);
        vertex(point.x, point.y);
      }
      endShape();
      //count++;
    }
  }
  
  void update_direction(PVector vector){
    float a = PVector.angleBetween(centerpoint, vector);
    
  }
  
  void update_centerpoint(){
  }
  
}
