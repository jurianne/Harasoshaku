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

void setup()
{
  size(500, 500);
  arduino = new Arduino(this, "/dev/cu.usbmodem1411");

  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9000);
}

void draw()
{
  x = arduino.analogRead(3);
  y = arduino.analogRead(4);
  z = arduino.analogRead(5);

  println("x=" + x, "y="+ y, "z="+ z);

  if (z < 400) { sosyaku(); }
  else { off(); }
}

void sosyaku()
{
  playSound();
  forward((int)random(150,255));

  delay((int)random(400,600));

  back((int)random(150,255));

  delay((int)random(100,300));
}

void forward(int power)
{
  arduino.digitalWrite(AIN1, Arduino.HIGH);
  arduino.digitalWrite(AIN2, Arduino.LOW);
  arduino.analogWrite(PWMA, power);
}

void back(int power)
{
  arduino.digitalWrite(AIN1, Arduino.LOW);
  arduino.digitalWrite(AIN2, Arduino.HIGH);
  arduino.analogWrite(PWMA, power);
}

void off()
{
  arduino.digitalWrite(AIN1, Arduino.LOW);
  arduino.digitalWrite(AIN2, Arduino.LOW);
}

void playSound()
{
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add("hello pd");
  osc.send(myMessage, myRemoteLocation);
}

void keyPressed()
{
  if (key == 'a')
  {
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add("hello pd");
    osc.send(myMessage, myRemoteLocation);
  }
}