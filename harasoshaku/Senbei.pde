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
  
  public void sosyaku(float volume)
  {
    other(volume);
  }
  
  private void other(float volume)
  {
    playSounds(SOUND_SENBEI_OTHER,volume);
    forward(255,300);
    back(255,100);
    off(10);
  }
}