String sentence;
String old_sentence;
float len = 2; 
float rot = 6;
Hilbert hilbert;
int loop = 0;


void setup() {
  //fullScreen();
  size(800, 800);
  background(100, 100, 200);
  sentence = "3";
  hilbert = new Hilbert();
  //frameRate(10);
}


void draw() {
  
  translate(0, height);
  while (loop < 9){
    println(loop);
    old_sentence = sentence;
    sentence = hilbert.generate(old_sentence);
    loop++;
    //println(sentence);
  }
  
  hilbert.turtle(sentence);
  noLoop();
  
  
  //translate(width/3, height - height/3);
  ////translate(width/2, height/2);
  ////rotate(PI/4);
  //for (int i = 0; i < 6; i++) {
  //  println(sentence);
  //  old_sentence = sentence;
  //  sentence = generate(old_sentence);
  //}
  //turtle(sentence);
  //rot = rot * 0.5;
  //sentence = "X";
  //if (rot < 1.5){
  //  noLoop();
  //}
}

void mouseClicked(){
  saveFrame();
}

String rules(char character) {
  if (character == 'X') {
    //return "F+[[X]-X]-F[-FX]+X";
    return "F-FX[X]+F";
  } else if (character == 'F') {
    return "FF";
  } else {
    return str(character);
  }
}

void turtle(String str) {
  for (int i=0; i < str.length(); i++) {
    char current = str.charAt(i);

    if (current == 'F') {
      stroke(255, 100);
      //float x = random(-2, 2);
      //float y = -len + random(-2, 2);
      float x = 0;
      float y = -len;
      line(0, 0, x, y);
      translate(x, y);
    } else if (current == '+') {
      rotate(-PI/rot);
    } else if (current == '-') {
      rotate(PI/rot);
    } else if (current == '[') {
      push();
    } else if (current == ']') {
      pop();
    } else {
      println("Not found");
    }
  }
}

String generate(String list) {
  String new_sentence = "";
  for (int i =0; i < list.length(); i++) {
    //println(str(list.charAt(i)));
    String add_string = rules(list.charAt(i));
    new_sentence += add_string;
  }
  return new_sentence;
}
