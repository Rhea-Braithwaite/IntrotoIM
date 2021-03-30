
const int DOT= 1;
const int DASH = 2;
const int SPACE = 3;
const int DAYBRIGHTNESS = 255;
const int NIGHTBRIGHTNESS = 1;
const int ECLIPSEBRIGHTNESS = 50;

// arrays with words in morse code
int sun[] = {1, 1, 1, 3, 1, 1, 2, 3, 2, 1};
int moon[] = {2, 2, 3, 2, 2, 2, 3, 2, 2, 2, 3, 2, 1};
int eclipse[] = {1, 3, 2, 1, 2, 1, 3, 1, 2, 1, 1, 3, 1, 1, 3, 1, 2, 2, 1, 3, 1, 1, 1, 3, 1};

const int BLUELED = 3;
const int REDLED = 5;
const int GREENLED = 9;


const int LDR = A0;
const int SWITCH = A1;

int delay1 = 200;
int delay2 = delay1*3;

void setup() {
  // put your setup code here, to run once:
  
  pinMode(REDLED, OUTPUT);
  pinMode(BLUELED, OUTPUT);
  pinMode(GREENLED, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = analogRead(LDR);
  
  if (digitalRead(SWITCH) == HIGH){
    analogWrite(BLUELED, ECLIPSEBRIGHTNESS); // Make LED in between bright and dim
    flash(eclipse, 25);
  }
  else 
    if(sensorValue>512){
      analogWrite(BLUELED, DAYBRIGHTNESS); // Make LED bright
      flash(sun, 10); 
    }
    else{
      analogWrite(BLUELED, NIGHTBRIGHTNESS); // Make LED dim
      flash(moon, 13);
    }
 
}

void flash(int morseCode[], int len){
  // Signal that code is starting by flashing twice
  for (int i = 0; i< 2; i++){
    digitalWrite(GREENLED, HIGH);
    digitalWrite(REDLED, HIGH);
    delay(500);
    digitalWrite(GREENLED, LOW);
    digitalWrite(REDLED, LOW);
    delay(300);
  }
  delay(300);

  //flash the morse code depending the array element
  for (int i = 0; i < len; i++){
    
    if(morseCode[i] == DOT){
      digitalWrite(REDLED, HIGH);
      delay(delay1);
      digitalWrite(REDLED, LOW);
    }
    else if (morseCode[i] == DASH){
      digitalWrite(GREENLED, HIGH);
      delay(delay2);
      digitalWrite(GREENLED, LOW);      
    }
    else if (morseCode[i] == SPACE){
      delay(delay2);
    }
    delay(delay1);
    
  }
  
}
