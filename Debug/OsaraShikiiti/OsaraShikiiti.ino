void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(5,INPUT);
  pinMode(6,INPUT);
  pinMode(7,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(analogRead(5));
  Serial.print(",");
  Serial.print(analogRead(6));
  Serial.print(",");
  Serial.print(analogRead(7));
  Serial.println();
  
}
