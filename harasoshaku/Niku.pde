class Niku extends Tabemono
{
  private final String SOUND_NIKU_OTHER = "/nother";
  
  Niku(Arduino ard, OscP5 osc,NetAddress netAddress)
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
    playSounds(SOUND_NIKU_OTHER,volume);
    forward(255,400);
    back(255,300);
    off(10);
  }
}