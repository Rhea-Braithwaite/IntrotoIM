const int SWITCH1 = A0;
const int SWITCH2 = A1;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //Send initial values to Processing to start communication
  Serial.println("0, 0");
}

void loop() {
  // put your main code here, to run repeatedly:
  while (Serial.available()) {
    if (Serial.read() == '\n') {
      // Read the state of the switchs
      int leftSwitch = digitalRead(SWITCH1);
      delay(1);
      int rightSwitch = digitalRead(SWITCH2);
      delay(1);
      
      //Send the values to Processing
      Serial.print(leftSwitch);
      Serial.print(',');
      Serial.println(rightSwitch);
    }
  }
}
