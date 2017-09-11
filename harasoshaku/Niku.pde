class Niku extends Tabemono
{
  private final String SOUND_NIKU_FIRST = "/nfirst";
  private final String SOUND_NIKU_OTHER = "/nother";
  
  private int count = 0;
  
  Niku(Arduino ard, OscP5 osc,NetAddress netAddress)
  {
    super(ard,osc,netAddress);
    
    count = 0;
  }
  
  public void init()
  {
    count = 0;
  }
  public void sosyaku()
  {
    switch(count)
    {
    case 0:
      first();
      count++;
      break;
    default:
      other();
      break;
    }
  }
  private void first()
  {
    playSounds(SOUND_NIKU_FIRST);
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
  
  private void other()
  {
    playSounds(SOUND_NIKU_OTHER);
    forward(255,800);
    back(255,500);
  }
}