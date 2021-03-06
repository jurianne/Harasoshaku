import netP5.*;
import oscP5.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

final static int NON = 0;
final static int SENBEI = 1;
final static int NIKU = 2;

///////shikiichi
//kasokudo
int SENSOR_VALUE_NORMAL = 650;
int SENSOR_VALUE_BACK = 610;
int SENSOR_VALUE_FORWARD = 690;
int SENSOR_VALUE_FORWARD_MAX = 720;
//shodo
final int SENSOR_VALUE_ISEATING = 750;
final int SENSOR_VALUE_SENBEI = 980;
final int SENSOR_VALUE_NIKU = 1000;

//Arduino1
final int EATSENSOR = 2;
final int X = 3;
final int Y = 4;
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

float x, y, z;
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

  senbei = new Senbei(arduino, osc, myRemoteLocation);
  niku = new Niku(arduino, osc, myRemoteLocation);
}

void draw()
{
  x = arduino.analogRead(X);
  y = arduino.analogRead(Y);
  z = arduino.analogRead(Z);
  if (isEating())
  {
    isEating = true;

    if (z > SENSOR_VALUE_FORWARD)
    { 
      //volume = SENSOR_VALUE_FORWARD_MAX < x ? 1 : (x - SENSOR_VALUE_FORWARD) / (SENSOR_VALUE_FORWARD_MAX - SENSOR_VALUE_FORWARD);
      volume = SENSOR_VALUE_FORWARD_MAX < z ? 1 : map(z - SENSOR_VALUE_FORWARD,0,SENSOR_VALUE_FORWARD_MAX - SENSOR_VALUE_FORWARD,0.6,1);
      power = (int)map(volume,0,1,190,255);
      sosyaku(volume,power);
      wasSoshaku = true;
    } else if ( z < SENSOR_VALUE_BACK && wasSoshaku) {
      gokuri();
    }
  } else {
    isEating = false;
  }
  println("x=" + x, "y="+ y, "z="+ z, "EatVal=" + arduino.analogRead(EATSENSOR), "isEating=" + isEating, "Tabemono=" + whichTabemono(), "isSwallow=" + isSwallow, 
  "volume=" + volume, "power=" + power, "VALUE_NORMAL=" + SENSOR_VALUE_NORMAL, "VALUE_FORWARD=" + SENSOR_VALUE_FORWARD, "VALUE_FORWARD_MAX=" + SENSOR_VALUE_FORWARD_MAX,
  "VALUE_BACK=" + SENSOR_VALUE_BACK);
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

void sosyaku(float volume,int power)
{
  switch(whichTabemono())
    //switch(TABEMONO)
  {
  case NON:
    senbei.init();
    niku.init();
    break;
  case SENBEI:
    senbei.sosyaku(volume,power);
    background(255, 0, 0);
    break;
  case NIKU:
    niku.sosyaku(volume,power);
    background(0, 0, 255);
    break;
  default:
    println("[sosyaku]error");
    break;
  }
}

void pakuri()
{
  OscMessage myMessage = new OscMessage("/paku");
  osc.send(myMessage, myRemoteLocation);
  forward(255,300);
  off(10);
}

void gokuri()
{
  if (!isSwallow)
  {
    forward(255,400);
    OscMessage myMessage = new OscMessage("/gokuri");
    osc.send(myMessage, myRemoteLocation);
    isSwallow = true;
    back(255,400);
    off(10);
  }
}

void forward(int power, int delay)
{
  arduino.digitalWrite(AIN1, Arduino.HIGH);
  arduino.digitalWrite(AIN2, Arduino.LOW);
  arduino.analogWrite(PWMA, power);
  delay(delay);
}
void back(int power, int delay)
{
  arduino.digitalWrite(AIN1, Arduino.LOW);
  arduino.digitalWrite(AIN2, Arduino.HIGH);
  arduino.analogWrite(PWMA, power);
  delay(delay);
}
void off(int delay)
{
  arduino.digitalWrite(AIN1, Arduino.LOW);
  arduino.digitalWrite(AIN2, Arduino.LOW);
  delay(delay);
}
void keyPressed()
{
  //if (key == 's')
  //{
  //  TABEMONO = SENBEI;
  //  background(255, 0, 0);
  //} else if (key == 'n')
  //{
  //  TABEMONO = NIKU;
  //  background(0, 0, 255);
  //} else {
  //  TABEMONO = NON;
  //  background(0, 0, 0);
  //}
  if (key == 'c')//起立状態でC押すと、加速度センサーがキャリブレーションされる
  {
    background(0, 0, 0);
    SENSOR_VALUE_NORMAL = arduino.analogRead(Z);
    SENSOR_VALUE_BACK = SENSOR_VALUE_NORMAL - 40;
    SENSOR_VALUE_FORWARD = SENSOR_VALUE_NORMAL + 40;
    SENSOR_VALUE_FORWARD_MAX = SENSOR_VALUE_NORMAL + 70;
  }
  if (key == 'r')//加速度センサーの値が規定値に戻る
  {
    background(0, 0, 0);
    SENSOR_VALUE_NORMAL = 650;
    SENSOR_VALUE_BACK = SENSOR_VALUE_NORMAL - 40;
    SENSOR_VALUE_FORWARD = SENSOR_VALUE_NORMAL + 40;
    SENSOR_VALUE_FORWARD_MAX = SENSOR_VALUE_NORMAL +70;
  }
}