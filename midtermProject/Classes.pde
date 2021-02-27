  
final int BLOCKWIDTH = 200;
final int BLOCKHEIGHT =75;

class Block {
  int x, y, blockWidth, blockHeight, damage;
  color blockColour;
  boolean obstacle, show;
  
  Block(int xpos, int ypos, boolean condition) {
    x = xpos;
    y = ypos;
    blockWidth = BLOCKWIDTH;
    blockHeight = BLOCKHEIGHT;
    obstacle = condition ;
    show = true;
    damage = 0;
    if (obstacle == false){
      blockColour = color(0, random(100, 255), random(100, 255));
    }
    else {
      blockColour = color(255, 0, 0);
    }
  }
  
  void display() {
    fill(blockColour);
    rectMode(CORNER);
    rect(x, y , blockWidth , blockHeight, 7); // Display the block
  }
}

class Level {
  int numOfBlocks, rows, yPos, xGap, yGap, gameLevel, blocksRemaining, score, lives;
  Block[] blocks;
  boolean win;
  float time;
  
  Level(int level, int totalBlocks, int numOfRows, int yPosition, int verticalGap, int horizontalGap, int numOfObstacles) {
    gameLevel = level;
    numOfBlocks = totalBlocks;
    blocksRemaining = totalBlocks-numOfObstacles;
    rows = numOfRows;
    yPos = yPosition;
    xGap = verticalGap;
    yGap = horizontalGap;
    blocks = new Block[numOfBlocks];
    win = false;
    score = 0;
    lives = 3;
    time = 0;
  }
  
  void createBlocks(){

    if (gameLevel == 1 || gameLevel == 3){
        int numberOfRows = 0;
        int blockIndex = 0;
        
      while(numberOfRows<rows && yPos<(height-BLOCKHEIGHT)) { // Track the number of rows that have been created and ensures the rows do not go offscreen
        
        for (int xPos = xGap; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (gameLevel == 3 && (blockIndex == 0 || blockIndex == 3 || blockIndex == 12 || blockIndex == 15)){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
          }
          blockIndex++;// Increment the block index
        }
        numberOfRows = numberOfRows + 1; // Increment the number of created rows
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row
      } 
    }
    else{
        int blockIndex = 0;  
        //row 1
        for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 1){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
          }
          blockIndex++;// Increment the block index
        }
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row
        
        //row 2
        for (int xPos = 260; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 1 || blockIndex == 6){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
          }
          blockIndex++;// Increment the block index
        }
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row    
        
        //row 3
        for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 6){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
          }
          blockIndex++;// Increment the block index
        }
      }    
  }
  
  void displayBlocks(){
     for (int i=0; i<numOfBlocks; i++) {
       if(blocks[i].show == true){
          blocks[i].display();
       }
      }         
  }
  void score() { // Display the game score
    textSize(43);
    fill(45, 247, 66); // Colour the score text green;
    textAlign(LEFT);
    text("Score: " + levels[currLevelIndex].score, 0, textY);
  }

  void remainingLives() {
    textSize(43);
    fill(45, 247, 66); // Colour the lives text green;
    textAlign(RIGHT);
    text("Lives: " + levels[currLevelIndex].lives, width-100, textY);
  }
  void endOfLevel(){
    if (lives != 0 && blocksRemaining == 0 ){
      startLevel = false;
      gameBall.reset();
      pause = true;
      win = true;
    }
    else if (lives == 0){
      startLevel = false;
      gameBall.reset();
      win = false;
      pause = true;
    }
  }
  
 void reset() {
   score = 0;
   lives = 3;
   win = false;
   for(int i=0; i<numOfBlocks; i++){
     blocks[i].show = true;
     blocks[i].damage = 0;
   }
 }
}

// Slider Variables
final int SLIDERX = 600;
final int SLIDERY = 800;
final int SLIDERWIDTH = 300;
final int SLIDERHEIGHT = 50;

class Slider {
  int x, y, sWidth, sHeight;
  
  Slider() {
    x = SLIDERX;
    y = SLIDERY;
    sWidth = SLIDERWIDTH;
    sHeight = SLIDERHEIGHT;
  }
  
  void display() {
    fill(43, 12, 173); //Colour Circle and Slider White
    rectMode(CENTER);
    rect(x, y, sWidth, sHeight, 10); //Draw slider    
  }
  
  void shift() {
    //If the ball is moving, move the slider based on the mouse's X location. Keep the slider within the screen dimensions 
    if (gameBall.inMotion == true && mouseX+(sWidth/2)<=width && mouseX-(sWidth/2)>=0 ){ 
      x = mouseX;    
    }
  }
  
  void reset() { //Reset the slider's position to the middle of the screen
    x = SLIDERX;
    y = SLIDERY;    
  }
}

// Ball variables
final int BALLX = 600;
final int BALLY = 750;
final int INITIALSPEED = 0;
int tempX, tempY, index;
float tempXSpeed, tempYSpeed;
boolean remove = false;

class Ball {
  
  int[] xOptions = new int[2];
  {
    xOptions[0] = 5; // Speed option 1
    xOptions[1] = -5; // Speed option 2
  }

  int x, y, radius;
  float xSpeed, ySpeed;
  boolean inMotion;
  
  Ball(){
    x = BALLX;
    y = BALLY;
    radius = 25;
    xSpeed = INITIALSPEED;
    ySpeed = INITIALSPEED;
    inMotion = false;
  
  }
  
  void display() { 
    circle(x, y, radius*2); // Display the ball
  }
  
  void ballStart() {
    if (startLevel == true && inMotion == false ) { // If the ball is not moving and the mouse has been pressed, the ball starts moving
        inMotion = true;
        xSpeed = xOptions[int(random(0, 2))]; // Randomly choose the XSpeed
        ySpeed = -5; // Randomly choose the YSpeed
    }
  }
  void reset() { // Reset the ball's location back to the original point
    inMotion = false;
    startLevel = false;
    x = BALLX;
    y = BALLY;
    xSpeed = INITIALSPEED;
    ySpeed = INITIALSPEED;
    gameSlider.reset(); //Reset the sldier's position
  }
  
  void collision() {
    if (x<radius || x+radius>width ) { // Change directions if the ball is at the left or right border of the screen
      xSpeed = -xSpeed;
    }
    if (y<radius) { // Change directions if the ball is at the top border of the screen
      ySpeed = -ySpeed;
    } 
    
    // Change directions if the ball hits the slider
    if (x+radius >= (gameSlider.x-(SLIDERWIDTH/2)) && x-radius <= (gameSlider.x +(SLIDERWIDTH/2)) && y+radius >= SLIDERY-(SLIDERHEIGHT/2)) {
      ySpeed = -ySpeed;
  
    }
    
    for (int i=0; i< levels[currLevelIndex].numOfBlocks; i++) {
      // If the ball collides with a block
      if (levels[currLevelIndex].blocks[i].show == true) {
        if(x+radius >= levels[currLevelIndex].blocks[i].x && x-radius <= (levels[currLevelIndex].blocks[i].x + BLOCKWIDTH) && y+radius >= levels[currLevelIndex].blocks[i].y && y-radius <= (levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT)){
          if (levels[currLevelIndex].blocks[i].obstacle == false){
            levels[currLevelIndex].blocks[i].damage ++;
             if (levels[currLevelIndex].blocks[i].damage == 1) {
               levels[currLevelIndex].blocks[i].show = false;
               levels[currLevelIndex].blocksRemaining --;
               //print(level.blocksRemaining);
             }
          }
          
          tempX = x;
          tempY = y;
          tempXSpeed = -xSpeed;
          tempYSpeed = -ySpeed;
          
          tempX += tempXSpeed;
          tempY += tempYSpeed;
          
          // Test to see which speed should be changed
          
          // If a change in the X Speed of the ball still presents a collision with the same block, change the Y Speed
          if(tempX+radius >= levels[currLevelIndex].blocks[i].x && tempX-radius <= (levels[currLevelIndex].blocks[i].x + BLOCKWIDTH) && y+radius >= levels[currLevelIndex].blocks[i].y && y-radius <= (levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT)){
            ySpeed = -ySpeed;
          }
          else {
            // If a change in the Y Speed of the ball still presents a collision with the same block, change the X Speed
            if(x+radius >= levels[currLevelIndex].blocks[i].x && x-radius <= (levels[currLevelIndex].blocks[i].x + BLOCKWIDTH) && tempY+radius >= levels[currLevelIndex].blocks[i].y && tempY-radius <= (levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT)){
              xSpeed = -xSpeed;
            }
          } 
        }
      }
    }
  }
  
  void outOfBounds() {
    if (y+radius == height) { //If the ball reaches the bottom of the screen reset its position
      reset();
      levels[currLevelIndex].lives --; //Decrement the number of lives by 1
    }
  }
  
  void update() { //Update the ball's x and y position based the x and y speeds;
    x += xSpeed;
    y += ySpeed;
  }
}
