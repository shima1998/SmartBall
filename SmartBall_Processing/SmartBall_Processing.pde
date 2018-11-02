//Procesing side 
//This Program shows quiz in monitor.
//Need Library Firmata
//I start from 10/28/2018

/*Reference: 
 https://teratail.com/questions/12299
 http://kousaku-kousaku.blogspot.com/2008/10/arduino.html
 http://d.hatena.ne.jp/afeq/20110211/1297407108
 https://yoppa.org/tau_bmaw13/4772.html
 http://piyopiyocs.blog115.fc2.com/blog-entry-1125.html
 https://yoppa.org/geidai_media1_17/8243.html
 https://joppot.info/2016/04/18/3127
 */

//This program base Sample Program "arduino_output" of Firmata.
//For more information, see: http://playground.arduino.cc/Interfacing/Processing

import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

//Variables
color off = color(4, 79, 111);
color on = color(84, 145, 158);

int start_count = 0;//This variable stop malfunction of start up.
int light_value = 600;//If photo transisitor's value below this value, begin screen transition;
int language = 0;//for change language of quiz

String[] country = {"j", "e", "c1", "c2", "k"};

PImage[][] quiz_img;//Quiz Image 
PImage[][] ans_img;//Answer Image
PImage hakodate_yama;

int main_screen = 0;//variable for MainScreen transition.
int quiz_screen = 0;//variable for QuestionScreen transition.
int[] quiz_num;

boolean[] can_start_quiz;//variable for question start



void setup() {
  quiz_img = new PImage[5][8];//Image Initialize
  ans_img = new PImage[5][8];
  can_start_quiz = new boolean[8];
  quiz_num = get_no_dup_order_numbers(0, 7);


  //size(500, 500);
  fullScreen();

  // Prints out the available serial ports.
  println(Arduino.list());
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);



  for (int i1 = 0; i1 < 5; i1++) {
    for (int i2 = 0; i2 < 8; i2++) {
      quiz_img[i1][i2] = loadImage("Q" + (i2 + 1) + "_" + country[i1] + ".jpg");
      ans_img[i1][i2] = loadImage("A" + (i2 + 1) +"_" + country[i1] + ".jpg");
    }
  }

  hakodate_yama = loadImage("HakodateYama.jpg");
}

void draw() {

  if (start_count < 130) { //stop malfunction of start up.
    start_count++;
  }

  switch(main_screen) {//Screen
  case 0://Start
    background(255);
    tint(255, 70);
    image(hakodate_yama, 0, 0, width, height);
    noTint();
    stroke(0);

    button_language(width / 2 - 500, height / 2 - 200, "Japanese", 0);//change language to Japanese
    button_language(width / 2 - 300, height / 2 - 200, "English", 1);//change language to English
    button_language(width / 2 - 100, height / 2 - 200, "Traditional Chinese", 2);//change language to Chinese1
    button_language(width / 2 + 100, height / 2 - 200, "Simplified Chinese", 3);//change language to Chinese2
    button_language(width / 2 + 300, height / 2 - 200, "Korean", 4);//change language to Korean
    
    button_reset(0, height - 110);


    if (can_start_quiz[0]) {
      button_quiz(width / 2 - 400, height / 2 + 100, "Q1", 1);//start Question1
    }

    if (can_start_quiz[1]) {
      button_quiz(width / 2 - 200, height / 2 + 100, "Q2", 2);//start Question2
    }

    if (can_start_quiz[2]) {
      button_quiz(width / 2, height / 2 + 100, "Q3", 3);//start Question3
    }

    if (can_start_quiz[3]) {
      button_quiz(width / 2 + 200, height / 2 + 100, "Q4", 4);//start Question4
    }

    if (can_start_quiz[4]) {
      button_quiz(width / 2 - 400, height / 2 + 200, "Q5", 5);//start Question5
    }

    if (can_start_quiz[5]) {
      button_quiz(width / 2 - 200, height / 2 + 200, "Q6", 6);//start Question6
    }

    if (can_start_quiz[6]) {
      button_quiz(width / 2, height / 2 + 200, "Q7", 7);//start Question7
    }

    if (can_start_quiz[7]) {
      button_quiz(width / 2 + 200, height / 2 + 200, "Q8", 8);//start Question8
    }


    textSize(30);
    switch(language) {//show language
    case 0:
      text("Japanese", 100, 100);
      break;
    case 1:
      text("English", 100, 100);
      break;
    case 2:
      text("Traditional Chinese", 100, 100);
      break;
    case 3:
      text("Simplified Chinese", 100, 100);
      break;
    case 4:
      text("Korean", 100, 100);
      break;
    }
    break;
  case 1://Question1,Answer1
    quiz(language, 0);
    break;
  case 2://Question2,Answer2
    quiz(language, 1);
    break;
  case 3://Question3,Answer3
    quiz(language, 2);
    break;
  case 4://Question4,Answer4
    quiz(language, 3);
    break;
  case 5://Question5,Answer5
    quiz(language, 4);
    break;
  case 6://Question6,Answer6
    quiz(language, 5);
    break;
  case 7://Question7,Answer7
    quiz(language, 6);
    break;
  case 8://Question8,Answer8
    quiz(language, 7);
    break;
  }

  if (start_count > 120) {//for Screen transition.
    if (analog(0) < light_value) {
      can_start_quiz[quiz_num[0]] = true;
    } 

    if (analog(1) < light_value) {
      can_start_quiz[quiz_num[1]] = true;
    }

    if (analog(2) < light_value) {
      can_start_quiz[quiz_num[2]] = true;
    }

    if (analog(3) < light_value) {
      can_start_quiz[quiz_num[3]] = true;
    }

    if (analog(4) < light_value) {
      can_start_quiz[quiz_num[4]] = true;
    }

    if (analog(5) < light_value) {
      can_start_quiz[quiz_num[5]] = true;
    }

    if (analog(6) < light_value) {
      can_start_quiz[quiz_num[6]] = true;
    }

    if (analog(7) < light_value) {
      can_start_quiz[quiz_num[7]] = true;
    }
  }


  println(analog(1));
}


//Functions

int analog(int pin) {//Analog Pin
  int analog_value;//read by analog pin
  analog_value = arduino.analogRead(pin);
  return analog_value;
}

void button_language(int x, int y, String alphabet, int lang) {//Button to change language
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100) {
    fill(0, 255, 0);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  } else {
    fill(255);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  }

  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 200 && mousePressed) {
    language = lang;
  }
}

void button_quiz(int x, int y, String alphabet, int quiz) {//Button to start quiz
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100) {
    fill(0, 255, 0);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  } else {
    fill(255);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  }

  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100 && mouseButton == LEFT) {
    main_screen = quiz;
  }
}

void button_ans(int x, int y, String alphabet) {//Button to start quiz
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100) {
    fill(0, 255, 0);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  } else {
    fill(255);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 50);
  }

  if (main_screen != 0 && quiz_screen == 0 && mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100 && mouseButton == RIGHT) {
    quiz_screen = 1;
  }

  if (main_screen != 0 && quiz_screen == 1 && mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100 && mouseButton == LEFT) {
    main_screen = 0;
    quiz_screen = 0;
  }
}

void button_reset(int x, int y) {//Button to start quiz
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100) {
    fill(255, 0, 0);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text("RESET", x + 10, y + 50);
  } else {
    fill(255);
    rect(x, y, 200, 100);
    fill(0);
    textSize(20);
    text("RESET", x + 10, y + 50);
  }

  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 100 && mousePressed) {
    for (int i = 0; i < 8; i++) {
      can_start_quiz[i] = false;
    }
    quiz_num = get_no_dup_order_numbers(0, 7);
  }
}

int[] get_no_dup_order_numbers(int start_num, int end_num) {//from https://joppot.info/2016/04/18/3127
  int num_size = (end_num+1) - start_num; 
  IntList nums = new IntList(num_size);
  for (int i = start_num; i <= end_num; i++) {
    nums.append(i);
  };
  nums.shuffle();
  int[] result = nums.array();
  return result;
}



void quiz(int number, int country) {//Question Screen
  background(255);
  switch(quiz_screen) {
  case 0:
    noTint();
    image(quiz_img[number][country], width / 10, 0, width - width / 6, height);//Show Quiz  
    button_ans(width / 2 - 100, height / 2 + 300, "ANSWER");
    break;
  case 1:
    noTint();
    image(ans_img[number][country], width / 10, 0, width - width / 6, height);//Show Answer
    button_ans(width / 2 + 200, height / 2 + 300, "END");
    break;
  }
}
