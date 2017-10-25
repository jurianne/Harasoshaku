import netP5.*;
import oscP5.*;

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

final static int MODE_DEBUG = 1029;
final static int MODE_PRODUCT = 1028;

final static int NON = 0;
final static int SENBEI = 1;
final static int NIKU = 2;
final static int PACHIPACHI = 3;

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

Edible cTabemono;
ArrayList<Edible> table;
int mode = 99;// 

int dish_senbei = 9999, dish_niku = 9999, dish_pachipachi = 9999;
int mouse = 9999;
int Tabemono = 9999;
int acceleration = 9999;

void setup()
{
  size(500, 500);
  background(0);
}

void draw()
{
  if (mode == MODE_DEBUG)draw_debug();
  else if (mode == MODE_PRODUCT)draw_product();
  draw_display();
}

void draw_debug()
{
}

void draw_product()
{
  isEating();//call first
  if (cTabemono != null)
  {
    cTabemono.sosyaku(1, 255, whichPos());
  }
}

void draw_display()
{
  background(0);
  fill(255);
  text("dish_senbei = "+dish_senbei+"\ndish_niku = "+dish_niku+"\ndish_pachipachi = "+dish_pachipachi, 10, 10);
  text("mouse = "+mouse, 10, 60);
  if (cTabemono != null)text("cTabemono = "+cTabemono.getClass().getName(), 10, 75);
  else text("cTabemono = null", 10, 75);
  text("acceleration= "+acceleration, 10, 90);
  if (mode == MODE_DEBUG)text("mode = debug", 10, 105);
  else if (mode == MODE_PRODUCT)text("mode = product", 10, 105);
  else text("mode = null", 10, 105);
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
    cTabemono.startEating();
    pakuri();
    for (Edible tabemono : table)
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
  } else {
    return false;
  }
}

void pakuri()
{
  hard.playSounds("/paku", 1, POS_FORWARD);
  hard.forward(255, 300);
  hard.off(10);
}

void init_product()
{
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54747");
  arduino2 = new Arduino(this, "/dev/cu.usbmodem1421");
  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9900);
  hard = new HardwareController(arduino, osc, myRemoteLocation);

  table = new ArrayList<Edible>();
  senbei = new Senbei(hard);
  niku = new Niku(hard);
  pachipachi = new Pachipachi(hard);
  table.add(senbei);
  table.add(niku);
  table.add(pachipachi);
}

void init_debug()
{
  osc = new OscP5(this, 1234);
  myRemoteLocation = new NetAddress("127.0.0.1", 9900);
  hard = new HardwareController(arduino, osc, myRemoteLocation);

  table = new ArrayList<Edible>();
  senbei = new Senbei(hard);
  niku = new Niku(hard);
  pachipachi = new Pachipachi(hard);
  table.add(senbei);
  table.add(niku);
  table.add(pachipachi);
}

void keyPressed()
{
  if (key == 'd')
  {
    mode = MODE_DEBUG;
    init_debug();
    println("debug mode");
  }
  if (key == 'p')
  {
    mode = MODE_PRODUCT;
    init_product();
    println("product mode");
  }
  if (mode == MODE_DEBUG)
  {
    if (key == 'q')
    {
      cTabemono = new Senbei(hard);
    }
    if (key == 'w')
    {
      cTabemono = new Niku(hard);
    }
    if (key == 'e')
    {
      cTabemono = new Pachipachi(hard);
    }
    if (key == 'n')
    {
      cTabemono = null;
    }
    if (cTabemono != null)
    {
      if (key == 'a')
      {
        cTabemono.sosyaku(1, 255, POS_LEFT);
        cTabemono.startEating();
      }
      if (key == 's')
      {
        cTabemono.sosyaku(1, 255, POS_BACK);
      }
    }
  }
}