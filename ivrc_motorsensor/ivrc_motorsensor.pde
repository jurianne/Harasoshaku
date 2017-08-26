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
Minim minim;
AudioPlayer mogu;
//AudioSnippet mogus;
//Arduino arduino_2;

float x, y, z;

int AIN1 = 13;
int AIN2 = 12;
int PWMA = 11;

boolean state = false;

//value = 255;

void setup() {
  size(500, 500);
  //arduino = new Arduino(this, "/dev/cu.usbmodem1411");
  arduino = new Arduino(this, "/dev/cu.usbmodem1421");
  minim = new Minim(this);
  
  
  mogu = minim.loadFile("sosyaku_big.mp3");
  //mogu[1] = minim.loadSnippet("sosyaku_small.mp3");
}


void draw() {
  x = y = z = 0;
  x = arduino.analogRead(3);
  y = arduino.analogRead(4);
  z = arduino.analogRead(5);

  println("x=" + x, "y="+ y, "z="+ z);
  delay(50);
  
  
  //強さをこちらで指定したver
   if (z < 400 && state == false) {
     //int random = int(random(0,1));
      mogu.play();
      mogu.rewind();
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
      //delay(500);
      state = false;
    }
  
  
  
  
  //for文使ったバージョン
  /*
  for (int i=255; i>0; i-=20) {
    if (z < 400 && state == false) {
      
      arduino.digitalWrite(AIN1, Arduino.HIGH);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      arduino.analogWrite(PWMA, i);
      delay(500);

      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.HIGH);
      arduino.analogWrite(PWMA, i);
      delay(500);

      state = true;
    } else {
      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      //delay(500);
      state = false;
    }
    println(i);
  }
  */
}