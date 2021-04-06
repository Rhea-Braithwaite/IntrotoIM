/* Name: Rhea Braithwaite
 * Date: April 6, 2021
 * Assignment: Musical Instrument
 */

# include "Classes.h"

const int SWITCH1 = A5;
const int SWITCH2 = A4;
const int SWITCH3 = A3;
const int TOGGLE = A2;

const int PAUSE = 500;
int note;
boolean playNote = false;
unsigned long timeNotePlayed = 0;
int index;

UltraSonicSensor pitchChanger;
Sweep baseLine(1500);

const int BLUELED = 6;
const int REDLED = 7;
int blueLedState = LOW;
int redLedState = LOW;
unsigned long previousMillisBL = 0;
unsigned long previousMillisRL = 0;
const int intervalBL1 = 300;
const int intervalBL2 = 1000;
const int intervalRL = 1500;

int blinkNum;
int blinkCount = 0; 

void setup() {
  // put your setup code here, to run once:
  pinMode(BLUELED, OUTPUT);
  pinMode(REDLED, OUTPUT);
  baseLine.Attach(5);
}

void loop() {
  // put your main code here, to run repeatedly:
  flashBaseLine();
  flashPitch();
  if(digitalRead(SWITCH1) == HIGH){
    playNote = true;
    note = 0;
  }
  else if(digitalRead(SWITCH2) == HIGH){
    playNote = true;
    note = 1;
  }
  else if(digitalRead(SWITCH3) == HIGH){
    playNote = true;
    note = 2;
  }    
  pitchChanger.NotePitch(); // Determine note pitches
  unsigned long currentMillis = millis();

  if(playNote == true && (currentMillis - timeNotePlayed >= (noteDuration+PAUSE))){ // Time to play a note
    playNote = false;
    pitchChanger.NoteIndex(note); // Determine note index based on the pitch
    timeNotePlayed = currentMillis;
  }

  if (digitalRead(TOGGLE) == HIGH){ // Toggle switch is on so swing servo
    baseLine.swing = true;
    baseLine.Update();
  }
  else{
    baseLine.swing = false;
  }
}


void flashBaseLine() {
  unsigned long currentMillis = millis();
  
  if(baseLine.swing == true){ // Toggle switch is on
    if (currentMillis - previousMillisRL >= intervalRL) { // Flash Red LED on interval
      // save the last time you blinked the LED
      previousMillisRL = currentMillis;
    
      // if the LED is off turn it on and vice-versa:
      if (redLedState == LOW) {
        redLedState = HIGH;
      } else {
        redLedState = LOW;
      }
    
      // set the LED with the ledState of the variable:
      digitalWrite(REDLED, redLedState);
    }  
  }
  else{
    redLedState = LOW;
    digitalWrite(REDLED, redLedState);
    previousMillisRL = 0;
  }    
}


void flashPitch() {
  convert();
  if (blinkCount < blinkNum){ // Flash Blue LED, on and off the number of times matching the pitch 
    unsigned long currentMillis = millis();
    if (currentMillis - previousMillisBL >= intervalBL1) { // Interval of the pitch flash
    // save the last time you blinked the LED
      previousMillisBL = currentMillis;

    // if the LED is off turn it on and vice-versa:
      if (blueLedState == LOW) {
        blueLedState = HIGH;
      } else {
        blueLedState = LOW;
      }

      blinkCount += 1;
      digitalWrite(BLUELED, blueLedState);

    }
  }
  else{
    unsigned long currentMillis = millis();
    if (currentMillis - previousMillisBL >= intervalBL2) { // Break between pitch flash, so that the pitch is discernible
      blinkCount = 0;
      previousMillisBL = 0;
    }
  }
}

void convert(){
  // Mutliply by two because LED has to be turned on and off
 if (pitchChanger.pitch == 1) { 
      blinkNum =  2*1; // LED flashes once
    }
    else if (pitchChanger.pitch == 2){
      blinkNum =  2*2; // LED flashes twice
    }
    else if (pitchChanger.pitch == 3){
      blinkNum =  2*3; // LED flashes three times
    }
    else if (pitchChanger.pitch == 4){
      blinkNum =  2*4; // LED flashes four times
    }  
}
