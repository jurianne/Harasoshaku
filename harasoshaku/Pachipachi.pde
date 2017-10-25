class Pachipachi extends Tabemono
{
  private final String SOUND_PACHIPACHI_OTHER = "/pother";
  private final String SOUND_PACHIPACHI_START = "/pstart";
  private final String SOUND_PACHIPACHI_FINISH = "/pfinish";
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
        hard.playSounds(SOUND_PACHIPACHI_FINISH,1,0);
        swallow();
        isSwallow = true;
      } else {
        other(volume, power, pos);
      }
    }
  }
  public void startEating()
  {
    hard.playSounds(SOUND_PACHIPACHI_START,1,0);
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