#include <Servo.h>
#include "notes.h"

const int noteDuration = 250;
const int TONER = 12; 

int melody[] = {NOTE_A2, NOTE_B2, NOTE_C2, NOTE_A3, NOTE_B3, NOTE_C3, NOTE_A4, NOTE_B4,NOTE_C4, NOTE_A5, NOTE_B5, NOTE_C5};

class Sweep {
  public:
    Servo servo;
    int pos;
    int posChange;
    int interval;
    unsigned long lastTimeUpdate;
    boolean swing;

    Sweep(int interv) {
      lastTimeUpdate = 0;
      interval = interv;
      posChange = 0;
      swing = false;
    }

    void Attach(int pin) {
      servo.attach(pin);
    }

    void Update() {
      unsigned long currentMillis = millis();
      if (swing == true && (currentMillis - lastTimeUpdate >= interval)) { // Time to swing servo
        if (posChange == 0){ // Swing servo by alternating the position from 0 to 180
          pos = 180;
          posChange = 1;
        }
        else{
          pos = 0;
          posChange = 0;
        }
        lastTimeUpdate = millis();
        servo.write(pos);
      }
    }
};

class UltraSonicSensor {
  public:
    int pingPin;
    int echoPin;
    int interval;
    unsigned long timeSignalSent;
    long duration;
    boolean sendSignal;
    long distance;
    int index;
    long pitch;

    UltraSonicSensor() {
      pingPin = A1;
      echoPin = A0;
      timeSignalSent = 0;
      sendSignal = true;
      interval = 10;
    }
    
    void NotePitch() {
      if (sendSignal == true) { // Send outgoing signal from ping Pin
        pinMode(pingPin, OUTPUT);
        digitalWrite(pingPin, LOW);
        delay(2);
        digitalWrite(pingPin, HIGH);
        timeSignalSent = millis();
        sendSignal = false;
      }
      unsigned long currMillis = millis();

      if(currMillis - timeSignalSent >= interval){ // Time to read incoming signal
        digitalWrite(pingPin, LOW);
        pinMode(echoPin, INPUT);
        duration = pulseIn(echoPin, HIGH); // Measure the time it takes for outgoing signal to echo
        distance = duration / 74 / 2; // convert from microseconds to inches
        pitch = constrain(distance, 0, 4); // Limit the distance to the pitch range
        sendSignal = true;
      }
    }    
    
    void NoteIndex(int note) { // Determine the notes to be played based on the switch selected and the pitch 
      if (pitch == 1) {
        index = note;
      }
      else if (pitch == 2){
        index = map(note, 0, 2, 3, 5); 
      }
      else if (pitch == 3){
        index = map(note, 0, 2, 6, 8);
      }
      else if (pitch == 4){
        index = map(note, 0, 2, 9, 11);
      }
      tone(TONER, melody[index], noteDuration); // Play note
    }
};
