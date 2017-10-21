abstract class Tabemono
{
  protected HardwareController hard;
  protected boolean isSwallow;
  abstract void sosyaku(float volume, int power, int pos);
  abstract boolean isOntheTable(Arduino ard);
  Tabemono(HardwareController _hard)
  {
    hard = _hard;
    isSwallow = false;
  }
  void gokuri()
  {
    hard.forward(255, 400);
    hard.playSounds("/gokuri", 1, POS_FORWARD);
    isSwallow = true;
    hard.back(255, 400);
    hard.off(10);
  }
}