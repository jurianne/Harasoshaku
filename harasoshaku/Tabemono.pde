class Tabemono
{
  Arduino arduino;
  protected void setup(Arduino ard)
  {
    arduino = ard;
  }
  protected void forward(int power)
  {
    arduino.digitalWrite(AIN1, Arduino.HIGH);
    arduino.digitalWrite(AIN2, Arduino.LOW);
    arduino.analogWrite(PWMA, power);
  }

  protected void back(int power)
  {
    arduino.digitalWrite(AIN1, Arduino.LOW);
    arduino.digitalWrite(AIN2, Arduino.HIGH);
    arduino.analogWrite(PWMA, power);
  }

  protected void off()
  {
    arduino.digitalWrite(AIN1, Arduino.LOW);
    arduino.digitalWrite(AIN2, Arduino.LOW);
  }
}