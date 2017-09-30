class Niku extends Tabemono
{
  private final String SOUND_NIKU_OTHER = "/nother";
  
  Niku(HardwareController _hard)
  {
    super(_hard);
  }
  
  public void init()
  {
  }
  public void sosyaku(float volume,int power)
  {
    other(volume,power);
  }
  private void other(float volume,int power)
  {
    hard.playSounds(SOUND_NIKU_OTHER,volume);
    hard.forward(power,400);
    hard.back(power,300);
    hard.off(100);
  }
}