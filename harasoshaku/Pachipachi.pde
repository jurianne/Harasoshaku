class Pachipachi extends Edible
{
  private final String SOUND_PACHIPACHI_OTHER = "/pother";
  private final String SOUND_PACHIPACHI_START = "/pstart";
  private final String SOUND_PACHIPACHI_FINISH = "/pfinish";
  
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
        hard.playSounds(SOUND_PACHIPACHI_FINISH,1,0,count);
        swallow();
      } else {
        other(volume, power, pos, count);
        count ++;
      }
    }
  }
  public void startEating()
  {
    hard.playSounds(SOUND_PACHIPACHI_START,1,0,count);
  }
  public boolean isOntheTable(Arduino ard)
  {
    return SENSOR_VALUE_PACHIPACHI - ard.analogRead(PACHIPACHI_SENSOR) <= SENSOR_VALUE_PLATE_OFFSET;
  }
  private void other(float volume,int power, int pos,int count)
  {
    hard.playSounds(SOUND_PACHIPACHI_OTHER,volume,pos,count);
    hard.forward(power,400);
    hard.back(power,300);
    hard.off(100);
  }
}