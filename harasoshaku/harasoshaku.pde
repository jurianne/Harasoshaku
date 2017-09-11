import netP5.*;
import oscP5.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

final static int NON = 0;
final static int SENBEI = 1;
final static int RINGO = 2;
final static int NIKU = 3;

final static int AIN1 = 13;
final static int AIN2 = 12;
final static int PWMA = 11;

final int TABEMONOSENSOR = 0;
final int X = 3;
final int Y = 4;
final int Z = 5;

Senbei senbei;
Ringo ringo;
Niku niku;

Arduino arduino;
OscP5 osc;
NetAddress myRemoteLocation;

float x, y, z;

void setup()
{
  size(500, 500);
  
  arduino = new Arduino(this, "/dev/cu.usbmodem1411");
  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9000);
  
  senbei = new Senbei(arduino,osc,myRemoteLocation);
  ringo = new Ringo(arduino,osc,myRemoteLocation);
  niku = new Niku(arduino,osc,myRemoteLocation);
}

void draw()
{
  x = arduino.analogRead(X);
  y = arduino.analogRead(Y);
  z = arduino.analogRead(Z);

  println("x=" + x, "y="+ y, "z="+ z);

  if (z < 400) { sosyaku(); }
}


int whichTabemono()//akarusa sensing
{
  return NON;
}

void sosyaku()
{
  switch(whichTabemono())
  {
    case NON:
      senbei.init();
      ringo.init();
      niku.init();
      break;
    case SENBEI:
      senbei.sosyaku();
      break;
    case RINGO:
      ringo.sosyaku();
      break;
    case NIKU:
      niku.sosyaku();
      break;
    default:
      println("[sosyaku]error");
      break;
  }
}