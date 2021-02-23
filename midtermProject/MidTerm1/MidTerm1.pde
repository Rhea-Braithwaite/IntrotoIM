final int BLOCKWIDTH = 200;
final int BLOCKHEIGHT =75;

class Block {
  int x, y, blockWidth, blockHeight, damage;
  color blockColour;
  boolean obstacle;
  
  Block(int xpos, int ypos, boolean condition) {
    x = xpos;
    y = ypos;
    blockWidth = BLOCKWIDTH;
    blockHeight = BLOCKHEIGHT;
    obstacle = condition ;
    damage = 0;
    if (obstacle == false){
      blockColour = color(0, random(255), random(255));
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

//level 1;
int level1Blocks = 16;
int level1Rows = 4;
int level1YPos = 80;
int level1XGap = 75;
int level1YGap = 60;

//Level2
int level2Blocks = 8;
int level2Rows = 3;
int level2YPos = 100;
int level2XGap = 240;
int level2YGap = 80;

//Level3
int level3Blocks = 16;
int level3Rows = 4;
int level3YPos = 80;
int level3XGap = 75;
int level3YGap = 60;

int level = 3;
Block[] level1 = new Block[level1Blocks];
Block[] level2 = new Block[level2Blocks];
Block[] level3 = new Block[level3Blocks];

void setup() {
  size(1200, 900);
  background(0); // Colour Background Black
  createBlocks(1, level1, level1Rows, level1YPos, level1XGap, level1YGap);
  createBlocks(2, level2, level2Rows, level2YPos, level2XGap, level2YGap);
  createBlocks(3, level3, level3Rows, level3YPos, level3XGap, level3YGap);
}


void draw() {
  background(0);// Recolour Background Black
  displayBlocks();
}

void createBlocks(int level, Block[] blocks, int rows, int yPos, int XGAP, int YGAP){

  if (level == 1 || level == 3){
      int numberOfRows = 0;
      int blockIndex = 0;
      
    while(numberOfRows<rows && yPos<(height-BLOCKHEIGHT)) { // Track the number of rows that have been created and ensures the rows do not go offscreen
      
      for (int xPos = XGAP; xPos<(width-BLOCKWIDTH); xPos += (XGAP+BLOCKWIDTH)){ // Change the x Position for each new Block 
        if (level == 3 && (blockIndex == 0 || blockIndex == 3 || blockIndex == 12 || blockIndex == 15)){
          blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
        }
        else{
          blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
        }
        blockIndex++;// Increment the block index
      }
      numberOfRows = numberOfRows + 1; // Increment the number of created rows
      yPos += (YGAP+BLOCKHEIGHT); // Increase the y Position for the next Row
    } 
  }
  else{
      int blockIndex = 0;  
      //row 1
      for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (XGAP+BLOCKWIDTH)){ // Change the x Position for each new Block 
        if (blockIndex == 1){
          blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block (obstacle)
        }
        else{
          blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
        }
        blockIndex++;// Increment the block index
      }
      yPos += (YGAP+BLOCKHEIGHT); // Increase the y Position for the next Row
      
      //row 2
      for (int xPos = 260; xPos<(width-BLOCKWIDTH); xPos += (XGAP+BLOCKWIDTH)){ // Change the x Position for each new Block 
        if (blockIndex == 1 || blockIndex == 6){
          blocks[blockIndex] = new Block(xPos, yPos, true); // Create each individual block
        }
        else{
          blocks[blockIndex] = new Block(xPos, yPos, false); // Create each individual block
        }
        blockIndex++;// Increment the block index
      }
      yPos += (YGAP+BLOCKHEIGHT); // Increase the y Position for the next Row    
      
      //row 3
      for (int xPos = 60; xPos<(width-BLOCKWIDTH); xPos += (XGAP+BLOCKWIDTH)){ // Change the x Position for each new Block 
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

void displayBlocks() { //Display Current Blocks
  if (level == 1){
     for (int i=0; i<level1Blocks; i++) {
      level1[i].display();
      }     
  }
  else if (level ==2 ){
     for (int i=0; i<level2Blocks; i++) {
      level2[i].display();
      }         
  }
  else if (level == 3){
     for (int i=0; i<level3Blocks; i++) {
      level3[i].display();
      }     
  }
 
}
