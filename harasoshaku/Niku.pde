class Niku extends Tabemono
{
  private final String SOUND_NIKU_OTHER = "/nother";
  
  Niku(HardwareController _hard)
  {
    super(_hard);
  }
  
  public void sosyaku(float volume,int power, int pos)
  {
    other(volume,power,pos);
  }
  private void other(float volume,int power, int pos)
  {
    hard.playSounds(SOUND_NIKU_OTHER,volume,pos);
    hard.forward(power,400);
    hard.back(power,300);
    hard.off(100);
  }
}