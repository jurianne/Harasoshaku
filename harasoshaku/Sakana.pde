class Sakana extends Tabemono
{
  private final String SOUND_SAKANA_OTHER = "/sakana";
  
  Sakana(Arduino ard, OscP5 osc,NetAddress netAddress)
  {
    super(ard,osc,netAddress);
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
    playSounds(SOUND_SAKANA_OTHER,volume);
    forward(power,400);
    back(power,300);
    off(10);
  }
}