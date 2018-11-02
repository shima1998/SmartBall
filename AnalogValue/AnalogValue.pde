
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

int analog(int pin) {//Analog Pin
  int analog_value;//read by analog pin
  analog_value = arduino.analogRead(pin);
  return analog_value;
}

void setup() {
  // Prints out the available serial ports.
  println(Arduino.list());
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);
}

void draw() {
  for (int i = 0; i < 8; i++) {
    println("pin" + i +  ":" + analog(i));
  }
}
