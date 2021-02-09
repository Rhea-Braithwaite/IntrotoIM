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
    if (mousePressed && inMotion == false) { // If the ball is not moving and the mouse has been pressed, the ball starts moving
        inMotion = true;
        xSpeed = xOptions[int(random(0, 2))]; // Randomly choose the XSpeed
        ySpeed = -5; // Randomly choose the YSpeed
    }
  }
  void reset() { // Reset the ball's location back to the original point
    lives --; //Decrement the number of lives by 1
    inMotion = false;
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
    
    for (int i=0; i< NumberofValues; i++) {
      // If the ball collides with a block
      if(x+radius >= gameBlocks[i].x && x-radius <= (gameBlocks[i].x + BLOCKWIDTH) && y+radius >= gameBlocks[i].y && y-radius <= (gameBlocks[i].y + BLOCKHEIGHT)){
        remove = true; // The Block is to be removed
        index = i;
     
        tempX = x;
        tempY = y;
        tempXSpeed = -xSpeed;
        tempYSpeed = -ySpeed;
        
        tempX += tempXSpeed;
        tempY += tempYSpeed;
        
        // Test to see which speed should be changed
        
        // If a change in the X Speed of the ball still presents a collision with the same block, change the Y Speed
        if(tempX+radius >= gameBlocks[i].x && tempX-radius <= (gameBlocks[i].x + BLOCKWIDTH) && y+radius >= gameBlocks[i].y && y-radius <= (gameBlocks[i].y + BLOCKHEIGHT)){
          ySpeed = -ySpeed;
        }
        else {
          // If a change in the Y Speed of the ball still presents a collision with the same block, change the X Speed
          if(x+radius >= gameBlocks[i].x && x-radius <= (gameBlocks[i].x + BLOCKWIDTH) && tempY+radius >= gameBlocks[i].y && tempY-radius <= (gameBlocks[i].y + BLOCKHEIGHT)){
            xSpeed = -xSpeed;
          }
        }
        
      }
    }
    
    // If the ball has collided with a block, remove it from the game blocks array
    if (remove == true) {
      delete(index);
      remove = false;
    }
    
    
  }
  
  void outOfBounds() {
    if (y+radius == height) { //If the ball reaches the bottom of the screen reset its position
      reset();
    }
  }
  
  void update() { //Update the ball's x and y position based the x and y speeds;
    x += xSpeed;
    y += ySpeed;
  }
  
  void delete(int index) {
    
    // Iterate through the game blocks array and shift the blocks one position to the left from the block index to be deleted. 
    // Therefore the block to be deleted is overriden.
    for (int i=index; i<(NumberofValues-1); i++) { 
      gameBlocks[i]= gameBlocks[i+1];
    }
    NumberofValues --; // Decrement the number of existing blocks
    score += 100; // Increment the score   
    
      if (NumberofValues == 0){ // If there are no remaining blocks, the game has been won.
        win = true;
      }
  }  
}


// Block Variables
final int BLOCKWIDTH = 200;
final int BLOCKHEIGHT =75;


class Block {
  int x, y, blockWidth, blockHeight;
  color blockColour;
  
  Block(int xpos, int ypos) {
    blockColour = color(random(255), random(255), random(255)); // Randomly choose the colour of the block
    x = xpos;
    y = ypos;
    blockWidth = BLOCKWIDTH;
    blockHeight = BLOCKHEIGHT;
  }
  
  void display() {
    fill(blockColour);
    rectMode(CORNER);
    rect(x, y , blockWidth , blockHeight, 7); // Display the block
  }
  
}

// Star Variables
int starWidth = 5;
int starHeight = 30;

class Star {
  float x, y, xSpeed, ySpeed;
  
  Star(){
    x = random(0, width);
    y = random(-500, 0);
    xSpeed = 0.5;
    ySpeed = random(1, 4);
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
