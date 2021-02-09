final int XGAP = 75;
final int YGAP = 60;
final int ROWS = 4;
final int NUMBEROFSTARS = 300;

int NumberofValues = 16;
int numberOfRows = 0;
int yPos = 80;
int blockIndex = 0;
int score = 0;
int lives = 5;
boolean win = false;


Slider gameSlider = new Slider();
Ball gameBall = new Ball();
Block[] gameBlocks = new Block[NumberofValues];
Star[] gameStars = new Star[NUMBEROFSTARS];


void setup() {
  size(1200, 900);
  background(0); // Colour Background Black
  createBlocks();// Create Game Blocks
  createStars(); // Create stars for game background
}


void draw() {
  background(0);// Recolour Background Black
  
  if (lives > 0) { // If the user still has remaining lives
    if (win == false) {// If the user has not won yet, the game continues
      shiftStars();
      
      displayBlocks();
      
      gameSlider.display();
      gameSlider.shift();
      
      gameBall.display();
      gameBall.ballStart();
      gameBall.update();
      gameBall.collision();
      gameBall.outOfBounds();
      
      remainingLives();
      score();
    }
    else { // If the user has won the game, display win screen
      gameWin();
    }
  }
  else { // If the user has lost the game, display game over screen
    gameOver();
  }
}

void createBlocks() { // Creates the game blocks
  while(numberOfRows<ROWS && yPos<(height-BLOCKHEIGHT)) { // Track the number of rows that have been created and ensures the rows do not go offscreen
    
    for (int xPos = XGAP; xPos<(width-BLOCKWIDTH); xPos += (XGAP+BLOCKWIDTH)){ // Change the x Position for each new Block 
      gameBlocks[blockIndex] = new Block(xPos, yPos); // Create each individual block
      blockIndex++;// Increment the block index
    }
    numberOfRows = numberOfRows + 1; // Increment the number of created rows
    yPos += (YGAP+BLOCKHEIGHT); // Increase the y Position for the next Row
  }

}

void displayBlocks() { //Display Current Blocks
  for (int i=0; i<NumberofValues; i++) {
      gameBlocks[i].display();
  }     
}

int textY=45; 


void score() { // Display the game score
  textSize(43);
  fill(45, 247, 66); // Colour the score text green;
  textAlign(LEFT);
  text("Score: " + score, 0, textY);
}

void remainingLives() {
  textSize(43);
  fill(45, 247, 66); // Colour the lives text green;
  textAlign(RIGHT);
  text("Lives: " + lives, width-100, textY);
}


int eyeWidth = 50;
int eyeHeight = 100;
int faceDimensions = 550;
int mouthWidth = 200;
int mouthHeight = 200;

void gameOver(){ // Display Game Over to the user
  background(165, 6, 0); // Colour the background red
  fill(227, 234, 17); // Colour the face yellow
  circle(width/2, height/2, faceDimensions);
  fill(0); // Colour the eyes and smile black
  
  // Eyes 
  ellipse( (width/2) - 100, (height/2)-100, eyeWidth, eyeHeight);
  ellipse( (width/2) + 100, (height/2)-100, eyeWidth, eyeHeight);
  
  // Frowning mouth
  arc(width/2, (height/2)+130, mouthWidth, mouthHeight, PI,TWO_PI, CHORD);
  
  textSize(100);
  fill(0); // Colour the text black
  textAlign(CENTER);
  text("GAME OVER", width/2, 150);  
  
  text("Score:" + score, width/2, height-100);  
}

void gameWin(){ // Display Win to the user
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
  text("YOU WIN", width/2, 150);  
  text("Score:" + score, width/2, height-100);

}

void createStars(){ // Create the stars for the background
  for (int i=0; i<NUMBEROFSTARS; i++) {
    gameStars[i] = new Star();
  }
}

void shiftStars() { // Shift the position of each star and display them on screen
  for (int i=0; i<NUMBEROFSTARS; i++) {
    gameStars[i].update();
    gameStars[i].display();
    
  }  
}
