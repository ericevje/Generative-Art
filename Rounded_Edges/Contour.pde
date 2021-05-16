import java.util.Collections;

class Contours {
  PImage img;
  ArrayList<PVector> edges = new ArrayList<PVector>();
  ArrayList<Integer> colors = new ArrayList<Integer>();
  
  Contours(PImage image){
    img = image;
  }
  
  void edge_detect(){
    img.loadPixels();  
    for (int y = 1; y < height-1; y++) {
      for (int x = 1; x < width-1; x++) {
        int loc = x + y*width;
        int bot_loc = x + (y+1)*width;
        int top_loc = x + (y-1)*width;
        if(loc<img.pixels.length-1){
         float[] pix = new float[8]; 
     
         float center = red(img.pixels[loc]) + green(img.pixels[loc]) + blue(img.pixels[loc]);
         pix[0] = red(img.pixels[loc+1]) + green(img.pixels[loc+1]) + blue(img.pixels[loc+1]);
         pix[1] = red(img.pixels[loc-1]) + green(img.pixels[loc-1]) + blue(img.pixels[loc-1]);
         
         pix[2] = red(img.pixels[bot_loc]) + green(img.pixels[bot_loc]) + blue(img.pixels[bot_loc]);
         pix[3] = red(img.pixels[bot_loc+1]) + green(img.pixels[bot_loc+1]) + blue(img.pixels[bot_loc+1]);
         pix[4] = red(img.pixels[bot_loc-1]) + green(img.pixels[bot_loc-1]) + blue(img.pixels[bot_loc-1]);
         
         pix[5] = red(img.pixels[top_loc]) + green(img.pixels[top_loc]) + blue(img.pixels[top_loc]);
         pix[6] = red(img.pixels[top_loc+1]) + green(img.pixels[top_loc+1]) + blue(img.pixels[top_loc+1]);
         pix[7] = red(img.pixels[top_loc-1]) + green(img.pixels[top_loc-1]) + blue(img.pixels[top_loc-1]);
         
         float diff = 0;
         for(int i = 0; i < pix.length; i++){
           float temp_diff = abs(center - pix[i]);
           if(temp_diff > diff){
             diff = temp_diff;
             //println(diff);
           }
         }
         
         if (diff > 100){
           edges.add(new PVector(x,y));
           colors.add(color(red(img.pixels[loc]), green(img.pixels[loc]), blue(img.pixels[loc]), 100));
           stroke(0);
           //point(x, y);
         }
        }
       }
      }
  }
  
  void draw_shapes(){
    randomSeed(100);
    for(int i = 0; i < edges.size(); i++){
      noStroke();
      fill(colors.get(i));
      if(random(10000) < 9990){
        color pix_color = colors.get(i);
        float brightness = red(pix_color) + green(pix_color) + blue(pix_color);
        float size = (brightness/(255*3)) * ((width+height)/2)/4;
        PShape circ;
        circ = createShape();
        circ.beginShape();
        float radius = size / 2;
        PVector master = new PVector(edges.get(i).x, edges.get(i).y);
        for(float theta = 0; theta < 2*PI; theta += 0.42){
          PVector p = PVector.fromAngle(theta);
          p.setMag(radius+random(-(radius/10), radius/10));
          p.add(master);
          circ.vertex(p.x, p.y);
        }
        PShape rounded = createShape();
        rounded = chaikin_close(circ, 0.25, 4, colors.get(i));
        shape(rounded);
      }
      else{
        rectMode(CENTER);
        color pix_color = colors.get(i);
        float brightness = red(pix_color) + green(pix_color) + blue(pix_color);
        float size = (brightness/(255*3)) * ((width+height)/2)/5;
        rect(edges.get(i).x, edges.get(i).y, size, size);
      }
    }
  }
  
  color background_color(){
    java.util.Collections.sort(colors);
    return(colors.get(colors.size()-2));
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
  
  PShape chaikin(PShape shape, float ratio, int iterations, boolean close, color col) {
    //println("We in");
    // If the number of iterations is zero, return shape as is
    if (iterations == 0)
      return shape;
  
    PShape next = createShape();
    next.beginShape();
    next.noStroke();
    next.fill(col);
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
  
    return chaikin(next, ratio, iterations - 1, close, col);
  }
  
  PShape chaikin_close(PShape original, float ratio, int iterations, color col) {
    return chaikin(original, ratio, iterations, true, col);
  }
  
  PShape chaikin_open(PShape original, float ratio, int iterations, color col) {
    return chaikin(original, ratio, iterations, false, col);
  }
}
