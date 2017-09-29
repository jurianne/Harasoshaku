import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

Arduino arduino;

final int X = 7;
final int Y = 6;
final int Z = 5;

final int normal_x = 520;
final int normal_y = 270;
final int normal_z = 520;
final int offset = 30;

int x,y,z;
int offset_x,offset_y,offset_z;

void setup()
{
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54747"); 
}

void draw()
{
  x = arduino.analogRead(X);
  y = arduino.analogRead(Y);
  z = arduino.analogRead(Z);
  
  offset_x = abs(normal_x - x) > offset? normal_x-x : 0;
  offset_y = abs(normal_y - y) > offset? normal_y-y : 0;
  offset_z = abs(normal_z - z) > offset? normal_z-z : 0;
  
  if(offset_x > 0)print("right");
  if(offset_x < 0)print("left");
  if(offset_x == 0 && offset_z > 0)print("forward");
  if(offset_x == 0 && offset_z < 0)print("back");
  
  println(x,y,z);
}