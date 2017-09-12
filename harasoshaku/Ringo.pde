class Ringo extends Tabemono
{
  private final String SOUND_RINGO_FIRST = "/rfirst";
  private final String SOUND_RINGO_OTHER = "/rother";
  
  private int count = 0;
  
  Ringo(Arduino ard, OscP5 osc,NetAddress netAddress)
  {
    super(ard,osc,netAddress);
    
    count = 0;
  }
  
  public void init()
  {
    count = 0;
  }
  public void sosyaku(float power)
  {
    switch(count)
    {
    case 0:
      first(power);
      count++;
      break;
    default:
      other(power);
      break;
    }
  }
  private void first(float power)
  {
    playSounds(SOUND_RINGO_FIRST,power);
    forward(255,200);
    off(100); 
    forward(255,200);
    off(100);
    forward(255,200);
    off(100); 
    forward(255,200);
    off(50);
    forward(255,200);
    off(50);
    forward(255,200);
    off(50);
  }
  
  private void other(float power)
  {
    playSounds(SOUND_RINGO_OTHER,power);
    forward(255,800);
    back(255,500);
  }
}