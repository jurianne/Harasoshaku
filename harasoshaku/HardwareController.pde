class HardwareController
{
  Arduino arduino;
  OscP5 osc;
  NetAddress myRemoteLocation;

  HardwareController(Arduino _arduino, OscP5 _osc, NetAddress _netAddress)
  {
    arduino = _arduino;
    osc = _osc;
    myRemoteLocation = _netAddress;
  }
  void forward(int power, int delay)
  {
    //if (mode == MODE_PRODUCT)
    {
      arduino.digitalWrite(AIN1, Arduino.HIGH);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      arduino.analogWrite(PWMA, power);
      delay(delay);
    }
  }

  void back(int power, int delay)
  {
    //if (mode == MODE_PRODUCT)
    {
      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.HIGH);
      arduino.analogWrite(PWMA, power);
      delay(delay);
    }
  }

  void off(int delay)
  {
    //if (mode == MODE_PRODUCT)
    {
      arduino.digitalWrite(AIN1, Arduino.LOW);
      arduino.digitalWrite(AIN2, Arduino.LOW);
      delay(delay);
    }
  }

  void playSounds(String sound, float volume, int pos, int count)
  {
    OscMessage myMessage = new OscMessage(sound);
    myMessage.add(volume);
    myMessage.add(pos);
    myMessage.add(count);
    osc.send(myMessage, myRemoteLocation);
  }
}