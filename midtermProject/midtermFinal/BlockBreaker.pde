/* Name: Rhea Braithwaite
   Assignment: Block Breaker
   Due Date: March 4, 2021

*/

import processing.sound.*; //* load the sound library

SoundFile hit, win, lose, background;

PImage blockDamage1, blockDamage2, instructions;

color colorOptions[] = {color(86, 76, 250), color(18, 203, 47), color(250, 28, 46)};

boolean played = false;
boolean start = false;
boolean help = true;
boolean startLevel = false;
boolean pause = false;
boolean GameOver = false;
boolean gameWon = false;
boolean bonusAdded = false;

int frames = 0;
int minutes, seconds;
int textY=45; 
int transparency = 255;
int totLevels = 3;
int currLevelIndex = 2;

final int NUMBEROFSTARS = 300;

Slider gameSlider = new Slider();
Ball gameBall = new Ball();
Level[] levels = new Level[totLevels];
Circle[] circles = new Circle[NUMBEROFSTARS];
Star[] gameStars = new Star[NUMBEROFSTARS];

void setup(){
  size(1200, 900);
  levels[0] = new Level(1, 16, 4, 80, 75, 60, 0);
  levels[1]  = new Level(2, 8, 3, 100, 240, 80, 2);
  levels[2]  = new Level(3, 16, 4, 80, 75, 80, 4);
  
  blockDamage1 = loadImage("data/images/Damage1.png");
  blockDamage2 = loadImage("data/images/Damage2.png");
  
  instructions = loadImage("data/images/Instructions.png");
  instructions.resize(width-10, 0);
  
  hit = new SoundFile(this, "data/sounds/hit.wav");
  win = new SoundFile(this, "data/sounds/win.mp3");
  lose = new SoundFile(this, "data/sounds/lose.mp3");
  background = new SoundFile(this, "data/sounds/background1.mp3");
  createStars(); // Create stars for game background
  
  for (int i = 0; i<3; i++){
    levels[i].createBlocks(); // Create the blocks for each level
  }

}

void draw() {
  if (help == true){
    instructions();
  }
  else if (start == false) {
    startScreen();
  }
  else{
    levelScreen();
    gamePlay();
  }
}

void instructions(){
  background(0); // Colour the background black
  
  for(int i = 0; i<NUMBEROFSTARS; i++){
    circles[i].display();
  }
  
  fill(246, 250, 217); // Colour the text offwhite
  textSize(25);
  textAlign(CENTER);
  text("HOW TO PLAY", width/2, 50);
  image(instructions, 0, 100); // Display the image with the game instructions
  text("CONTINUE",width/2, (height/2)+350);
}

void startScreen() {
  background(252, 155, 36); // Colour the background black
  fill(0);
  for(int i = 0; i<NUMBEROFSTARS; i++){
    circles[i].display();
  }
  
  // Game Title
  textSize(100);
  textAlign(CENTER);
  fill(0);
  text("BLOCK BREAKER", width/2, (height/5));
  
  // Game Display
  for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (240+BLOCKWIDTH)){
    rectMode(CORNER);
    rect(xPos, height/3, BLOCKWIDTH, BLOCKHEIGHT, 7);
  }
  
  rectMode(CENTER);
  rect(width/2, height-250, SLIDERWIDTH, SLIDERHEIGHT, 10); //Draw slider
  circle(width/2, height-300, 50);
  
  
  // Start Button
  textSize(50);
  text("START",width/2, (height/2)+350);
}

void gamePlay() {
  
  if (startLevel == true && start == true){ // If a game level has started (ball has started moving), start counting the number of frames
    frames += 1;
  }
  if (start == true && transparency >0){ // If the user presses start on the welcome screen slowly decrement the transparency variable
    transparency --;
  }
  background(0);// Recolour Background Black
  
  shiftStars();
  backgroundMusic();
  levels[currLevelIndex].displayBlocks();
  
  levels[currLevelIndex].endOfLevel();
  
  levels[currLevelIndex].score();
  levels[currLevelIndex].remainingLives();
  levels[currLevelIndex].updateTime();
  levels[currLevelIndex].displayTime();
  
  gameSlider.display();
  gameSlider.shift();
  
  gameBall.display();
  
 
  gameBall.ballStart();
  gameBall.update();
  gameBall.collision();
  gameBall.outOfBounds();
  levelWin();
  gameOver();
  gameWin();
  levelScreen();  
      
}

void levelScreen(){
  if (gameWon == false){ // If game has not been won and level begins, display the level screen
    fill(0, transparency); // Colour the background black
    rectMode(CORNER);
    rect(0,0, width, height); // Display a rectangle as the background
    fill(colorOptions[currLevelIndex], transparency); // Select the colour based on the level
    
    for(int i = 0; i<NUMBEROFSTARS; i++){
      circles[i].display(); // Display the background circles
    }
    
    textSize(150);
    textAlign(CENTER);
    text("LEVEL", width/2, (height/2)-130);
    text(currLevelIndex+1, width/2, (height/2)+100);
  }

}

void backgroundMusic(){
  if(background.isPlaying() == false && pause == false){ // If the game background music is not playing and the game level has started, loop the sound file
    background.loop();
  }
}

void createStars(){ // Create the stars for the background
  for (int i=0; i<NUMBEROFSTARS; i++) {
    gameStars[i] = new Star();
    circles[i] = new Circle();
  }
}

void shiftStars() { // Shift the position of each star and display them on screen
  for (int i=0; i<NUMBEROFSTARS; i++) {
    gameStars[i].update();
    gameStars[i].display();
  }  
}

int eyeWidth = 25;
int eyeHeight = 50;
int faceDimensions = 300;
int mouthWidth = 110;
int mouthHeight = 100; 

void levelWin(){ // Display Win to the user
  if (levels[currLevelIndex].win == true && pause == true){
    
    if(background.isPlaying() == true){ // If the game background music is playing reset the position and pause the file
      background.jump(0); 
      background.pause();
    }
    
    if (win.isPlaying() == false && played == false){ // If the win sound file is not playing, and has not been played before, play the file
      win.play();
      played = true; // Sound file has been played already
    }    
    background(23, 14, 129); // Colour the background blue
    fill(227, 234, 17); // Colour the face yellow
    circle(width/2, (height/2)-150, faceDimensions);
    fill(0); // Colour the eyes and smile black
    
    // Eyes
    ellipse( (width/2)-60, (height/2)-200, eyeWidth, eyeHeight);
    ellipse( (width/2) + 60, (height/2)-200, eyeWidth, eyeHeight);
    
    // Smiling Mouth
    arc(width/2, (height/2)-110, mouthWidth, mouthHeight, 0, PI);
    
    fill(22, 245, 61, 127);
    rectMode(CENTER);
    rect(width/2, (height/2)+110, width, 210);
    textSize(100);
    fill(246, 250, 217); // Colour the text offwhite
    textAlign(CENTER);
    text("Level Complete!", width/2, 100);  
    textSize(45);
    
    if (levels[currLevelIndex].seconds == 0){
      text("Time: " +levels[currLevelIndex].minutes+":00", width/2, (height/2)+50);
    }
    else if (levels[currLevelIndex].seconds < 10){
      text("Time: " +levels[currLevelIndex].minutes+":0"+levels[currLevelIndex].seconds, width/2, (height/2)+50);  
    }
    else{
      text("Time: " +levels[currLevelIndex].minutes+":"+levels[currLevelIndex].seconds, width/2, (height/2)+50);  
    }    
    
    text("Score: " + levels[currLevelIndex].score, width/2, (height/2)+100);
    text("Lives Remaining: " + levels[currLevelIndex].lives, width/2, (height/2)+150);
    text("Time Bonus: " + levels[currLevelIndex].bonus, width/2, (height/2)+200);
    
    textSize(30);
    text("PRESS THE MOUSE TO CONTINUE",width/2, (height/2)+350);
  }
}

void gameOver(){
  if (levels[currLevelIndex].win == false && pause == true){ // If a level has been lost display the Game Over Screen
    if(background.isPlaying() == true){ // If the game background music is playing reset the position and pause the file
      background.jump(0);
      background.pause();
    }
    if (lose.isPlaying() == false && played == false){ // If the lose sound file is not playing, and has not been played before, play the file
      lose.play();
      played = true; // Sound file has been played already
    }    
    
    background(165, 6, 0); // Colour the background red
    fill(227, 234, 17); // Colour the face yellow
    circle(width/2, (height/2)-150, faceDimensions);
    fill(0); // Colour the eyes and smile black
    
    // Eyes 
    ellipse( (width/2)-60, (height/2)-200, eyeWidth, eyeHeight);
    ellipse( (width/2) + 60, (height/2)-200, eyeWidth, eyeHeight);
    
    // Frowning mouth
    arc(width/2, (height/2)-85, mouthWidth, mouthHeight, PI,TWO_PI, CHORD);
    
    fill(0, 255, 40, 127);
    rectMode(CENTER);
    rect(width/2, (height/2)+95, width, 180);
    textSize(100);
    fill(246, 250, 217); // Colour the text offwhite
    textAlign(CENTER);
    text("Level Lost!", width/2, 100);  
    textSize(45);
    if (levels[currLevelIndex].seconds == 0){
      text("Time: " +levels[currLevelIndex].minutes+":00", width/2, (height/2)+50);
    }
    else if (levels[currLevelIndex].seconds < 10){
      text("Time: " +levels[currLevelIndex].minutes+":0"+levels[currLevelIndex].seconds, width/2, (height/2)+50);  
    }
    else{
      text("Time: " +levels[currLevelIndex].minutes+":"+levels[currLevelIndex].seconds, width/2, (height/2)+50);  
    }    
    text("Score: " + levels[currLevelIndex].score, width/2, (height/2)+100);
    text("Lives Remaining: " + levels[currLevelIndex].lives, width/2, (height/2)+150);
    textSize(30);
    text("PRESS THE MOUSE TO RESTART",width/2, (height/2)+350);
    
    if(mousePressed){
      resetLevels();
    }
  }  
}

void gameWin(){
  if (gameWon == true){
    
    if(background.isPlaying() == true){ // If the game background music is playing reset the position and pause the file
      background.jump(0);
      background.pause();
    }
    
    if (win.isPlaying() == false && played == false){ // If the win sound file is not playing, and has not been played before, play the file
      win.play();
      played = true; // Sound file has been played already
    }
    background(185, 14, 198); // Colour the background blue
    
    fill(22, 245, 61, 127);
    rectMode(CENTER);
    rect(width/2, (height/2)-25, width, 180);
   
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text("Game Won!", width/2, height/2);  
    textSize(30);
    text("PRESS THE MOUSE TO RESTART",width/2, (height/2)+350);   
  }
}

void mousePressed() {
  if (help == true && mouseX>= 535 && mouseX <= 665 && mouseY >= 775 && mouseY<= 800){ // If the how to play screen is being displayed, and the user presses continue, stop displaying the help screen
    help = false;
  }
  else if (start == false && mouseX>= 520 && mouseX <= 680 && mouseY >= 760 && mouseY<= 800){ // If the home screen is being displayed, and the user presses start, stop displaying the home screen
    start = true;
  }
  // If the home screen is no longer being displayed and the levelScreen is no longer visible, if the mouse is pressed, start the game level (the ball starts moving)
  else if (pause == false && start == true && startLevel == false  && transparency == 0){ 
    startLevel = true;
  }
  // If a level has been won, but the game is not finished reset the variables for the next level
  else if (levels[currLevelIndex].win == true  && pause == true && gameWon == false){
    played = false; // No sound file has been played yet
    frames = 0; // Reset the frames variable so that the time can be calculated
    transparency = 255; // Level Screen will be opaque until transparency is decremented to 0
    bonusAdded = false; // No time bonus has been added for the next level
    
    if(currLevelIndex != 2){ // If it is not the last level that has been won, continue to the next level
      pause = false; // Stop displaying the level won screen
      currLevelIndex++; // Move on to the next level
    }
    else{
      pause = false; // Stop displaying the level won screen
      gameWon = true; // As it is the last level, the game has been won
    }
  }
  else if (levels[currLevelIndex].win == true && gameWon == true){ // If the mouse is pressed on the Game Won Screen, reset the levels so the game can be restarted
    played = false; // No sound file has been played yet
    resetLevels(); // Reset the game levels for the next game   
  }
}

void resetLevels(){
  for(int i = currLevelIndex; i>= 0; i--){ // Reset all levels from the current level
    levels[i].reset();
  }
  played = false; // No sound file has been played yet
  currLevelIndex=0; // Start from the level 1
  pause = false; // Do not display a Level Won, Game Over, or Game Win Screen
  start = false; // Show the Home Screen
  startLevel = false; // No level has started
  gameWon = false; // The game has not been won
  transparency = 255; // Level Screen will be opaque until transparency is decremented to 0
  bonusAdded = false; // No Time Bonus has been added
}
