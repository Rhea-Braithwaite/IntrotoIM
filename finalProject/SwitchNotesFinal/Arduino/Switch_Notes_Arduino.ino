#include "notes.h"
const int SWITCH1 = A0;
const int SWITCH2 = A1;
const int SWITCH3 = A2;
const int SWITCH4 = A3;
const int TONER = 8;
const int POTENTIOMETER = A4; 
int note = 0;
int len = 0;
const int noteDuration = 1500;
int noteSpeed = 0;

int melody[] = {NOTE_A3, NOTE_B3, NOTE_C3, NOTE_D3, NOTE_E3, NOTE_F3, NOTE_G3};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("0, 0, 0, 0, 0");
}

void loop() {
  // put your main code here, to run repeatedly:
  while(Serial.available()){
    note = Serial.parseInt();
    len = Serial.parseInt();
    if (Serial.read() == '\n'){
      playNote();
      // Read the state of the switches
   
      int lane1 = digitalRead(SWITCH1);
      delay(1);
      int lane2 = digitalRead(SWITCH2);
      delay(1);
      int lane3 = digitalRead(SWITCH3);
      delay(1);
      int lane4 = digitalRead(SWITCH4);
      delay(1);
      int val = analogRead(POTENTIOMETER);
      noteSpeed = map(val, 0, 1023, 3, 1); // Map the potentiometer to one of three speeds
      delay(1);
     
      //Send the values to Processing
      Serial.print(lane1);
      Serial.print(',');
      Serial.print(lane2);
      Serial.print(',');
      Serial.print(lane3);
      Serial.print(',');
      Serial.print(lane4);
      Serial.print(',');
      Serial.println(noteSpeed);
    }
  }
}

void playNote(){
  if (note != 0){
    int index = note - 1;
    
    if (noteSpeed == 3){
      noteSpeed = 4;
    }
    if (len == 1){ // Length = 1 beat 
      int noteDuration = 500/noteSpeed;
      tone(TONER, melody[index], noteDuration); // Play note for specific note duration
    }
    else if (len == 2){ // Length = 2 beats 
      int noteDuration = 1000/noteSpeed;
      tone(TONER, melody[index], noteDuration); // Play note for specific note duration
    }
    else if (len == 4){ // Length = 4 beats
      int noteDuration = 2000/noteSpeed;
      tone(TONER, melody[index], noteDuration); // Play note for specific note duration  
    }
    else if (len == 5){ // Length = half a beat 
      int noteDuration = 250/noteSpeed;
      tone(TONER, melody[index], noteDuration); // Play note for specific note duration 
    }
    
  }
}
