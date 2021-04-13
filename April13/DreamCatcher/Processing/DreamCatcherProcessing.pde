/* Name: Rhea Braithwaite
   Assignment: DreamCatcher
   Due Date: April 13, 2021
*/

import processing.serial.*;
Serial myPort;

PImage starbgd, dc, sun, eclipse;
DreamCatcher gameDC; 

int goodDream = 1;
int badDream = 0;
int dreamIndex = 0;
int totDreams = 10;
Dream[] dreams = new Dream[totDreams];
int checkPoint = 830/2;
int score = 0; 
int bonus = 0;
int lives = 5;
int pause = 400;
int check;

void setup(){
    size(900, 830);
    background(0);
    
    // Load the images from memory
    starbgd = loadImage("data/images/bdg2.jpg");
    dc = loadImage("data/images/dc.png");
    sun = loadImage("data/images/sun.png");
    eclipse = loadImage("data/images/eclipse.png");
    
    gameDC = new DreamCatcher(); 
    
    //Create the dreams
    for (int i = 0; i <totDreams; i++){
      if (i%2 ==0){
        dreams[i] = new Dream(sun, goodDream);
      }
      else{
        dreams[i] = new Dream(eclipse, badDream);
      }
    }
    
    printArray(Serial.list());
    String portname=Serial.list()[6];
    println(portname);
    myPort = new Serial(this,portname,9600);
    myPort.clear();
    myPort.bufferUntil('\n');
}

void draw(){
  if(lives > 0 ){ // As long as there are lives reamining the game continues playing
    imageMode(CENTER);
    image(starbgd, width/2, height/2);
    gameDC.display(); 
    shift();
    displayScore();
    displayLives();
  }
  else{
    if(frameCount - check < pause){ // If there are 0 lives remaining (GameOver) the gameOver Screen is shown for 20 seconds
      gameOver();
    }
    else{
      reset(); // Reset the game variables so that the game can restart
    }
    
  }
}

void gameOver(){ // Display Game Over message, as well as score and bonus
  background(5, 27, 131);
  textSize(50);
  fill(246, 250, 217); 
  textAlign(CENTER);
  text("Too Many Bad Dreams Got Through", width/2, 300);  
  text("I Couldn't Sleep", width/2, 400 );
  textSize(45);
  text("SCORE: " + str(score), width/2, 500);
  text("BONUS: " + str(bonus), width/2, 600);  
}
void reset(){ // Reinitialize variables so that the game can automatically restart
  lives = 5;
  score =0;
  dreamIndex = 0;
  check = 0;
  for(int i = 0; i< totDreams; i++){
    dreams[i].start = false;
    dreams[i].caught = false;
    dreams[i].reset();
  }
  gameDC.reset();
}
void shift(){
  if(dreamIndex == 0 && dreams[0].start == false){ // When the game begins have the first dream begin moving
      dreams[0].start = true;
      dreamIndex ++;
    }
    
  for (int i = 1; i < totDreams; i++){
    if (i == dreamIndex && dreams[i].start == false){ // The current dream has not started moving and displaying to the user
      if(dreams[i-1].y >= checkPoint){ // If the previous dream has reached half-way on the screen, the current dream starts moving
        dreams[i].start = true;
        dreamIndex ++;
        if(dreamIndex == totDreams){ // Restart from the first index
          dreamIndex = 0;
        }
      }
    }
    
  for(int j = 0; j< totDreams; j++){ // Shift, display and catch the dream if it collides with the dreamCatcher
      if (dreams[j].start == true){
        dreams[j].update();
        dreams[j].display();
        dreams[j].catchDream();
      }
    }
  }
}

void displayScore(){ // Display the game score
  textAlign(RIGHT);
  textSize(30);
  fill(255);
  text("Score:" + str(score), width-50, 50 );
}
void displayLives(){ // Display the number of lives remaining
  textAlign(LEFT);
  textSize(30);
  fill(255);
  text("Lives:" + str(lives), 50, 50 );
}

// Shift the slider from left to right within the margins of the screen depending on the switch being pressed
void slide(int left, int right) { 
  if (left == 1 && (gameDC.x - (gameDC.dcWidth/2)>=0)){
    gameDC.x = gameDC.x - gameDC.interval;
  }
  else if (right == 1 && (gameDC.x + (gameDC.dcWidth/2)<=width)){
    gameDC.x = gameDC.x + gameDC.interval;
  }
}

void serialEvent(Serial myPort){ // Accept the values of the switche from Arduino
  String s = myPort.readStringUntil('\n');

  s = trim(s);
  if (s!= null){
    int values[] = int(split(s,','));
    if(values.length == 2){
      int left = values[0];
      int right = values[1];
  
      slide(left, right);
    }
  }
  
  myPort.write("\n");
}
