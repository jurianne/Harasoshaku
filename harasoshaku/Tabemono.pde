abstract class Edible
{
  protected HardwareController hard;
  protected int count;
  protected float localvolume;
  protected boolean isSwallow;
  abstract void sosyaku(float volume, int power, int pos);
  abstract boolean isOntheTable(Arduino ard);
  Edible(HardwareController _hard)
  {
    hard = _hard;
    isSwallow = false;
    count = 0;
  }
  void gokuri()
  {
    hard.playSounds("/gokuri", 1, POS_FORWARD,count);
    hard.forward(255, 400);
    hard.back(255, 400);
    hard.off(10);
    isSwallow = true;
    count = 0;
  }
  int getCount(){return count;}
  abstract void startEating();
}