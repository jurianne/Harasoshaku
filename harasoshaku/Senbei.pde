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
  
  public void sosyaku(float power)
  {
    other(power);
  }
  
  private void other(float power)
  {
    playSounds(SOUND_SENBEI_OTHER,power);
    forward(255,800);
    back(255,500);
  }
}