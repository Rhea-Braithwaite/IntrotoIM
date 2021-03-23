//Progress LEDS
const int BLUELED1 = 9;
const int BLUELED2 = 10;
const int BLUELED3 = 11;

// Wrong or correct switch LEDS
const int REDLED = 3;
const int GREENLED = 5;

// Switches
const int SWITCH1 = A0;
const int SWITCH2 = A1;
const int SWITCH3 = A2;

const int TOT = 9;
int pattern[TOT]; 


int pos = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(BLUELED1, OUTPUT);
  pinMode(BLUELED2, OUTPUT);
  pinMode(BLUELED3, OUTPUT);
  pinMode(REDLED, OUTPUT);
  pinMode(GREENLED, OUTPUT);

  // iinitalize pattern using random numbers
  for(int i = 0; i< TOT; i++){
    pattern[i] = int(random(1, 4));
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  if(pos < TOT){
    if( digitalRead(SWITCH1) == HIGH ){ // Switch 1 is pressed
      check(1);
    }
    else if( digitalRead(SWITCH2) == HIGH ){ // Switch 2 is pressed
      check(2);
    }
    else if( digitalRead(SWITCH3) == HIGH ){ // Switch 3 is pressed
      check(3);
    }
  }
}

void check(int i){
  if(pattern[pos] == i){ // Switch matches the pattern
    // flash green
    digitalWrite(GREENLED, HIGH);
    delay(500);
    digitalWrite(GREENLED, LOW);
    delay(250);
    pos++;
    light();
    win();
  }
  else{
    // flash red
    digitalWrite(REDLED, HIGH);
    delay(500);
    digitalWrite(REDLED, LOW);
    delay(250);
    reset();
  }
}

void light(){ // Lights up a blue LED based on the progress of the pattern
  if (pos == 3 && digitalRead(BLUELED1) == LOW){
    digitalWrite(BLUELED1, HIGH);
  }

  if (pos == 6 && digitalRead(BLUELED2) == LOW){
    digitalWrite(BLUELED2, HIGH);
  }  
  
  if (pos == 9 && digitalRead(BLUELED3) == LOW){
    digitalWrite(BLUELED3, HIGH);
  }    
}

void reset(){ // Resets the LEDS and position variable if a wrong switch is selcted or if the puzzle is solved and is to restart
  pos = 0;
  if (digitalRead(BLUELED1) == HIGH){
    digitalWrite(BLUELED1, LOW);
  }

  if (digitalRead(BLUELED2) == HIGH){
    digitalWrite(BLUELED2, LOW);
  }   
}

void win(){
  if(pos == TOT){ // If the puzzle is solved, flash the blue LEDs 5 times. 
    for(int i = 0; i< 5; i++){
      digitalWrite(BLUELED1, HIGH);
      digitalWrite(BLUELED2, HIGH);
      digitalWrite(BLUELED3, HIGH);
      delay(500);
      digitalWrite(BLUELED1, LOW);
      digitalWrite(BLUELED2, LOW);
      digitalWrite(BLUELED3, LOW);
      delay(500);
    }
    reset();
  }
}
