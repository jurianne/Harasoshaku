class Ringo extends Tabemono
{
  private final String SOUND_RINGO_OTHER = "/rother";
  
  Ringo(Arduino ard, OscP5 osc,NetAddress netAddress)
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
    playSounds(SOUND_RINGO_OTHER,volume);
    forward(255,800);
    back(255,500);
    off(10);
  }
}