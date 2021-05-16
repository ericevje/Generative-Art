class Population{
  int pool;
  int starting_shapes;
  float mut_rate;
  ArrayList <Painting> paintings;
  float sum_ratings;
  float avg_rating;
  float max_rating;
  int gen = 0;
  Painting Parent_A;
  Painting best_painting_gen;
  Painting best_painting_ovall;
  PImage best_painting_gen_img;
  PImage best_painting_ovall_img;
  

  Population(int pool_size, float mutation_rate, int starting){
    pool = pool_size;
    mut_rate= mutation_rate;
    starting_shapes = starting;
    Parent_A = new Painting();
    best_painting_ovall = new Painting();
    best_painting_gen = new Painting();
    
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
  
  void new_generation(){
    gen++;
    sum_ratings();
    ArrayList<Float> probs = new ArrayList<Float>();
    ArrayList<Painting> new_generation = new ArrayList<Painting>();
    best_painting_gen.rating = 0;

    
    //float sum_prob = 0;
    for (int i = 0; i < paintings.size(); i++){
      float prob = paintings.get(i).rating / sum_ratings;
      //sum_prob += prob;
      //println(prob, sum_prob);
      probs.add(prob);
    }
    
    for (int j = paintings.size() - 1; j >=0; j--){
      //println(probs.get(j));
      if (paintings.get(j).rating < max_rating*.30){
        //probs.remove(j);
        paintings.remove(j);
      }
    }
    
    //println(paintings.size());
    
    probs.clear();
    sum_ratings();
    for (int i = 0; i < paintings.size(); i++){
      float prob = paintings.get(i).rating / sum_ratings;
      //sum_prob += prob;
      //println(prob, sum_prob);
      probs.add(prob);
    }
    
    for (int j = 0; j < pool; j++){
      //for (Painting old_painting: paintings){
      //  println("Old painting: " + old_painting.rating + "\t");
      //}
      //println("");
      //for (Painting new_painting: new_generation){
      //  println("New paintings: " + new_painting.rating + "\t");
      //}
      //  println("");
      int index = 0;
      float chooser = random(0, 1);
      
      while (chooser >= 0){
        if (index < probs.size()){
          chooser = chooser - probs.get(index);
          index++;
        }
        else{
          index = probs.size();
        }
      }
      index--;
      //print(index + "\t");
      Parent_A = paintings.get(index);
      print(Parent_A.rating + "\t");
      
      index = 0;
      chooser = random(1);
      while (chooser >= 0){
          if (index < probs.size()){
            chooser = chooser - probs.get(index);
            index++;
          }
          else{
            index = probs.size();
          }
      }
      index--;
      //println(index);
      Painting Parent_B = paintings.get(index);
      println(Parent_B.rating + "\t");
        
      
      new_generation.add(crossover_random(Parent_A, Parent_B));
    }
    paintings.clear();
    paintings = new ArrayList(new_generation);
  }

  void natural_selection(){
    new_generation();
  }
  
  Painting crossover(Painting parentA, Painting parentB){
    int len = parentA.shapes.size();
    int split = round(random(0.05*len, 0.95*len));
    Painting offspring = new Painting();
    for (int i = 0; i < split; i++){
      offspring.shapes.add(parentA.shapes.get(i));
    }
    for (int j = split; j < parentB.shapes.size(); j++){
      offspring.shapes.add(parentB.shapes.get(j));
    }
    Painting mut_offspring = mutate(offspring);
    return mut_offspring;
  }
  
  Painting crossover_random(Painting parentA, Painting parentB){
    Painting offspring = new Painting();
    for (int i = 0; i < parentB.shapes.size(); i++){
      if (random(1) <.5){
        offspring.shapes.add(parentA.shapes.get(i));
      }
      else{
        offspring.shapes.add(parentB.shapes.get(i));
      }
    }
    Painting mut_offspring = mutate(offspring);
    return mut_offspring;
  }  
  
  
  Painting mutate (Painting offspring){
    //int counter = 0;
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
          //counter++;
          //println(counter);
          //Modify color of existing
          //int index = floor(random(0, offspring.shapes.size()));
          color old_color = offspring.shapes.get(i).col;
          color new_color;
          //print(red(old_color), green(old_color), blue(old_color), alpha(old_color) + "\t");
          float inc = random(-50, 50);
          int col_selector = floor(random(1, 5));
          
          if (col_selector == 1){
            float new_red = red(old_color) + inc;
            if (new_red < 0){
              new_red = 0;
            }
            if (new_red > 255){
              new_red = 255;
            }
            new_color = color(new_red, green(old_color), blue(old_color), alpha(old_color));
            //offspring.shapes.get(i).col = new_color;
          }
          
          else if (col_selector == 2){
            float new_green = green(old_color) + inc;
            if (new_green < 0){
              new_green = 0;
            }
            if (new_green > 255){
              new_green = 255;
            }
            new_color = color(red(old_color), new_green, blue(old_color), alpha(old_color));
            //offspring.shapes.get(i).col = new_color;
          }
          
          else if (col_selector == 3){
            float new_blue = blue(old_color) + inc;
            if (new_blue < 0){
              new_blue = 0;
            }
            if (new_blue > 255){
              new_blue = 255;
            }
            new_color = color(red(old_color), green(old_color), new_blue, alpha(old_color));
            //offspring.shapes.get(i).col = new_color;
          }
          
          else{
            float new_alpha = alpha(old_color) + inc;
            if (new_alpha < 0){
              new_alpha = 0;
            }
            if (new_alpha > 255){
              new_alpha = 255;
            }
            new_color = color(red(old_color), green(old_color), blue(old_color), new_alpha);
          }
            
        //println(red(new_color), green(new_color), blue(new_color), alpha(new_color));
        offspring.shapes.get(i).col = new_color;
        mutated.shapes.add(offspring.shapes.get(i));
      }
      
        else if (selector == 3){
          // Nudge a vertex of a shape
          int vertex_ind = floor(random(0, 3));
          float x_nudge = random(-20, 20);
          float y_nudge = random(-20, 20);
          
          offspring.shapes.get(i).points.get(vertex_ind).x += x_nudge;
          offspring.shapes.get(i).points.get(vertex_ind).y += y_nudge;
          
          if(offspring.shapes.get(i).points.get(vertex_ind).x < 0){
            offspring.shapes.get(i).points.get(vertex_ind).x = 0;
          }
          if(offspring.shapes.get(i).points.get(vertex_ind).x > width/2){
            offspring.shapes.get(i).points.get(vertex_ind).x = width/2;
          }
          if(offspring.shapes.get(i).points.get(vertex_ind).y < 0){
            offspring.shapes.get(i).points.get(vertex_ind).y = 0;
          }
          if(offspring.shapes.get(i).points.get(vertex_ind).y > height/2){
            offspring.shapes.get(i).points.get(vertex_ind).y = height/2;
          }
          mutated.shapes.add(offspring.shapes.get(i));
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
    max_rating = 0;
    avg_rating = 0;
    for (int i = 0; i < paintings.size(); i++){
      sum_ratings += paintings.get(i).rating;
      if (paintings.get(i).rating > max_rating){
        max_rating = paintings.get(i).rating;
      }
    }
    avg_rating = sum_ratings/paintings.size();
    //println("Average rating: " + sum_ratings/paintings.size() + "\tMaximum rating: " + max_rating + "\tgeneration: " + gen);
  }
}
  
