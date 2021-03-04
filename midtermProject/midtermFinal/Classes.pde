// Circle Variables
int circleDim = 3;

class Circle {
  int x, y;
  
  Circle() {
    x = int(random(float(width))); // Assign a random value to the x position
    y = int(random(float(height))); // Assign a random value to the y position
  }
  
  void display(){
    stroke(0, transparency);
    circle(x, y, circleDim);
  }
}

// Block Variables
final int BLOCKWIDTH = 200;
final int BLOCKHEIGHT = 75;

class Block {
  int x, y, blockWidth, blockHeight, damage;
  color blockColour;
  boolean obstacle, show;
  PImage damage1, damage2;
  
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
    damage1 = blockDamage1;
    damage2 = blockDamage2;
  }
  
  void display() {
    fill(blockColour);
    rectMode(CORNER);
    rect(x, y , blockWidth , blockHeight, 7); // Display the block
    if (damage == 1){ // If the block has been hit once display the first set of cracks
      image(damage1, x, y-4, blockWidth, blockHeight+4);
    }
    else if (damage == 2){ // If the block has been hit twice display the second set of cracks
      image(damage2, x, y-2, blockWidth, blockHeight+3);
    }
  }
}

class Level {
  int numOfBlocks, rows, yPos, xGap, yGap, gameLevel, blocksRemaining, score, lives, numOfObstacles, minutes, seconds, bonus;
  Block[] blocks;
  boolean win;
  PImage damage1, damage2;
  
  Level(int level, int totalBlocks, int numOfRows, int yPosition, int verticalGap, int horizontalGap, int obstacles) {
    gameLevel = level;
    numOfBlocks = totalBlocks;
    blocksRemaining = totalBlocks-obstacles;
    numOfObstacles = obstacles;
    rows = numOfRows;
    yPos = yPosition;
    xGap = verticalGap;
    yGap = horizontalGap;
    blocks = new Block[numOfBlocks];
    win = false;
    score = 0;
    lives = 3;
    bonus = 0;
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
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block (regular blocks)
          }
          blockIndex++;// Increment the block index
        }
        numberOfRows = numberOfRows + 1; // Increment the number of created rows
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row
      } 
    }
    else{
        // Level 2
        int blockIndex = 0;  
        // Row 1
        for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 1){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block (regular blocks)
          }
          blockIndex++;// Increment the block index
        }
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row
        
        // Row 2
        for (int xPos = 260; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 1 || blockIndex == 6){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block (regular blocks)
          }
          blockIndex++;// Increment the block index
        }
        yPos += (yGap+BLOCKHEIGHT); // Increase the y Position for the next Row    
        
        // Row 3
        for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (xGap+BLOCKWIDTH)){ // Change the x Position for each new Block 
          if (blockIndex == 6){
            blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
          }
          else{
            blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block (regular blocks)
          }
          blockIndex++;// Increment the block index
        }
      }    
  }
  
  void displayBlocks(){ // Display all blocks that are not destroyed
     for (int i=0; i<numOfBlocks; i++) {
       if(blocks[i].show == true){
         blocks[i].display();
        }
      }         
  }
  void updateScore(){ // Update the level score for every hit
    score += 50;
  }
  
  void score() { // Display the level score
    textSize(43);
    fill(45, 247, 66); // Colour the score text green;
    textAlign(LEFT);
    text("Score: " + levels[currLevelIndex].score, 0, textY);
  }

  void remainingLives() { // Display the level lives
    textSize(43);
    fill(45, 247, 66); // Colour the lives text green;
    textAlign(CENTER);
    text("Lives: " + levels[currLevelIndex].lives, (width/2), textY);
  }
  
  void endOfLevel(){
    if (lives != 0 && blocksRemaining == 0 ){ // If the level is won (all blocks are destroyed before all lives are lost)
      bonus();
      startLevel = false; // Stop the Level
      gameBall.reset(); // Reset the ball position
      pause = true; // Display the Level Won Screen
      win = true; // Level has been won
    }
    else if (lives == 0){ // If the level is lost (all lives are lost before all blocks are destroyed)
      startLevel = false; // Stop the Level
      gameBall.reset(); // Reset the ball position
      win = false; // Level has been won
      pause = true; // Display the Game Over Screen
    }
  }
  
 void reset() { // Reset the level variables to their original values
   score = 0; 
   lives = 3;
   win = false;
   blocksRemaining = numOfBlocks-numOfObstacles; 
   
   for(int i=0; i<numOfBlocks; i++){ // Make visible all blocks again
     blocks[i].show = true;
     blocks[i].damage = 0;
   }
   minutes = 0;
   seconds = 0;
 }
 
 void updateTime() { 
   if(frames%60 == 0 && frames != 0){ // If frames is 60 and it s not the intial number of frames then a second has passed
     seconds += 1;
   }
   
   if(seconds == 60){ // If 60 seconds have passed
     minutes +=1;
     seconds = 0;
   }
 }
 
 void displayTime() { // Display the amount of time that has passed since the game has started
    textSize(43);
    fill(45, 247, 66); // Colour the score text green;
    textAlign(LEFT);
    if (seconds == 0){
      text("Time: " +minutes+":00", width-250, textY);
    }
    else if (seconds < 10){
      text("Time: " +minutes+":0"+seconds, width-250, textY);  
    }
    else{
      text("Time: " +minutes+":"+seconds, width-250, textY);  
    }
     
 }
 
 void bonus(){ // Determine level bonus based on the amount of time that has passed
   if (minutes < 0 && seconds <30){
     bonus = 100;
   }
   else if(minutes<=1){
     bonus=50;
   }
   else if(minutes<=2){
     bonus = 30;
   }
   if (bonusAdded == false){
     score += bonus;
     bonusAdded = true;
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
  float xSpeed, ySpeed, firstXSpeed, firstYSpeed;
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
        firstXSpeed = xSpeed;
        firstYSpeed = ySpeed;
        ySpeed = -5; 
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
    if (x+radius >= (gameSlider.x-(SLIDERWIDTH/2)) && x-radius <= (gameSlider.x +(SLIDERWIDTH/2)) && y+radius >= gameSlider.y-(SLIDERHEIGHT/2)) {
      
      // If the ball's x position is within the x range of the slider 
      if (x >= (gameSlider.x-(SLIDERWIDTH/2)) && x <= (gameSlider.x +(SLIDERWIDTH/2))){
        y = gameSlider.y-(SLIDERHEIGHT/2)-radius; // Then make the ball's bottom section touch the slider (the ball's y position is radius distance from the slider's top edge)
        ySpeed = -ySpeed; 
      }
      
      // If the ball's y position is within the top half to the center of the slider 
      else if(y >= gameSlider.y-(SLIDERHEIGHT/2) && y <= gameSlider.y){
          if (x < (gameSlider.x-(SLIDERWIDTH/2))){ // If the ball's center is to the left of the slider
            x = (gameSlider.x-(SLIDERWIDTH/2)) - radius; // Then make the ball's right section touch the slider (the ball's x position is radius distance from the slider's left edge)
          }
          else if (x > (gameSlider.x+(SLIDERWIDTH/2))){ // If the ball's center is to the right of the slider 
            x = (gameSlider.x+(SLIDERWIDTH/2)) + radius; // Then make the ball's left section touch the slider (the ball's x position is radius distance from the slider's right edge)
          }
          xSpeed = -xSpeed;
          ySpeed = -ySpeed;
      }
      // For collision with the corners of the slider
      // If the ball's x position is within the x range of the slider
     else if (x > (gameSlider.x +(SLIDERWIDTH/2)) || x < (gameSlider.x -(SLIDERWIDTH/2))){{
       
         y = gameSlider.y-(SLIDERHEIGHT/2)-radius; // Then make the ball touch the slider (the ball's y position is radius distance from the slider's top right or left corner)
         ySpeed = -ySpeed;
       }
     }
     else if (y > gameSlider.y){ // If the ball's y position is past the center of the slider
        if (x < (gameSlider.x-(SLIDERWIDTH/2))){ // If the ball is to the left of the slider
          x = (gameSlider.x-(SLIDERWIDTH/2)) - radius; // Then make the ball's right section touch the slider (the ball's x position is radius distance from the slider's left edge)
        }
        else { // If the ball is to the right of the slider
          x = (gameSlider.x+(SLIDERWIDTH/2)) + radius; // Then make the ball's left section touch the slider (the ball's x position is radius distance from the slider's right edge)
        }  
        xSpeed = -xSpeed;
     }
    }
    
    
    for (int i=0; i< levels[currLevelIndex].numOfBlocks; i++) {
      
      if (levels[currLevelIndex].blocks[i].show == true) { //If the block has not been destroyed yet
        // If the ball collides with a block
        if(x+radius >= levels[currLevelIndex].blocks[i].x && x-radius <= (levels[currLevelIndex].blocks[i].x + BLOCKWIDTH) 
        && y+radius >= levels[currLevelIndex].blocks[i].y && y-radius <= (levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT)){
          
          hit.play(); // Play the sound file for a collision with a block
          
          if (levels[currLevelIndex].blocks[i].obstacle == false){ //Checks if the block is not an obstacle
            levels[currLevelIndex].blocks[i].damage ++; //If it is not an obstacle, then increment the block's damage
            levels[currLevelIndex].updateScore(); 
             if (levels[currLevelIndex].blocks[i].damage == 1) { // If the damage variable is 3 (maximum damage), then "destroy" the block by not displaying it.
               levels[currLevelIndex].blocks[i].show = false; 
               levels[currLevelIndex].blocksRemaining --; // Decrement the number of remaining blocks
               increaseSpeed();
             }
          }
          
          // If the ball's x position is within the x range of the block 
          if (x >= levels[currLevelIndex].blocks[i].x && x <= levels[currLevelIndex].blocks[i].x + BLOCKWIDTH){
            if (y <=levels[currLevelIndex].blocks[i].y){ // If the ball is above the block
              y = levels[currLevelIndex].blocks[i].y -radius; // Then make the ball's bottom section touch the cblock (the ball's y position is radius distance from the block's top edge)
            }
            else if (y >= levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT){ // If the ball is below the slider
              y = levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT+ radius; // Then make the ball's top section touch the block (the ball's y position is radius distance from the block's bottom edge)
            }
            ySpeed = -ySpeed;
          }
          // If the ball's y position is within the y range of the block 
          else if(y >= levels[currLevelIndex].blocks[i].y && y <= levels[currLevelIndex].blocks[i].y+BLOCKHEIGHT){
            if (x < levels[currLevelIndex].blocks[i].x){ // If the ball is to the left of the block
              x = levels[currLevelIndex].blocks[i].x - radius; // Then make the ball's right section touch the block (the ball's x position is radius distance from the block's left edge)
            }
            else if (x > levels[currLevelIndex].blocks[i].x + BLOCKWIDTH){ // If the ball is to the right of the block
              x = levels[currLevelIndex].blocks[i].x+radius + BLOCKWIDTH; // Then make the ball's left section touch the block (the ball's x position is radius distance from the block's right edge)
            }
            xSpeed = -xSpeed;
          }
          else {
            // For collision with the corners of the block
            
            if(x > levels[currLevelIndex].blocks[i].x + BLOCKWIDTH){ // If the ball is to the right of the block
              if ( y < levels[currLevelIndex].blocks[i].y){ // If the ball is above the block
                y = levels[currLevelIndex].blocks[i].y - radius; // Then make the ball touch the slider (the ball's y position is radius distance from the slider's top right corner)
                ySpeed = -ySpeed;  
            }
              else if (y > levels[currLevelIndex].blocks[i].y+BLOCKHEIGHT){ // If the ball is below the block
                y = levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT+ radius; // Then make the ball touch the block (the ball's y position is radius distance from the slider's bottom right corner)           
                ySpeed = -ySpeed;   
            }
            }
            else if (x<levels[currLevelIndex].blocks[i].x){ // If the ball is to the left of the block
              if ( y < levels[currLevelIndex].blocks[i].y){ // If the ball is above the block
                y = levels[currLevelIndex].blocks[i].y - radius; // Then make the ball touch the block (the ball's y position is radius distance from the slider's top left corner) 
                ySpeed = -ySpeed;
              }
              else if (y > levels[currLevelIndex].blocks[i].y+BLOCKHEIGHT){ // If the ball is below the block 
                y = levels[currLevelIndex].blocks[i].y + BLOCKHEIGHT+ radius; // Then make the ball touch the block (the ball's y position is radius distance from the slider's bottom left corner)              
                ySpeed = -ySpeed; 
            }              
            }
          }
        }
      }
    }
  }
  
  
  void outOfBounds() {
    if (y+radius >= height) { //If the ball reaches the bottom of the screen reset its position
      reset();
      levels[currLevelIndex].lives --; //Decrement the number of lives by 1
    }
  }
  
  void update() { //Update the ball's x and y position based on the x and y speeds;
    x += xSpeed;
    y += ySpeed;
  }
  
  void increaseSpeed(){
    if(currLevelIndex!=0){ // For levels 2 and 3
      if (xSpeed < 0){
        xSpeed -= 1;
      }
      else{
        xSpeed += 1;
      }
      
      if(ySpeed <0){
        ySpeed -= 1;
      }
      else{
        ySpeed += 1;
      }
    }
  }
}

 // Star Variables
int starWidth = 1;
int starHeight = 15;

class Star {
  float x, y, xSpeed, ySpeed;
  
  Star(){
    x = random(0, width); // Assign a random value to the x position
    y = random(-500, 0); // Assign a random value to the y position
    xSpeed = 0.5;
    ySpeed = random(1, 4); // Assign a random value to the ySpeed
  }
  
  void update() { // Change the x and y position of each star based on its x and y speed
    x += xSpeed;
    y += ySpeed;
    
    if (y>= height) { // If the star has arrived at the bottom of the screen reset the position
      reset();
    }
  }
  
  void display() {
    fill(250, 243, 202); // Colour the star off white
    rect(x, y, starWidth, starHeight); // Display the star
  }
  
  void reset() { // Change the star's position to a new point
    x = random(0, width);
    y = random(-700, 0);
  }
}
