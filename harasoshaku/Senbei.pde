class Senbei extends Edible
{
  private final String SOUND_SENBEI_OTHER = "/sother";
  
  Senbei(HardwareController _hard)
  {
    super(_hard);
  }
  
  public void sosyaku(float volume, int power, int pos)
  {
    if (isSwallow == false)
    {
      if (pos == POS_NORMAL)return;
      if (pos == POS_BACK)
      {
        gokuri();
        swallow();
      } else {
        other(volume, power, pos, count);
        count++;
      }
    }
  }
  public void startEating()
  {
  }
  public boolean isOntheTable(Arduino ard)
  {
    return SENSOR_VALUE_SENBEI - ard.analogRead(SENBEI_SENSOR) <= SENSOR_VALUE_PLATE_OFFSET;
  }
  
  private void other(float volume,int power, int pos, int count)
  {
    hard.playSounds(SOUND_SENBEI_OTHER,volume,pos,count);
    hard.forward(power,300);
    hard.back(power,100);
    hard.off(100);
  }
}