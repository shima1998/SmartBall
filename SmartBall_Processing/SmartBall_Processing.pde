//Procesing side 
//This Program shows quiz in monitor.
//Need Library Firmata
//I start from 181028. 

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


void setup() {
  //size(470, 200);
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

  // Set the Arduino digital pins as outputs.


  for (int i = 0; i <= 13; i++) {
    arduino.pinMode(i, Arduino.INPUT);
  }//INPUT pin


  //arduino.pinMode(2, Arduino.INPUT);
}

void draw() {
  background(off);
  stroke(on);

  //Photo Transisitor's on and off. 

  if (arduino.digitalRead(2) == 1) {
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
}

/*for (int i = 0; i <= 13; i++) {
 if (values[i] == Arduino.HIGH)
 fill(on);
 else
 fill(off);
 
 rect(420 - i * 30, 30, 20, 20);
 }*/
//}


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

/*Reference: 
 https://teratail.com/questions/12299
 http://kousaku-kousaku.blogspot.com/2008/10/arduino.html
 http://d.hatena.ne.jp/afeq/20110211/1297407108
 */
