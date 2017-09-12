class Tabemono
{
  Arduino arduino;
  OscP5 osc;
  NetAddress myRemoteLocation;
  
  Tabemono(Arduino _ard,OscP5 _osc,NetAddress _netAddress)
  {
    arduino = _ard;
    osc = _osc;
    myRemoteLocation = _netAddress;
  }
  protected void setup(Arduino ard)
  {
    arduino = ard;
  }
  protected void forward(int power, int delay)
  {
    arduino.digitalWrite(AIN1, Arduino.HIGH);
    arduino.digitalWrite(AIN2, Arduino.LOW);
    arduino.analogWrite(PWMA, power);
    delay(delay);
  }

  protected void back(int power, int delay)
  {
    arduino.digitalWrite(AIN1, Arduino.LOW);
    arduino.digitalWrite(AIN2, Arduino.HIGH);
    arduino.analogWrite(PWMA, power);
    delay(delay);
  }

  protected void off(int delay)
  {
    arduino.digitalWrite(AIN1, Arduino.LOW);
    arduino.digitalWrite(AIN2, Arduino.LOW);
    delay(delay);
  }

  protected void playSounds(String sound,float power)
  {
    OscMessage myMessage = new OscMessage(sound);
    myMessage.add(power);
    osc.send(myMessage, myRemoteLocation);
  }
}