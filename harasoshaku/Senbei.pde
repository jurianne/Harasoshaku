class Senbei extends Tabemono
{
  private final String SOUND_SENBEI_OTHER = "/sother";
  
  Senbei(HardwareController _hard)
  {
    super(_hard);
  }
  
  public void init()
  {
  }
  
  public void sosyaku(float volume, int power, int pos)
  {
    other(volume,power,pos);
  }
  
  private void other(float volume,int power, int pos)
  {
    hard.playSounds(SOUND_SENBEI_OTHER,volume,pos);
    hard.forward(power,300);
    hard.back(power,100);
    hard.off(100);
  }
}