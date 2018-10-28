//Arduino side
//This Program sends value of phot transistor.


int Analog0;//Analog Pin 0 of Aruduino
int out_byte;//Value that Serial output.

void setup() {
  //To start Serial communicate.
  Serial.begin(9600);
}

void loop() {
  //to read value of AnalogPin0 (0~1023)
  Analog0 = analogRead(0);
  //Change the value in the range from 0 to 255
  out_byte = map(Analog0, 0, 1023, 0, 255);
  //Send out_byte in serial（BYTE Format）
  Serial.print(out_byte);
  //Loop 10 times per second
  delay(100);
}
