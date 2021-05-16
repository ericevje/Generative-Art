class Population{
  int pool;
  int starting_shapes;
  float mut_rate;
  ArrayList <Painting> paintings;
  float sum_ratings;
  

  Population(int pool_size, float mutation_rate, int starting){
    pool = pool_size;
    mut_rate= mutation_rate;
    starting_shapes = starting;
    
    paintings = new ArrayList <Painting>();
    for (int i = 0; i< pool; i++){
      Painting new_painting = new Painting();
      for (int j = 0; j < starting_shapes; j++){
        Shape new_shape = new Shape();
        new_painting.shapes.add(new_shape);
      }
      paintings.add(new_painting);
    }
  }
  
  void new_generation(int index_a, int index_b){
    sum_ratings();
    ArrayList<Float> probs = new ArrayList<Float>();
    for (int i = 0; i < paintings.size(); i++){
      float prob = paintings.get(i).rating / sum_ratings;
      probs.add(prob);
    }
    
    for (int j = 0; j < paintings.size(); j++){
      int index = 0;
      float chooser = random(1);
      while (chooser > 0){
        chooser = chooser - probs.get(index);
        index++;
      }
      index--;
      Painting Parent_A = paintings.get(index);
      
      index = 0;
      chooser = random(1);
      while (chooser > 0){
        chooser = chooser - probs.get(index);
        index++;
      }
      index--;
      Painting Parent_B = paintings.get(index);
        
      
      paintings.set(j, crossover(Parent_A, Parent_B));
    }
  }

  void natural_selection(){
    int index_a = round(random(paintings.size() - 1));
    int index_b = round(random(paintings.size() - 1));
    new_generation(index_a, index_b);
  }
  
  Painting crossover(Painting parentA, Painting parentB){
    //println("crossover");
    int len = parentA.shapes.size();
    int split = round(random(0.25*len, 0.8*len));
    Painting offspring = new Painting();
    for (int i = 0; i < split; i++){
      offspring.shapes.add(parentA.shapes.get(i));
    }
    for (int j = split; j < parentB.shapes.size(); j++){
      offspring.shapes.add(parentB.shapes.get(j));
    }
    //println("offspring length: " + offspring.shapes.size());
    Painting mut_offspring = mutate(offspring);
    //println("after mutation: " + mut_offspring.shapes.size());
    //println("");
    return mut_offspring;
  }
  
  
  Painting mutate (Painting offspring){
    Painting mutated = new Painting();
    for (int i = 0; i < offspring.shapes.size(); i++){
      if (random(0, 1) <= mut_rate){
        int selector = int(floor(random(1,4)));
        if (selector == 1){
          //Random swap
          //println("swap");
          Shape swap_shape = new Shape();
          mutated.shapes.add(swap_shape);
        }
        else if (selector == 2){
          //Deletion
          //println("delete");
        }
        else if (selector == 3){
          //addition
          //println("add");
          mutated.shapes.add(offspring.shapes.get(i));
          Shape swap_shape = new Shape();
          mutated.shapes.add(swap_shape);
        }
        else{
          println("your math is wrong");
        }
      }
      else{
        mutated.shapes.add(offspring.shapes.get(i));
      }
    }
    return mutated;
  }
  
  void sum_ratings(){
    sum_ratings = 0;
    for (int i = 0; i < paintings.size(); i++){
      sum_ratings += paintings.get(i).rating;
    }
    println("Average rating: " + sum_ratings/paintings.size());
  }
}
  
