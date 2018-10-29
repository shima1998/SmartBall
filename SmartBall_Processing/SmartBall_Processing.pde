//Procesing side 
//This Program shows quiz in monitor.
//Need Library Firmata
//I start from 181028. 

/*Reference: 
 https://teratail.com/questions/12299
 http://kousaku-kousaku.blogspot.com/2008/10/arduino.html
 http://d.hatena.ne.jp/afeq/20110211/1297407108
 https://yoppa.org/tau_bmaw13/4772.html
 http://piyopiyocs.blog115.fc2.com/blog-entry-1125.html
 https://yoppa.org/geidai_media1_17/8243.html
 */

/*
arduino_output
 
 Demonstrates the control of digital pins of an Arduino board running the
 StandardFirmata firmware.  Clicking the squares toggles the corresponding
 digital pin of the Arduino.  
 
 To use:
 * Using the Arduino software, upload the StandardFirmata example (located
 in Examples > Firmata > StandardFirmata) to your Arduino board.
 * Run this sketch and look at the list of serial ports printed in the
 message area below. Note the index of the port corresponding to your
 Arduino board (the numbering starts at 0).  (Unless your Arduino board
 happens to be at index 0 in the list, the sketch probably won't work.
 Stop it and proceed with the instructions.)
 * Modify the "arduino = new Arduino(...)" line below, changing the number
 in Arduino.list()[0] to the number corresponding to the serial port of
 your Arduino board.  Alternatively, you can replace Arduino.list()[0]
 with the name of the serial port, in double quotes, e.g. "COM5" on Windows
 or "/dev/tty.usbmodem621" on Mac.
 * Run this sketch and click the squares to toggle the corresponding pin
 HIGH (5 volts) and LOW (0 volts).  (The leftmost square corresponds to pin
 13, as if the Arduino board were held with the logo upright.)
 
 For more information, see: http://playground.arduino.cc/Interfacing/Processing
 */

import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

color off = color(4, 79, 111);
color on = color(84, 145, 158);

int[] values_input;

int light_value = 600;//switch

PImage quiz[][];//Quiz Image 
PImage[][] answer;//Answer Image

int screen = 0;

int Analog(int pin) {
  int analog_value;
  analog_value = arduino.analogRead(pin);
  return analog_value;
}//Analog Pin

void Button(int x, int y, String alphabet) {
  fill(255);
  rect(x, y, 100, 100);
  fill(0);
  textSize(20);
  text(alphabet, x + 10, y + 20);
}

void Question(int number, int country) {
  image(quiz[number][country], 0, 0, width, height);
}




void setup() {
  quiz = new PImage[8][4];
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

  quiz[0][0] = loadImage("Q1.jpg");
}

void draw() {


  switch(screen) {
  case 0:
    background(off);
    stroke(on);
    break;
  case 1:
    Question(0, 0);
    break;
  }

  if (Analog(0) < light_value) {
    screen = 1;
  } else {
    screen = 0;
  }

  println(Analog(0));

  //Photo Transisitor's on and off. 
  /*
  if (arduino.digitalRead(2) == 0) {
   // arduino.digitalWrite(9, Arduino.HIGH);
   println("HIGH");
   //values[pin] = Arduino.HIGH;
   rect(100,100,100,100);
   text("Happy",100,100);
   } else {
   // arduino.digitalWrite(9, Arduino.LOW);
   println("LOW");
   //values[pin] = Arduino.LOW;
   }
   */
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
