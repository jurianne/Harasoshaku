#define AIN1 11
#define AIN2 10
#define PWMA 9

void setup() {
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);

}

void loop() {
  int i = 0;
  //モーター停止
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, LOW);
  delay(3000);

  //モーター正回転・スピード変化
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
  analogWrite(PWMA, 255);
  delay(5000);


  //モーター停止
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, LOW);
  delay(3000);

  //モーター逆回転・スピード変化
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, HIGH);
  analogWrite(PWMA, 255);
  delay(5000);


}
