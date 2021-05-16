import java.util.Collections;

Population population;
Painting best_painting;
int counter = 0;
PImage target_image;
PImage all_time_img;
PImage gen_img;
float gen_max_rate = 0;
float all_time_rate = 0;


void settings(){
  //target_image = loadImage("red-green.bmp");
  target_image = loadImage("mona-500.bmp");
  //target_image = loadImage("white.jpg");
  target_image.resize(100, 0);
  size(target_image.width*2, target_image.height*2);
  if (height/2 % 2 != 0){
    target_image.resize(100, height/2 + 1);
  }
  size(target_image.width*2, target_image.height*2);
  all_time_img = target_image.copy();
  gen_img = target_image.copy();
}

void setup() {
  background(255);
  population = new Population(8000, 0.01, 100);
  best_painting = new Painting();
  //println(width, height);
  println(width, height);
}

void draw() {
  background(255);
  image(target_image, 0, 0);
  //image(target_image, width/2, 0);
  resetMatrix();
  translate(width/2, 0);
  population.paintings.get(counter).show();
  
  resetMatrix();
  translate(0, height/2);
  image(all_time_img, 0, 0);
  
  resetMatrix();
  translate(width/2, height/2);
  image(gen_img, 0, 0);
  
  
  population.paintings.get(counter).rating = rate();
  //println(population.paintings.get(counter).rating);
  if (population.paintings.get(counter).rating > gen_max_rate){
    //println(population.paintings.get(counter).rating, gen_max_rate);
    gen_max_rate = population.paintings.get(counter).rating;
    gen_img = get(width/2, 0, width/2, height/2);
    gen_img.save("gen_img.tiff");
    gen_img = loadImage("gen_img.tiff");
  }
  if (population.paintings.get(counter).rating > all_time_rate){
    all_time_rate = population.paintings.get(counter).rating;
    all_time_img = get(width/2, 0, width/2, height/2);
    all_time_img.save("all_time.tiff");
    all_time_img = loadImage("all_time.tiff");
  }
  
  counter++;
  if (counter >= population.paintings.size()){
    println("Generation Rating: " + gen_max_rate + "\tAll time: " + all_time_rate + "\tgeneration: " + population.gen);
    counter = 0;
    gen_max_rate = 0;
    population.natural_selection();
  }
}

//float rate(){
//  float kolmogorov = 0;
//  float med_red = 0;
//  float med_green = 0;
//  float med_blue = 0;
//  ArrayList<Float> red = new ArrayList<Float> ();
//  ArrayList<Float> green = new ArrayList<Float> ();
//  ArrayList<Float> blue = new ArrayList<Float> ();
//  byte[] img = loadBytes("img.jpg");
//  float com_bytes = img.length * 1.0;
//  float rating= 0;
  
//  kolmogorov = ((width/2 * height * 3) - com_bytes) /
//               (width/2 * height * 3);
               
//  loadPixels(); //Assumes current image being rated is drawn
//  for (int y = 0; y < height; y++){
//    for (int x = width/2; x < width; x++){
//      int index = y * width + x;
//      red.add(red(pixels[index])/255);
//      green.add(green(pixels[index])/255);
//      blue.add(blue(pixels[index])/255);
//    }
//  }
  
//  Collections.sort(red);
//  Collections.sort(green);
//  Collections.sort(blue);
  
//  med_red = red.get(floor(red.size()/2));
//  med_green = green.get(floor(red.size()/2));
//  med_blue = blue.get(floor(red.size()/2));
  
//  float kol_score = 1 - abs(0.8867 - kolmogorov);
//  float red_score = 1 - abs(0.4956295 - med_red);
//  float green_score = 1 - abs(0.4260476 - med_green);
//  float blue_score = 1 - abs(0.3610234 - med_blue);
  
//  rating = pow((kol_score + red_score + green_score + blue_score) / 4, 3);
//  return rating;
//}

float rate(){
  loadPixels();
  float rating = 0;
  for (int y = 0; y < height/2; y++){
    for (int x = 0; x < width/2; x++){
      int ind_target = y * width/2 + x;
      int ind_painting = ind_target + width/2;
      float diff_red = 255 - (abs(red(pixels[ind_target]) - red(pixels[ind_painting])));
      float diff_green = 255 - (abs(green(pixels[ind_target]) - green(pixels[ind_painting])));
      float diff_blue = 255 - (abs(blue(pixels[ind_target]) - blue(pixels[ind_painting])));
      
      rating += (diff_red + diff_green + diff_blue);
    }
  }
  rating = pow(rating / (3*255 * (pixels.length / 4)), 25);
  return rating;
}
