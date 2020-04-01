class smoother{
  
  smoother(){
  }
  
  void draw(){
    stroke(0);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);
    circ = createShape();
    circ.beginShape();
    float radius = 200;
    PVector master = new PVector(width/2, height/2);
    for(float theta = 0; theta < 2*PI; theta += 0.42){
      
      PVector p = PVector.fromAngle(theta);
      //float fluc = map(noise(zoff), 0, 1, -(radius/3), radius/3);
      //println(zoff, fluc);
      //if(theta < PI){
      //zoff += 0.1;
      //} else {
      //  zoff -= 0.1;
      //}
      //p.setMag(radius+fluc);
      p.setMag(radius+random(-(radius/10), radius/10));
      p.add(master);
      circ.vertex(p.x, p.y);
    }
    PShape rounded = createShape();
    rounded = chaikin_close(circ, 0.25, 4);
    shape(rounded);
    noLoop();
  }
  
  ArrayList<PVector> chaikin_cut(PVector a, PVector b, float ratio) {
    float x, y;
    ArrayList<PVector> n = new ArrayList<PVector>();
  
    /*
     * If ratio is greater than 0.5 flip it so we avoid cutting across
     * the midpoint of the line.
     */
     if (ratio > 0.5) ratio = 1 - ratio;
  
    /* Find point at a given ratio going from A to B */
    x = lerp(a.x, b.x, ratio);
    y = lerp(a.y, b.y, ratio);
    n.add(new PVector(x, y));
  
    /* Find point at a given ratio going from B to A */
    x = lerp(b.x, a.x, ratio);
    y = lerp(b.y, a.y, ratio);
    n.add(new PVector(x, y));
  
    return n;
  }
  
  PShape chaikin(PShape shape, float ratio, int iterations, boolean close) {
    //println("We in");
    // If the number of iterations is zero, return shape as is
    if (iterations == 0)
      return shape;
  
    PShape next = createShape();
    next.beginShape();
    next.stroke(0, 255, 0);
    next.fill(0, 255, 0, 100);
    /*
     * Step 1: Figure out how many corners the shape has
     *         depending on whether it's open or closed.
     */
    int num_corners = shape.getVertexCount();
    //println("number of corners: " + num_corners);
    if (!close)
      num_corners = shape.getVertexCount() - 1;
  
    /*
     * Step 2: Since we don't have access to edges directly
     *         with a PShape object, do a pairwise iteration
     *         over vertices instead. Same thing.
     */
    for (int i = 0; i < num_corners; i++) {
  
      // Get the i'th and (i+1)'th vertex to work on that edge.
      PVector a = shape.getVertex(i);
      PVector b = shape.getVertex((i + 1) % shape.getVertexCount());
  
      // Step 3: Break it using our chaikin_break() function
      ArrayList<PVector> n = chaikin_cut(a, b, ratio);
  
      /*
       * Now we have to deal with one corner case. In the case
       * of open shapes, the first and last endpoints shouldn't
       * be moved. However, in the case of closed shapes, we
       * cut all edges on both ends.
       */
      if (!close && i == 0) {
        // For the first point of open shapes, ignore vertex A
        next.vertex(a.x, a.y);
        next.vertex(n.get(1).x, n.get(1).y);
      } else if (!close && i == num_corners - 1) {
        // For the last point of open shapes, ignore vertex B
        next.vertex(n.get(0).x, n.get(0).y);
        next.vertex(b.x, b.y);
      } else {
        // For all other cases (i.e. interior edges of open
        // shapes or edges of closed shapes), add both vertices
        // returned by our chaikin_break() method
        next.vertex(n.get(0).x, n.get(0).y);
        next.vertex(n.get(1).x, n.get(1).y);
      }
    }
  
    if (close){
      //next.stroke(0);
      //next.fill(0, 100);
      next.endShape(CLOSE);
      //shape(next);
    }
    else
      next.endShape();
  
    return chaikin(next, ratio, iterations - 1, close);
  }
  
  PShape chaikin_close(PShape original, float ratio, int iterations) {
    return chaikin(original, ratio, iterations, true);
  }
  
  PShape chaikin_open(PShape original, float ratio, int iterations) {
    return chaikin(original, ratio, iterations, false);
  }
}
