class Ring{
   PVector rot_center; // 3D vector for rotation point of ring
   PVector rot_vector; // Diameter of rotation circle
   float diameter; // Diameter of circle at each point
   boolean rotating; // Whether or not the rign has been reset after a shape change
   float desired_angle; // Setpoint angle. 0 for circle, PI for infinty symbol
   float angle; // Current angle
   float max_rotation_vel = 0.15574533; // Arbitrary value for maximum rotational velocity
   float max_rotation_acc = max_rotation_vel/(framerate*3); // Arbitrary value for maximum rotational acceleration
   float rotation_vel = 0; // Current rotational velocity
   
   
   // PID control system variables
   // See here for more info: https://www.robotsforroboticists.com/pid-control/
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
    rotation_vel = pid_control(desired_angle); // Calculate rotation velocity
    rot_vector  = rot_vector.rotate(rotation_vel); // Update angle of rotation by velocity * time (in this case normalized to 1 frame of time)
    angle += rotation_vel; // Update the angle rotated through for the control system
  }
  
  float pid_control(float desired_angle){
    // See here for more info: https://www.robotsforroboticists.com/pid-control/
    float e = desired_angle - angle;
    float integral = integral_prior + e * integration_time;
    float derivative = (e - e_prior) / integration_time;
    float output = Kp * e + Ki * integral + Kd * derivative + bias;
    e_prior = e;
    integral_prior = integral;
    
    // Limit acceleration below a certain threshold
    float acc = output - output_prior;
    if (acc > max_rotation_acc){
      output = output + max_rotation_acc;
    }
    else if (acc < -1 * max_rotation_acc){
      output = output - max_rotation_acc;
    }

    // Limit velocity below a threshold
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
  
  
