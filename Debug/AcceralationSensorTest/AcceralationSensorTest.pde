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
final int offset = 100;

int x,y,z;
int offset_x,offset_y,offset_z;

void setup()
{
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54747"); 
}

void draw()
{
  x = arduino.analogRead(X);
  z = arduino.analogRead(Z);
  
  offset_x = abs(x - normal_x) > offset? x-normal_x : 0;
  offset_z = abs(z - normal_z) > offset? z-normal_z : 0;
  
  if(offset_x > 0)print("right");
  else if(offset_x < 0)print("left");
  else if(offset_x == 0 && offset_z > 0)print("forward");
  else if(offset_x == 0 && offset_z < 0)print("back");
  else print("normal");
  
  println("");
}