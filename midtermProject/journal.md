# Block Breaker 2.0 
## Preliminary Description
Block Breaker is a single user game. It involves a ball being bounced around the screen, in an effort to hit all the blocks, destroying them in order to win the game.
The goal is to complete this task before all lives are lost or it is GAME OVER.
- The game is to begin with a welcome screen, which has a Start Button and a Help Button.
  - The Start Button – the user presses it to begin the game.
  - The Help Button – the user presses it to view the game instructions. 
- The game has 3 levels in total, increasing in difficulty after each level is passed. The user has 3 tries to finish the level or else it is Game Over, and the 
game begins again from Level 1. 
- After selecting the Start Button, Level 1 is displayed with the blocks for this level. The user presses the mouse to get the ball moving, and tries to hit all 
the blocks, breaking them. It takes 3 hits to destroy a block. Each time a block is hit, more cracks appear until the third hit where it is destroyed. If the ball 
misses the slider and hits the bottom of the screen, a life is lost, and the ball and slider’s position is reset.
- This continues until the level is won or all lives are lost, meaning Game Over. 
- If the user wins the level, a congratulations screen is displayed, with a continue button for the user to select to move on to the next level.
- Similar as above is Levels 2 and 3. The major difference now, is that there are now obstacles that cannot be broken by the ball, and after each block is hit the 
balls speed increased. If a life is lost, then the speed is reset.
- If the user wins all the levels, then a final congratulatory screen is displayed, and a Restart Button is displayed that the user can select to restart from Level 1. 

## February 22, 2001

### Accomplished Today:
- Design 2 Additional Levels
- Write the code to incorporate the different blocks for each level. 

#### Design for Additional Levels

##### Level 2

##### Level 3

#### Coding the Blocks for Each Level
For the blocks for each level, I used arrays. Each array had its own variables regarding the starting positions for each block, the number of rows, the vertical 
gaps as well as the horizontal gaps between each block. 

Then using a createBlocks Function, which accepted as arguments the empty level array and its corresponding variables, each array of blocks was created. 

Below you will see red blocks. These have been made to be obstacles; therefore, I needed a way to track them in the array. So, I made the block have an obstacle 
variable that is True or False. And when creating the blocks, depending on the index for the obstacles, the condition was True or False. 

#### Note
Because the number of blocks per level and the location of the obstacles were different for each level, I had to pass an integer which represented the specific 
level for the array of blocks being created.

Code for Creating the Blocks
````
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
````

#### Result:

##### Level 1

##### Level 2

##### Level 3

#### Reflections
- In hindsight, it makes sense to make a class for the levels themselves. Each with its own array of blocks, and corresponding variables for the number of rows, 
the vertical gaps as well as the horizontal gaps between each block. Technically, I am doing that now so a class would be a more effective approach.
- Doing the levels is a step in the right direction to creating the game, as without them, the game cannot work. 
- But I need to create the classes for the Levels because their respective array blocks will be used throughout the code. 


