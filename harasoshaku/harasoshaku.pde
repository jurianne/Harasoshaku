import netP5.*;
import oscP5.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

final static int NON = 0;
final static int SENBEI = 1;
final static int NIKU = 2;
final static int Pachipachi = 3;

final static int POS_NORMAL = 0;
final static int POS_FORWARD = 1;
final static int POS_RIGHT = 2;
final static int POS_LEFT = 3;
final static int POS_BACK = 4;

final int SENSOR_VALUE_ISEATING = 10;

final int normal_x = 520;
final int normal_y = 270;
final int normal_z = 520;
final int offset = 100;

int offset_x, offset_y, offset_z;

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
final int PACHIPACHI_SENSOR = 2;

int TABEMONO = 0;

Senbei senbei;
Niku niku;
Pachipachi pachipachi;

Arduino arduino;
Arduino arduino2;
OscP5 osc;
NetAddress myRemoteLocation;
HardwareController hard;

int x, y, z;
float volume;
int power;
int senbeiVal, nikuVal, pachipachiVal;
boolean isEating = false;
boolean isSwallow = false;
boolean wasSoshaku = false;//soshaku shitaka douka

Tabemono cTabemono;
ArrayList<Tabemono> table = new ArrayList<Tabemono>();

void setup()
{
  size(500, 500);

  arduino = new Arduino(this, "/dev/cu.usbserial-14P54747");
  arduino2 = new Arduino(this, "/dev/cu.usbmodem1421");
  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9700);
  hard = new HardwareController(arduino, osc, myRemoteLocation);

  senbei = new Senbei(hard);
  niku = new Niku(hard);
  pachipachi = new Pachipachi(hard);
  table.add(senbei);
  table.add(niku);
  table.add(pachipachi);
}

void draw()
{
  if (isEating())
  {
    if (cTabemono != null)cTabemono.sosyaku(1, 255, whichPos());
    else println("cTabemono is null");
  }
}

void swallow()
{
  cTabemono = null;
}
int whichPos()
{
  x = arduino.analogRead(X);
  z = arduino.analogRead(Z);

  offset_x = abs(x - normal_x) > offset? x-normal_x : 0;
  offset_z = abs(z - normal_z) > offset? z-normal_z : 0;

  if (offset_x > 0)return POS_RIGHT;
  else if (offset_x < 0)return POS_LEFT;
  else if (offset_x == 0 && offset_z > 0)return POS_FORWARD;
  else if (offset_x == 0 && offset_z < 0)return POS_BACK;
  return POS_NORMAL;
}
boolean isEating()
{
  if (cTabemono == null && arduino.analogRead(EATSENSOR) > SENSOR_VALUE_ISEATING)
  {
    pakuri();
    for (Tabemono tabemono : table)
    {
      cTabemono = tabemono.isOntheTable(arduino2) ? null : tabemono;
    }
    if (cTabemono != null)
    {
      table.remove(cTabemono);
      return true;
    } else {
      return false;
    }
  }else{
    return false;
  }
}
void pakuri()
{
  hard.playSounds("/paku", 1, POS_FORWARD);
  hard.forward(255, 300);
  hard.off(10);
}