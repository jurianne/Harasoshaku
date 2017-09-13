void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(3,INPUT);
  pinMode(4,INPUT);
  pinMode(5,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(analogRead(3));
  Serial.print(",");
  Serial.print(analogRead(4));
  Serial.print(",");
  Serial.print(analogRead(5));
  Serial.println();
  
}
