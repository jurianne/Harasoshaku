class Senbei extends Tabemono
{
  private final String SOUND_SENBEI_OTHER = "/sother";
  
  Senbei(Arduino ard, OscP5 osc,NetAddress netAddress)
  {
    super(ard,osc,netAddress);
  }
  
  public void init()
  {
  }
  
  public void sosyaku(float volume, int power)
  {
    other(volume,power);
  }
  
  private void other(float volume,int power)
  {
    playSounds(SOUND_SENBEI_OTHER,volume);
    forward(power,300);
    back(power,100);
    off(10);
  }
}