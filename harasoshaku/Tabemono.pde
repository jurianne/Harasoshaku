abstract class Tabemono
{
  protected HardwareController hard;
  abstract void sosyaku(float volume, int power, int pos);
  Tabemono(HardwareController _hard)
  {
    hard = _hard;
  }
}