Population population;
Painting best_painting;
int counter = 0;


void setup() {
  size(500, 500);
  background(255);
  population = new Population(75, 0.05, 10);
  best_painting = new Painting();
}


void draw() {
  background(255);
  population.paintings.get(counter).show();
  saveFrame("img.jpg");
  population.paintings.get(counter).rate();
  if (population.paintings.get(counter).rating > best_painting.rating){
    best_painting = population.paintings.get(counter);
    saveFrame("best_painting.jpg");
    saveFrame();
  }
  
  counter++;
  //println(counter);
  if (counter >= population.paintings.size()){
    counter = 0;
    population.natural_selection();
  }
}

void mouseClicked(){
}
