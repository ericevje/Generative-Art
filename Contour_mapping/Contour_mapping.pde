PImage img;
int num = 15000;
int[] rank = new int[num]; 
int[] xS = new int[num];
int[] yS = new int[num];

color silver = color(246,246,250);
color dblue = color(112,83,145);
color dblue2 = color(185,181,252);

void settings(){
  img = loadImage("https://uploads5.wikiart.org/images/paul-gauguin/where-do-we-come-from-what-are-we-where-are-we-going-1897.jpg!Large.jpg"); //choose image here
  size(img.width, img.height);
}

void setup() {
  img = loadImage("https://uploads5.wikiart.org/images/paul-gauguin/where-do-we-come-from-what-are-we-where-are-we-going-1897.jpg!Large.jpg"); //choose image here
  //noStroke();
  background(0);
  
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

void draw() {
  //image(img, 0, 0);
  noLoop();
  lines2();
  save("fistLine.png");
}

void lines2(){
  stroke(0);
  float closest;
  ArrayList<PVector> vectors = new ArrayList<PVector>();
  for(int i = 0; i < num; i++) {
    vectors.add(new PVector(xS[i], yS[i]));
  }
  int a=0;
  int b=0;
  float curDist=width;;
  while(vectors.size()>34){
    closest=width;
    float px = vectors.get(a).x;
    float py = vectors.get(a).y;
    vectors.remove(a);
    for(int p=0;p<vectors.size();p++){
      curDist=dist(px,py,vectors.get(p).x,vectors.get(p).y);
      if(curDist<closest){
          closest=curDist;
          b=p; 
      }
    }
  float cRatio = py/height;
  color cor = lerpColor(dblue,dblue2,cRatio); 
  stroke(cor);
  line(px,py,vectors.get(b).x,vectors.get(b).y);
  a=b;
  }
} 
