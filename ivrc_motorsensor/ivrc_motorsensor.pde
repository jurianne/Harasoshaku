import netP5.*;
import oscP5.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

Arduino arduino;
OscP5 osc;
NetAddress myRemoteLocation;

float x, y, z;
int AIN1 = 13;
int AIN2 = 12;
int PWMA = 11;
boolean state = false;

void setup() {
  size(500, 500);
  arduino = new Arduino(this, "/dev/cu.usbmodem1411");
  
  osc = new OscP5(this,1234);
  myRemoteLocation = new NetAddress("127.0.0.1",9000);
}


void draw() {
  x = arduino.analogRead(3);
  y = arduino.analogRead(4);
  z = arduino.analogRead(5);

  println("x=" + x, "y="+ y, "z="+ z);
  delay(50);
  
   if (z < 400 && state == false) {
      arduino.digitalWrite(AIN1, Arduino.HIGH);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      arduino.analogWrite(PWMA, 255);
      delay(500);

      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.HIGH);
      arduino.analogWrite(PWMA, 255);
      delay(500);

      state = true;
    } else {
      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      state = false;
    }
}

void keyPressed()
{
  if(key == 'a')
  {
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add("hello pd");
    osc.send(myMessage,myRemoteLocation);
  }
}