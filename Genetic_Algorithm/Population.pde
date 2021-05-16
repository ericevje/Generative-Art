class Population{
  int len = 2;
  int pool;
  float mut_rate;
  ArrayList <String> population;
  float edges;
  int rot = 6;
  int rows;
  int cols;
  ArrayList <Integer> colors;
  
  Population(int pool_size, float mutation_rate, float edge_percent){
    pool = pool_size;
    mut_rate= mutation_rate;
    edges = edge_percent * width * height;
    rows = floor(sqrt(pool_size));
    cols = ceil(pool_size/rows);
    colors = new ArrayList <Integer>();
    
    population = new ArrayList <String>();
    for (int i = 0; i< pool; i++){
      String new_sentence = "";
      for (int j = 0; j < edges; j++){
        new_sentence += str(int(round(random(1, 5))));
      }
      population.add(i, new_sentence);
    }
    colors.add(0, color(255, 0, 0));
    colors.add(1, color(0, 255, 0));
    colors.add(2, color(0, 0, 255));
    colors.add(3, color(50, 255, 70));
    colors.add(4, color(255, 75, 80));
    colors.add(5, color(150, 0, 255));
    colors.add(6, color(255));
    
    
  }
  
  void new_generation(int index_a, int index_b){ 
    String Parent_A = population.get(index_a);
    String Parent_B = population.get(index_b);
    //println(Parent_A);
    println("populations size: " + population.size());
    for (int i = 0; i < population.size(); i++){
      //println("making baby");
      population.set(i, crossover(Parent_A, Parent_B));
    }
  } 

  void natural_selection(PVector A, PVector B){ 
    int index_a = floor(A.y/(height/rows))*cols + floor(A.x/(width/rows));
    println("index A: " + index_a);
    
    int index_b = floor(B.y/(height/rows))*cols + floor(B.x/(width/rows));
    println("index B: " + index_b);
    
    new_generation(index_a, index_b);
  }
  
  String crossover(String parentA, String parentB){
    //println("crossover");
    int len = parentA.length();
    int split = round(random(0.25*len, 0.8*len));
    String offspring = parentA.substring(0, split) + parentB.substring(split);
    println("offspring length: " + offspring.length());
    String mut_offspring = mutate(offspring);
    println("after mutation: " + mut_offspring.length());
    println("");
    return mut_offspring;
  }
  
  
  String mutate (String offspring){
    String mutated = "";
    for (int i = 0; i < offspring.length(); i++){
      if (random(0, 1) <= mut_rate){
        int selector = int(round(random(1,3)));
        if (selector == 1){
          //Random swap
          //println("swap");
          mutated += str(int(round(random(1, 8))));
        }
        else if (selector == 2){
          //Deletion
          //println("delete");
        }
        else if (selector == 3){
          //addition
          //println("add");
          mutated += str(offspring.charAt(i));
          mutated += str(int(round(random(1, 8))));
        }
        else{
          println("your math is wrong");
        }
      }
      else{
        mutated += str(offspring.charAt(i));
      }
    }
    return mutated;
  }
  
  void draw_pop(){
    for (int row = 0; row < rows; row++){
      for (int col = 0; col < cols; col++){
        if (row*cols + col > population.size()){
          break;
        }
        else{
          push();
          translate(width * (col/float(cols)), height * (row/float(rows)));
          noStroke();
          fill(255);
          ellipse(0,0,10,10);
          stroke(colors.get(row*cols + col));
          turtle(population.get(row*cols + col));
          pop();
        }
      }
    }
  }
  
  void turtle(String str){
  for (int i=0; i < str.length(); i++) {
    char current = str.charAt(i);

    if (current == '1') {
      //stroke(255, 100);
      //float x = random(-2, 2);
      //float y = -len + random(-2, 2);
      float x = 0;
      float y = len;
      line(0, 0, x, y);
      translate(x, y);
    } else if (current == '2') {
      rotate(-PI/rot);
    } else if (current == '3') {
      rotate(PI/rot);
    } else if (current == '4') {
      //push();
    } else if (current == '5') {
      //pop();
    } else {
      //println("Not found");
    }
  }
  }
}
