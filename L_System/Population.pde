class Population{
  int len = 4;
  int pool;
  float mut_rate;
  ArrayList <String> population;
  float edges;
  int rot = 6;
  int rows;
  int cols;
  
  Population(int pool_size, float mutation_rate, float edge_percent){
    pool = pool_size;
    mut_rate= mutation_rate;
    edges = edge_percent * width * height;
    rows = floor(sqrt(pool_size));
    cols = ceil(pool_size/rows);
    
    population = new ArrayList <String>();
    for (int i = 0; i< pool; i++){
      String new_sentence = "";
      for (int j = 0; j < edges; j++){
        new_sentence += str(int(round(random(1, 5))));
      }
      population.add(i, new_sentence);
    }
  }
  
  void new_generation(String parentA, String parentB){
    for (int i = 0; i < population.size(); i++){
      population.add(i, crossover(parentA, parentB));
    }
  } 

  void natural_selection(){}
  
  String crossover(String parentA, String parentB){
    int len = parentA.length();
    int split = round(random(0.25*len, 0.8*len));
    String offspring = parentA.substring(0, split) + parentB.substring(split + 1);
    String mut_offspring = mutate(offspring);
    return mut_offspring;
  }
  
  
  String mutate (String offspring){
    String mutated = "";
    for (int i = 0; i < offspring.length(); i++){
      if (random(0, 1) <= mut_rate){
        int selector = int(round(random(1,3)));
        if (selector == 1){
          //Random swap
          mutated += str(int(round(random(1, 8))));
        }
        else if (selector == 2){
          //Deletion
        }
        else if (selector == 3){
          //addition
          mutated += str(offspring.charAt(i));
          mutated += str(int(round(random(1, 8))));
        }
        else{
          println("your math is wrong");
        }
      }
    }
    return mutated;
  }
  
  void draw_pop(){
    for (int col = 0; col < cols; col++){
      for (int row = 0; row < rows; row++){
        if (row*cols + col > population.size()){
          break;
        }
        else{
          push();
          translate(width * (col/cols), height * (row/rows));
          turtle(population.get(row*cols + col));
        }
      }
    }
  }
  
  void turtle(String str){
    for (int i=0; i < str.length(); i++) {
      char current = str.charAt(i);
  
      if (current == '1') {
        stroke(255, 100);
        //float x = random(-2, 2);
        //float y = -len + random(-2, 2);
        float x = 0;
        float y = -len;
        line(0, 0, x, y);
        translate(x, y);
      } else if (current == '2') {
        rotate(-PI/rot);
      } else if (current == '3') {
        rotate(PI/rot);
      } else if (current == '4') {
        push();
      } else if (current == '5') {
        pop();
      } else {
        println("Not found");
      }
    }
  }
}
