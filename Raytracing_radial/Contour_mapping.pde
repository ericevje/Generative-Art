//class Contours {
//  PImage img;
//  int image_width;
//  int image_height;
//  int num;
//  int[] rank; 
//  int[] xS;
//  int[] yS;
//  ArrayList<Boundary> boundaries;
//  ArrayList<PVector> edges = new ArrayList<PVector>();
  
//  Contours(PImage image, ArrayList<Boundary> walls, int num_walls){
//    img = image;
//    image_width = img.width;
//    image_height = img.height;
//    num = num_walls;
//    rank = new int[num]; 
//    xS = new int[num];
//    yS = new int[num];
//    boundaries = walls;
//  }
  
//  void edge_detect(){
//    for(int j=0;j<num;j++){
//      rank[j]=0; 
//    }
//    img.loadPixels();  
//    for (int y = 1; y < height-1; y++) {
//      for (int x = 1; x < width-1; x++) {
//        int loc = x + y*width;
//        int bot_loc = x + (y+1)*width;
//        int top_loc = x + (y-1)*width;
//        if(loc<img.pixels.length-1){
          
//         float[] pix = new float[8]; 
     
//         float center = red(img.pixels[loc]) + green(img.pixels[loc]) + blue(img.pixels[loc]);
//         pix[0] = red(img.pixels[loc+1]) + green(img.pixels[loc+1]) + blue(img.pixels[loc+1]);
//         pix[1] = red(img.pixels[loc-1]) + green(img.pixels[loc-1]) + blue(img.pixels[loc-1]);
         
//         pix[2] = red(img.pixels[bot_loc]) + green(img.pixels[bot_loc]) + blue(img.pixels[bot_loc]);
//         pix[3] = red(img.pixels[bot_loc+1]) + green(img.pixels[bot_loc+1]) + blue(img.pixels[bot_loc+1]);
//         pix[4] = red(img.pixels[bot_loc-1]) + green(img.pixels[bot_loc-1]) + blue(img.pixels[bot_loc-1]);
         
//         pix[5] = red(img.pixels[top_loc]) + green(img.pixels[top_loc]) + blue(img.pixels[top_loc]);
//         pix[6] = red(img.pixels[top_loc+1]) + green(img.pixels[top_loc+1]) + blue(img.pixels[top_loc+1]);
//         pix[7] = red(img.pixels[top_loc-1]) + green(img.pixels[top_loc-1]) + blue(img.pixels[top_loc-1]);
         
//         float diff = 0;
//         for(int i = 0; i < pix.length; i++){
//           float temp_diff = abs(center - pix[i]);
//           if(temp_diff > diff){
//             diff = temp_diff;
//             //println(diff);
//           }
//         }
         
//         if (diff > 150){
//           edges.add(new PVector(x,y));
//           stroke(red(img.pixels[loc]), green(img.pixels[loc]), blue(img.pixels[loc]), 150);
//           fill(red(img.pixels[loc]), green(img.pixels[loc]), blue(img.pixels[loc]), 150);
//           ellipseMode(CENTER);
//           float size = (center/(255*3)) * ((width+height)/2)/10;
//           //ellipse(x, y, size, size);
//         }
//        }
//       }
//      }
//  }
  
//  void draw_lines(){
//    float closest;
//    int i = int(random(edges.size() - 1));
//    int closest_index = 0;
//    float curDist=width;
//    while(edges.size()>34){
//      closest=width;
//      PVector cur_pix = edges.get(i);
//      edges.remove(i);
//      for(int p=0;p<edges.size();p++){
//        curDist = abs(PVector.dist(cur_pix, edges.get(p)));
//        if(curDist<closest){
//            if (curDist < 2){
//              edges.remove(p);
//            }
//            else{
//              closest=curDist;
//              closest_index=p;
//            }
//        }
//      }
//      Boundary new_boundary = new Boundary(cur_pix.x, cur_pix.y, edges.get(closest_index).x, edges.get(closest_index).y);
//      boundaries.add(new_boundary);
//      i = closest_index;
//    }
    
//    Boundary top = new Boundary(0, 0, width, 0);
//    Boundary bottom = new Boundary(0, height-1, width, height-1);
//    Boundary left = new Boundary(0, 0, 0, height);
//    Boundary right = new Boundary(width, 0, width, height);
    
//    walls.add(top);
//    walls.add(bottom);
//    walls.add(left);
//    walls.add(right);
//  }
  
//  void clean_up(){
//    for (int i = boundaries.size() - 1; i >= 0 ; i--){
//      float dist = abs(PVector.dist(boundaries.get(i).a, boundaries.get(i).b));
//      //print(dist + "\t"); println(((width+height)/2)/100);
//      //println(((width+height)/2)/100);
//      if(dist > ((width+height)/2)/100){
//        boundaries.remove(i);
//      }
//      //else{
//      //  stroke(0, 100);
//      //  line(boundaries.get(i).a.x, boundaries.get(i).a.y, boundaries.get(i).b.x, boundaries.get(i).b.y); 
//      //}
//    }
//  }
//}
