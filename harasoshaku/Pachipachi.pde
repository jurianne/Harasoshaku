class Pachipachi extends Tabemono
{
  private final String SOUND_PACHIPACHI_OTHER = "/pother";
  final int SENSOR_VALUE_PACHIPACHI = 1000;
  final int PACHIPACHI_SENSOR = 2;
  
  Pachipachi(HardwareController _hard)
  {
    super(_hard);
  }
  public void sosyaku(float volume,int power, int pos)
  {
    if (isSwallow == false)
    {
      if (pos == POS_NORMAL)return;
      if (pos == POS_BACK)
      {
        gokuri();
        swallow();
        isSwallow = true;
      } else {
        other(volume, power, pos);
      }
    }
  }
  public boolean isOntheTable(Arduino ard)
  {
    return SENSOR_VALUE_PACHIPACHI - ard.analogRead(PACHIPACHI_SENSOR) >= 80;
  }
  private void other(float volume,int power, int pos)
  {
    hard.playSounds(SOUND_PACHIPACHI_OTHER,volume,pos);
    hard.forward(power,400);
    hard.back(power,300);
    hard.off(100);
  }
}