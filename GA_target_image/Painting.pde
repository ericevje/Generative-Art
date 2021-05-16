

class Painting{
  ArrayList<Shape> shapes;
  float rating;
  
  

  Painting() {
    shapes = new ArrayList<Shape>();
    rating = 0;
  }
  
  void show(){
    for (Shape shape : shapes){
      shape.show();
    }
  }
}
