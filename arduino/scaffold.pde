/*
  Arduino Project Scaffold

  Serial Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
  Be verbose about it too.
 */

void setup() {
  pinMode(13, OUTPUT);
  Serial.begin(19600);
}

void loop() {
  Serial.println("Led on");
  digitalWrite(13, LOW);   // set the LED on
  delay(1000);              // wait for a second
  Serial.println("Led off");
  digitalWrite(13, HIGH);    // set the LED off
  delay(1000);              // wait for a second
}
