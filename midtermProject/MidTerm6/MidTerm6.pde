int totLevels = 3;
int currLevelIndex = 2;
float time = 0;
Level[] levels = new Level[totLevels];

Slider gameSlider = new Slider();
Ball gameBall = new Ball();

boolean start = false;
boolean help = true;
boolean startLevel = false;
boolean pause = false;
boolean GameOver = false;
boolean gameWon = false;

int textY=45; 
//int[] score = new int[]{ 0,0,0 };
//int[] lives = new int[]{ 3,3,3 };

void setup(){
  size(1200, 900);
  levels[0] = new Level(1, 16, 4, 80, 75, 60, 0);
  levels[1]  = new Level(2, 8, 3, 100, 240, 80, 2);
  levels[2]  = new Level(3, 16, 4, 80, 75, 60, 4);

  background(0); // Colour Background Black
  for (int i = 0; i<3; i++){
    levels[i].createBlocks();
  }
}

void draw() {
  if (help == true){
    instructions();
    //transition();
  }
  else if (start == false) {
    startScreen();
  }
  else{
    gamePlay();
  }
}


int eyeWidth = 25;
int eyeHeight = 50;
int faceDimensions = 300;
int mouthWidth = 110;
int mouthHeight = 100; 

void transition(){ // Display Win to the user
  if (levels[currLevelIndex].win == true && pause == true){
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
      rect(width/2, (height/2)+95, width, 180);
      textSize(100);
      fill(246, 250, 217); // Colour the text offwhite
      textAlign(CENTER);
      text("Level Complete!", width/2, 100);  
      textSize(45);
      text("Time:" + levels[currLevelIndex].time, width/2, (height/2)+50);
      text("Score:" + levels[currLevelIndex].score, width/2, (height/2)+100);
      text("Lives Remaining:" + levels[currLevelIndex].lives, width/2, (height/2)+150);
      textSize(30);
      text("PRESS THE MOUSE TO CONTINUE",width/2, (height/2)+350);
  }
}

void startScreen() {
  background(255); // Colour the background black
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

void instructions(){
  background(0);
  textSize(25);
  textAlign(CENTER);
  text("HOW TO PLAY", width/2, 100);
  text("CONTINUE",width/2, (height/2)+350);
}

void gamePlay() {
  background(0);// Recolour Background Black
  
  levels[currLevelIndex].displayBlocks();
  levels[currLevelIndex].endOfLevel();
  
  levels[currLevelIndex].score();
  levels[currLevelIndex].remainingLives();
  
  gameSlider.display();
  gameSlider.shift();
  
  gameBall.display();
  gameBall.ballStart();
  gameBall.update();
  gameBall.collision();
  gameBall.outOfBounds();
  transition();
  gameOver();
  gameWin();
        
}


void mousePressed() {
  if (help == true && mouseX>= 535 && mouseX <= 665 && mouseY >= 775 && mouseY<= 800){
    help = false;
  }
  else if (start == false && mouseX>= 520 && mouseX <= 680 && mouseY >= 760 && mouseY<= 800){
    start = true;
  }
  else if (pause == false && start == true && startLevel == false){
    startLevel = true;
  }
  else if (levels[currLevelIndex].win == true  && pause == true && gameWon == false){
    if(currLevelIndex != 2){
      pause = false;
      currLevelIndex++;
      println(currLevelIndex);
    }
    else{
      pause = false;
      gameWon = true;
    }
  }
  else if (levels[currLevelIndex].win == true && gameWon == true){
    resetLevels();    
  }

}

void gameOver(){
  //if (levels[currLevelIndex].win == false && pause == true){    
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
    text("Time:" + levels[currLevelIndex].time, width/2, (height/2)+50);
    text("Score:" + levels[currLevelIndex].score, width/2, (height/2)+100);
    text("Lives Remaining:" + levels[currLevelIndex].lives, width/2, (height/2)+150);
    textSize(30);
    text("PRESS THE MOUSE TO RESTART",width/2, (height/2)+350);
    
    if(mousePressed){
      resetLevels();
    }
  //}  
}

void resetLevels(){
  for(int i = currLevelIndex; i>= 0; i--){
    levels[i].reset();
  }
  currLevelIndex=0;
  pause = false;
  start = false;
  startLevel = false;
  gameWon = false;
}

void gameWin(){
  if (gameWon == true){
    background(185, 14, 198); // Colour the background blue
    
    fill(22, 245, 61, 127);
    rectMode(CENTER);
    rect(width/2, (height/2)-25, width, 180);
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text("Game Won!", width/2, height/2);  
    //textSize(45);
    textSize(30);
    text("PRESS THE MOUSE TO RESTART",width/2, (height/2)+350);  
  }
}
