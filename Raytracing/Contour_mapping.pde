class Contours {
  PImage img;
  int image_width;
  int image_height;
  int num;
  int[] rank; 
  int[] xS;
  int[] yS;
  ArrayList<Boundary> boundaries;
  
  Contours(PImage image, ArrayList<Boundary> walls, int num_walls){
    img = image;
    image_width = img.width;
    image_height = img.height;
    num = num_walls;
    rank = new int[num]; 
    xS = new int[num];
    yS = new int[num];
    boundaries = walls;
  }
  
  void edge_detect(){
    for(int j=0;j<num;j++){
      rank[j]=0; 
    }
    //img = loadImage("61Wqjd88uOL._SL1001_.jpg"); //choose image here
    img.loadPixels();  
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int loc = x + y*width;
        if(loc<img.pixels.length-1){
         float total1 = red(img.pixels[loc]) + green(img.pixels[loc]) + blue(img.pixels[loc]);     
         float total2 = red(img.pixels[loc+1]) + green(img.pixels[loc+1]) + blue(img.pixels[loc+1]);
         float diff = total1-total2;
         for(int k=0;k<rank.length-1;k++){
           if(diff>rank[k]){
             rank = splice(rank,int(diff),k);
             rank = shorten(rank);
             xS = splice(xS,x,k);
             xS=shorten(xS);
             yS = splice(yS,y,k);
             yS=shorten(yS);
             break;
           } 
         }
        }
       }
      }
  }
  
  void draw_lines(){
    stroke(0);
    float closest;
    ArrayList<PVector> vectors = new ArrayList<PVector>();
    for(int i = 0; i < num; i++) {
      vectors.add(new PVector(xS[i], yS[i]));
    }
    int a=0;
    int b=0;
    int i = 0;
    float curDist=width;
    while(vectors.size()>34){
      closest=width;
      float px = vectors.get(a).x;
      float py = vectors.get(a).y;
      vectors.remove(a);
      for(int p=0;p<vectors.size();p++){
        curDist=dist(px,py,vectors.get(p).x,vectors.get(p).y);
        if(curDist<closest){
            if (curDist < 10){
              vectors.remove(p);
            }
            else{
              closest=curDist;
              b=p;
            }
        }
      }
      Boundary new_boundary = new Boundary(px,py,vectors.get(b).x,vectors.get(b).y);
      if (new_boundary != null){
        boundaries.add(new_boundary);
      }
      i++;
      a=b;
    }
    
    Boundary top = new Boundary(0, 0, width, 0);
    Boundary bottom = new Boundary(0, height-1, width, height-1);
    Boundary left = new Boundary(0, 0, 0, height);
    Boundary right = new Boundary(width, 0, width, height);
    
    walls.add(top);
    walls.add(bottom);
    walls.add(left);
    walls.add(right);
  }
  
  void clean_up(){
    for (int i = boundaries.size() - 1; i >= 0 ; i--){
      float dist = abs(PVector.dist(boundaries.get(i).a, boundaries.get(i).b));
      //println(dist);
      if(dist > ((width+height)/2)/30){
        boundaries.remove(i);
      }
      else{
        stroke(0, 50);
        line(boundaries.get(i).a.x, boundaries.get(i).a.y, boundaries.get(i).b.x, boundaries.get(i).b.y); 
      }
    }
  }
}
