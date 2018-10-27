//Procesing side 
//This Program shows quiz in monitor.
import processing.serial.*;//This libraly enable Processing to read Arduino.

//Instance of Serial class.
Serial my_port;
//Input Data by Serial Port (Byte)
int in_byte;
 
void setup()
{
    size(640, 640);
    //The first port in the Mac serial list is the port of the FTDI adapter
    String port_name = Serial.list()[0];
    //Set the port and speed, initialize the Serial class
    my_port = new Serial(this, port_name, 9600);
}
 
void draw()
{
    //Set the value obtained from the serial to the background color
    background(in_byte);
}
 
void serialEvent(Serial p){
    //Read data from the set serial port
    in_byte = my_port.read();
}
