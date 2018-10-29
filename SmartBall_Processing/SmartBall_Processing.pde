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
int language = 0;


PImage[][] quiz;//Quiz Image 
PImage[][] answer;//Answer Image

int main_screen = 0;//variable for MainScreen transition.
int question_screen = 0;//variable for MainScreen transition.

//Functions

int Analog(int pin) {//Analog Pin
  int analog_value;//read by analog pin
  analog_value = arduino.analogRead(pin);
  return analog_value;
}

void Button(int x, int y, String alphabet, int lang) {//Button to change language
  if (mouseX > x && mouseX <= x + 100 && mouseY > y && mouseY <= y + 100) {
    fill(0, 255, 0);
    rect(x, y, 100, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 20);
  } else {
    fill(255);
    rect(x, y, 100, 100);
    fill(0);
    textSize(20);
    text(alphabet, x + 10, y + 20);
  }

  if (mouseX > x && mouseX <= x + 100 && mouseY > y && mouseY <= y + 100 && mousePressed) {
    language = lang;
  }
}

void Question(int number, int country) {//Question Screen
  switch(question_screen) {
  case 0:
    image(quiz[number][country], 0, 0, width, height);//Show Quiz   
    break;
  case 1:
    background(255);
    image(answer[number][country], -30, 0, width, height / 2 + 200);//Show Answer
    break;
  }
}



void setup() {
  quiz = new PImage[8][4];//Image Initialize
  answer = new PImage[8][4];

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

  quiz[0][0] = loadImage("Q1_j.jpg");
  answer[0][0] = loadImage("A1_j.jpg");
}

void draw() {

  if (start_count < 130) { 
    start_count++;
  }

  switch(main_screen) {//Screen
  case 0://Start
    background(255);
    stroke(0);
    text(language, 100, 100);
    Button(200, 200,"fuck", 3);
    break;
  case 1://Question1,Answer1
    Question(0, 0);
    break;
  }

  if (start_count > 120) {//for Screen transition.
    if (Analog(0) < light_value) {
      main_screen = 1;
    }
  }


  println(Analog(0));
}

void mouseReleased() {
  if (main_screen != 0 && question_screen == 0 && mouseButton == LEFT) {//Question Screen Transision
    question_screen = 1;
  }

  if (main_screen != 0 && question_screen == 1 && mouseButton == RIGHT) {//change Question Screen to Main Screen
    main_screen = 0;
    question_screen = 0;
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
