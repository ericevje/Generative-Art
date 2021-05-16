import java.util.Collections;

class Painting{
  ArrayList<Shape> shapes;
  float kolmogorov = 0;
  float med_red = 0;
  float med_green = 0;
  float med_blue = 0;
  ArrayList<Float> red;
  ArrayList<Float> green;
  ArrayList<Float> blue;
  float rating;
  
  

  Painting() {
    shapes = new ArrayList<Shape>();
    red = new ArrayList<Float>();
    green = new ArrayList<Float>();
    blue = new ArrayList<Float>();
    rating = 0;
  }
  
  void show(){
    for (Shape shape : shapes){
      shape.show();
    }
  }
  
  void rate(){
    byte[] img = loadBytes("img.jpg");
    float com_bytes = img.length * 1.0;
    kolmogorov = ((width * height * 3) - com_bytes) /
                 (width * height * 3);
    loadPixels();
    for (int i = 0; i < pixels.length; i++){
      red.add(red(pixels[i])/255);
      green.add(green(pixels[i])/255);
      blue.add(blue(pixels[i])/255);
    }
    
    Collections.sort(red);
    Collections.sort(green);
    Collections.sort(blue);
    
    med_red = red.get(floor(red.size()/2));
    med_green = green.get(floor(red.size()/2));
    med_blue = blue.get(floor(red.size()/2));
    
    float kol_score = 1 - abs(0.8867 - kolmogorov);
    float red_score = 1 - abs(0.4956295 - med_red);
    float green_score = 1 - abs(0.4260476 - med_green);
    float blue_score = 1 - abs(0.3610234 - med_green);
    
    rating = pow((kol_score + red_score + green_score + blue_score) / 4, 3);
  }
}
