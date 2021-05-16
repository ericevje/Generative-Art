Population pop;
ArrayList <PVector> parents;
int click_counter = 0;
boolean cont = false;


void setup() {
  fullScreen();
  //size(800, 800);
  background(100, 100, 200);
  pop = new Population(6, 0.1, 0.025);
  parents = new ArrayList <PVector>();
  parents.add(0, new PVector(0,0));
  parents.add(1, new PVector(0,0));
  pop.draw_pop();
}


void draw() {
  delay(100);
  //println(cont);
  if(cont){
    cont = false;
    //delay(100);
    println("clicked");
    int index = click_counter % 2;
    //println(index);
    parents.add(index, new PVector(mouseX, mouseY));
    click_counter++;
    if ((index == 1) && (click_counter > 1)){
      println(parents.get(0), parents.get(1));
      pop.natural_selection(parents.get(0), parents.get(1));
      background(100, 100, 200);
      pop.draw_pop();
    }
  }
}

void mouseClicked(){
  cont = true;
}
