int currLevel = 1;
//Level levels[] = new Level[3];
Level level1 = new Level(1, 16, 4, 80, 75, 60);
Level level2 = new Level(2, 8, 3, 100, 240, 80);
Level level3 = new Level(3, 16, 4, 80, 75, 60);

Slider gameSlider = new Slider();
Ball gameBall = new Ball();

//int[] l = 
boolean start = false;
boolean help = true;
boolean startLevel = false;
boolean pause = false;

int textY=45; 
int[] score = new int[]{ 0,0,0 };
int[] lives = new int[]{ 3,3,3 };

void setup() {
  size(1200, 900);
  background(0); // Colour Background Black
  level1.createBlocks();
  level2.createBlocks();
  level3.createBlocks();
}

void draw() {
  if (help == true){
    instructions();
  }
  else if (start == false) {
    startScreen();
  }
  else {
    gamePlay();
  }
}


int eyeWidth = 50;
int eyeHeight = 100;
int faceDimensions = 550;
int mouthWidth = 200;
int mouthHeight = 200; 

void transition(){ // Display Win to the user
  background(23, 14, 129); // Colour the background blue
  fill(227, 234, 17); // Colour the face yellow
  circle(width/2, height/2, faceDimensions);
  fill(0); // Colour the eyes and smile black
  
  // Eyes
  ellipse( (width/2) - 100, (height/2)-100, eyeWidth, eyeHeight);
  ellipse( (width/2) + 100, (height/2)-100, eyeWidth, eyeHeight);
  
  // Smiling Mouth
  arc(width/2, (height/2)+70, mouthWidth, mouthHeight, 0, PI);
  
  textSize(100);
  fill(246, 250, 217); // Colour the text offwhite
  textAlign(CENTER);
  text("LEVEL WON", width/2, 150);  
  text("Score:" + score[currLevel], width/2, height-100);
  text("CONTINUE",width/2, (height/2)+350);
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
  println(mouseX, mouseY);
}

void instructions(){
  background(0);
  textSize(25);
  textAlign(CENTER);
  text("HOW TO PLAY", width/2, 100);
  text("CONTINUE",width/2, (height/2)+350);
  //stroke(255);
  //line(width/2, 0, width/2, height);
  //println(mouseX, mouseY);
}

void gamePlay() {
  background(0);// Recolour Background Black
  score();
  remainingLives();
  if (currLevel == 1){
     level1.displayBlocks();
     level1.endOfLevel();
  }
  else if (currLevel ==2 ){
     level2.displayBlocks(); 
     level2.endOfLevel();
  }
  else if (currLevel == 3){
     level3.displayBlocks(); 
     level3.endOfLevel();
  }
  gameSlider.display();
  gameSlider.shift();
  
  gameBall.display();
  gameBall.ballStart();
  gameBall.update();
  if (currLevel == 1){
     gameBall.collision(level1);
  }
  else if (currLevel ==2 ){
     gameBall.collision(level2);     
  }
  else if (currLevel == 3){
     gameBall.collision(level3);
  }
  gameBall.outOfBounds();
        
}
void score() { // Display the game score
  textSize(43);
  fill(45, 247, 66); // Colour the score text green;
  textAlign(LEFT);
  text("Score: " + score[currLevel-1], 0, textY);
}

void remainingLives() {
  textSize(43);
  fill(45, 247, 66); // Colour the lives text green;
  textAlign(RIGHT);
  text("Lives: " + lives[currLevel-1], width-100, textY);
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
  else if (pause == true){
    
  }
}
