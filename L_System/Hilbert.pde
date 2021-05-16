class Hilbert{
  
  Hilbert(){
  }
  
  void turtle(String str){
    for (int i=0; i < str.length(); i++) {
      char current = str.charAt(i);
  
      if (random(10000) > 9990) {
        int new_number = round(random(1, 8));
        current = char(new_number);
      }
      
      if (current == '1') {
        stroke(255, 100);
        line(0, 0, len, 0);
        translate(len, 0);
      } else if (current == '5') {
        stroke(255, 100);
        line(0, 0, -len, 0);
        translate(-len, 0);
      } else if (current == '2') {
        stroke(255, 100);
        line(0, 0, 0, -len);
        translate(0, -len);
      } else if (current == '6') {
        stroke(255, 100);
        line(0, 0, 0, len);
        translate(0, len);
      }  else {
        //println("Not found");
      }
    }
  }
  
  String generate(String list){
    String new_sentence = "";
    for (int i =0; i < list.length(); i++) {
      //println(str(list.charAt(i)));
      String add_string = rules(list.charAt(i));
      new_sentence += add_string;
    }
    return new_sentence;
  }
  
  String rules(char character) {
    if (character == '1') {
      return "1";
    } else if (character == '2') {
      return "2";
    } else if (character == '3') {
      return "4231368";
    } else if (character == '4') {
      return "3142457";
    } else if (character == '5') {
      return "5";
    } else if (character == '6') {
      return "6";
    } else if (character == '7') {
      return "8675724";
    } else if (character == '8') {
      return "7586813";
    } else {
      return str(character);
    }
  }
}
