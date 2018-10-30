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


PImage[][] quiz_img;//Quiz Image 
PImage[][] ans_img;//Answer Image

int main_screen = 0;//variable for MainScreen transition.
int quiz_no = 0;//variable for question start
int quiz_screen = 0;//variable for QuestionScreen transition.

//Functions

int analog(int pin) {//Analog Pin
  int analog_value;//read by analog pin
  analog_value = arduino.analogRead(pin);
  return analog_value;
}

void button_language(int x, int y, String alphabet, int lang) {//Button to change language
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 200) {
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

void button_quiz(int x, int y, String alphabet, int quiz) {//Button to change language
  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 200) {
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

  if (mouseX > x && mouseX <= x + 200 && mouseY > y && mouseY <= y + 200) {
    main_screen = quiz;
  }
}

void quiz(int number, int country) {//Question Screen
  switch(quiz_screen) {
  case 0:
    image(quiz_img[number][country], 0, 0, width, height - 100);//Show Quiz   
    break;
  case 1:
    background(255);
    image(ans_img[number][country], -20, 0, width, height / 2 + 100);//Show Answer
    break;
  }
}



void setup() {
  quiz_img = new PImage[8][4];//Image Initialize
  ans_img = new PImage[8][4];

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

  quiz_img[0][0] = loadImage("Q1_j.jpg");
  ans_img[0][0] = loadImage("A1_j.jpg");

  quiz_img[1][0] = loadImage("Q1_e.jpg");
  ans_img[1][0] = loadImage("A1_e.jpg");
}

void draw() {

  if (start_count < 130) { //stop malfunction of start up.
    start_count++;
  }

  switch(main_screen) {//Screen
  case 0://Start
    background(255);
    stroke(0);

    button_language(width / 2 - 400, height / 2 - 200, "Japanese", 0);//change language to Japanese
    button_language(width / 2 - 200, height / 2 - 200, "English", 1);//change language to English
    button_language(width / 2, height / 2 - 200, "Chinese", 2);//change language to Chinese
    button_language(width / 2 + 200, height / 2 - 200, "Korean", 3);//change language to Korean


    switch(quiz_no) {
    case 0:
      break;
    case 1:
      button_quiz(width / 2 - 400, height / 2 + 100, "Q1", 1);//start Question1
      break;
    case 2:
      button_quiz(width / 2 - 200, height / 2 + 100, "Q2", 2);//start Question2
      break;
    case 3:
      button_quiz(width / 2, height / 2 + 100, "Q3", 3);//start Question3
      break;
    case 4:
      button_quiz(width / 2 + 200, height / 2 + 100, "Q4", 4);//start Question4
      break;
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
      text("Chinese", 100, 100);
      break;
    case 3:
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
  }

  if (start_count > 120) {//for Screen transition.
    if (analog(0) < light_value) {
      quiz_no = 1;
    } else if (analog(1) < light_value) {
      quiz_no = 2;
    }
  }


  println(analog(0));
}

void mouseClicked() {
  if (main_screen != 0 && quiz_screen == 0 && mouseButton == LEFT) {//Question Screen Transision
    quiz_screen = 1;
  }

  if (main_screen != 0 && quiz_screen == 1 && mouseButton == RIGHT) {//change Question Screen to Main Screen
    main_screen = 0;
    quiz_screen = 0;
  }
}


/*
void mousePressed()
 {
 int pin = (450 - mouseX) / 30;
 
 // Toggle the pin corresponding to the clicked square.
 if (values[pin] == Arduino.LOW) {
 arduino.digitalWrite(pin, Arduino.HIGH);
 values[pin] = Arduino.HIGH;
 } else {
 arduino.digitalWrite(pin, Arduino.LOW);
 values[pin] = Arduino.LOW;
 }
 }
 */
