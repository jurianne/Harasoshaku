import netP5.*;
import oscP5.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

final static int NON = 0;
final static int SENBEI = 1;
final static int NIKU = 2;

final static int POS_NORMAL = 0;
final static int POS_FORWARD = 1;
final static int POS_RIGHT = 2;
final static int POS_LEFT = 3;
final static int POS_BACK = 4;

//shodo
final int SENSOR_VALUE_ISEATING = 750;
final int SENSOR_VALUE_SENBEI = 980;
final int SENSOR_VALUE_NIKU = 1000;

final int normal_x = 520;
final int normal_y = 270;
final int normal_z = 520;
final int offset = 100;

int offset_x,offset_y,offset_z;

//Arduino1
final int EATSENSOR = 2;
final int X = 7;
final int Y = 6;
final int Z = 5;
final static int AIN1 = 11;
final static int AIN2 = 10;
final static int PWMA = 9;

//Arduino2
final int SENBEI_SENSOR = 0;
final int NIKU_SENSOR = 1;

int TABEMONO = 0;

Senbei senbei;
Niku niku;

Arduino arduino;
Arduino arduino2;
OscP5 osc;
NetAddress myRemoteLocation;
HardwareController hard;

int x, y, z;
float volume;
int power;
int senbeiVal, nikuVal;
boolean isEating = false;
boolean isSwallow = false;
boolean wasSoshaku = false;//soshaku shitaka douka

void setup()
{
  size(500, 500);

  arduino = new Arduino(this, "/dev/cu.usbserial-14P54747");
  //arduino2 for sensor
  arduino2 = new Arduino(this, "/dev/cu.usbmodem1421");
  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9700);
  hard = new HardwareController(arduino,osc,myRemoteLocation);

  senbei = new Senbei(hard);
  niku = new Niku(hard);
}

void draw()
{
  if (isEating())
  {
    isEating = true;
    
    switch(whichPos())
    {
      case POS_FORWARD:
        sosyaku(1,255,POS_FORWARD);
        wasSoshaku = true;
        break;
      case POS_RIGHT:
        sosyaku(1,255,POS_RIGHT);
        wasSoshaku = true;
        break;
      case POS_LEFT:
        sosyaku(1,255,POS_LEFT);
        wasSoshaku = true;
        break;
      case POS_BACK:
        gokuri();
        break;
      case POS_NORMAL:
        break;
      default:
        break;
    }
  } else {
    isEating = false;
  }
  println("x=" + x, "y="+ y, "z="+ z, "EatVal=" + arduino.analogRead(EATSENSOR), "isEating=" + isEating, "Tabemono=" + whichTabemono(), "isSwallow=" + isSwallow, 
  "volume=" + volume, "power=" + power);
}

boolean isEating()
{
  if (isSwallow == false && isEating == false && (arduino.analogRead(EATSENSOR) > SENSOR_VALUE_ISEATING))
  {
    pakuri();
    wasSoshaku = false;
  } else if (arduino.analogRead(EATSENSOR) < SENSOR_VALUE_ISEATING) {
    isSwallow = false;
  }

  if (!isSwallow)
  {
    return arduino.analogRead(EATSENSOR) > SENSOR_VALUE_ISEATING;
  } else {
    return false;
  }
}

int whichTabemono()//akarusa sensing
{
  senbeiVal = arduino2.analogRead(SENBEI_SENSOR);
  nikuVal = arduino2.analogRead(NIKU_SENSOR);

  if (SENSOR_VALUE_SENBEI - senbeiVal >= 80) return SENBEI;
  else if (SENSOR_VALUE_NIKU - nikuVal >= 80) return NIKU;
  return NON;
}

void sosyaku(float volume,int power,int pos)
{
  switch(whichTabemono())
    //switch(TABEMONO)
  {
  case NON:
    senbei.init();
    niku.init();
    break;
  case SENBEI:
    senbei.sosyaku(volume,power,pos);
    background(255, 0, 0);
    break;
  case NIKU:
    niku.sosyaku(volume,power,pos);
    background(0, 0, 255);
    break;
  default:
    println("[sosyaku]error");
    break;
  }
}

void pakuri()
{
  hard.playSounds("/paku",1,POS_FORWARD);
  hard.forward(255,300);
  hard.off(10);
}

void gokuri()
{
  if (!isSwallow)
  {
    hard.forward(255,400);
    hard.playSounds("/gokuri",1,POS_FORWARD);
    isSwallow = true;
    hard.back(255,400);
    hard.off(10);
  }
}

int whichPos()
{
  x = arduino.analogRead(X);
  z = arduino.analogRead(Z);
  
  offset_x = abs(x - normal_x) > offset? x-normal_x : 0;
  offset_z = abs(z - normal_z) > offset? z-normal_z : 0;
  
  if(offset_x > 0)return POS_RIGHT;
  else if(offset_x < 0)return POS_LEFT;
  else if(offset_x == 0 && offset_z > 0)return POS_FORWARD;
  else if(offset_x == 0 && offset_z < 0)return POS_BACK;
  return POS_NORMAL;
}
void keyPressed()
{
}