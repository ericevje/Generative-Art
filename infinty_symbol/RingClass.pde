class Ring{
   PVector rot_center; //3D vector for rotation point of ring
   PVector rot_vector; //Diameter of rotation circle
   float diameter;
   boolean rotating;
   float desired_angle;
   float angle;
   float max_rotation_vel = 0.15574533;
   float max_rotation_acc = max_rotation_vel/(framerate*3);
   float rotation_vel = 0;
   float rotation_acc = 50;
   
   
   // PID control system variables
   float e_prior = 0;
   float integral_prior = 0;
   float output_prior = 0;
   float integration_time = 1;
   float Kp = 0.06;
   float Ki = 0.005;
   float Kd = 0;
   float bias = 0;
   
   

  Ring(PVector _rot_center, PVector _rot_vector, float _diameter, float _angle){
    rot_center = _rot_center;
    rot_vector = _rot_vector;
    diameter = _diameter;
    rotating = false;
    angle = _angle;
  }
  
  void advance_position(){
    rotation_vel = pid_control(desired_angle);
    
    if (rotation_vel < max_rotation_vel){
      rotation_vel += max_rotation_vel/rotation_acc;
    }
    
    rot_vector  = rot_vector.rotate(rotation_vel);
    angle += rotation_vel;
      
  }
  
  float pid_control(float desired_angle){
    float e = desired_angle - angle;
    float integral = integral_prior + e * integration_time;
    float derivative = (e - e_prior) / integration_time;
    float output = Kp * e + Ki * integral + Kd * derivative + bias;
    e_prior = e;
    integral_prior = integral;
    
    float acc = output - output_prior;
    if (acc > max_rotation_acc){
      output = output + max_rotation_acc;
    }
    else if (acc < -1 * max_rotation_acc){
      output = output - max_rotation_acc;
    }

    if (output > max_rotation_vel) {
      return max_rotation_vel;
    }
    else if (output < -max_rotation_vel) {
      return -max_rotation_vel;
    }
    else {
      return output;
    }
  }
  
  void show(){
    stroke(255);
    //fill(255);
    noFill();
    push();
    translate(rot_center.x, rot_center.y);
    rotateY(PI/2);
    translate(rot_vector.x, rot_vector.y);
    //sphere(diameter);
    circle(0, 0, diameter);
    point(0, 0);
    pop();
    } 
}
  
  
