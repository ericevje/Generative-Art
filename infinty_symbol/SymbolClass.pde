class Symbol{
  ArrayList<Ring> rings = new ArrayList<Ring>();
  ArrayList<PVector> psuedo_lemn = new ArrayList<PVector>();
  ArrayList<PVector> psuedo_circ = new ArrayList<PVector>();
  ArrayList<PVector> rotation_curve = new ArrayList<PVector>();
  ArrayList<PVector> rotation_diameter = new ArrayList<PVector>();
  float a, b, x_0, y_0;
  float step_size;
  int n_rings;
  float global_error = 0;
  
  Symbol(int _n_rings, float _a, float _b, float _x_0, float _y_0){
    a = _a;
    b = _b;
    x_0 = _x_0;
    y_0 = _y_0;
    n_rings = _n_rings;
    step_size = 2*PI/n_rings;
  }
  
  void calc_curve_coords(){
    float r = 100;
    step_size = r/n_rings;
    int i = 0;
    for (float x = -r; x <= r; x = x + step_size){
      float r_prime = r/sqrt(2);
      float lemn_y = sqrt(-pow(r_prime,2) + sqrt(pow(r_prime,4) + 4*pow(r_prime,2)*pow(x,2)) - pow(x,2));
      float circ_y = sqrt(pow(r,2) - pow(x,2));
      float rot_y = (circ_y - lemn_y)/2;
      float rot_d = circ_y + lemn_y;
      psuedo_lemn.add(new PVector(x, lemn_y));
      psuedo_circ.add(new PVector(x, circ_y));
      rotation_curve.add(new PVector(x, rot_y));
      rotation_diameter.add(new PVector(x, rot_d));
      rings.add(new Ring(new PVector(x, rot_y), new PVector(0, rot_d/2), 20, 0));
      rings.add(new Ring(new PVector(x, -rot_y), new PVector(0, -rot_d/2), 20, 0));
      i++;
    }
  }
  
  void debug_show_point(PVector point, color col, float scl){
    stroke(255);
    push();
    translate(scl*point.x, scl*point.y);
    circle(0, 0, 1);
    pop();
    
    push();
    translate(scl*point.x, -scl*point.y);
    circle(0, 0, 1);
    pop();
  }
  
  void debug_show_rotation_circle(PVector rot_point, PVector rot_dia, color col, float scl){
    stroke(col);
    strokeWeight(2);
    //fill(12, 12, 12, 5);
    noFill();
    push();
    translate(scl * rot_point.x, scl * rot_point.y);
    rotateY(PI/2);
    circle(0, 0, rot_dia.y);
    pop();
    
    stroke(0, 100, 255);
    //fill(12, 12, 12, 5);
    noFill();
    push();
    translate(scl * rot_point.x, -scl * rot_point.y);
    rotateY(PI/2);
    circle(0, 0, rot_dia.y);
    pop();
  }
  
  void show(){
    for (int i = 0; i < rings.size(); i++){
      rings.get(i).show();
    }
  }
  
  void advance_rings(float desired_position){
    for (int i = 0; i < rings.size(); i++){
      if (rings.get(i).rotating == false){
        rings.get(i).desired_angle = desired_position;
        rings.get(i).rotating = true;
        break;
      }
    }
    for (int i = 0; i < rings.size(); i++){
      rings.get(i).advance_position();
    }
  }
  
  float calc_error(){
    float sum_error = 0;
    int rings_size = rings.size();
    for (int i = 0; i < rings_size; i++){
      sum_error += abs(rings.get(i).e_prior);
    }
    global_error = sum_error / rings_size;
    return global_error;
  }
  
  void reset_rings(){
    for (int i = 0; i < rings.size(); i++){
      rings.get(i).rotating = false;
    }
  }
  
  void debug_show_guide_curves(){
    for (int i = 0; i < psuedo_lemn.size(); i++){
      debug_show_point(psuedo_lemn.get(i), color(255), 1);
      debug_show_point(psuedo_circ.get(i), color(255), 1);
      debug_show_point(rotation_curve.get(i), color(255), 1);
      debug_show_rotation_circle(rotation_curve.get(i), rotation_diameter.get(i), color(0, 50, 200), 1);
    }
  }
}
