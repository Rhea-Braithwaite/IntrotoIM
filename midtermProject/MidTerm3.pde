int level = 3;
Level level1 = new Level(1, 16, 4, 80, 75, 60);
Level level2 = new Level(2, 8, 3, 100, 240, 80);
Level level3 = new Level(3, 16, 4, 80, 75, 60);

Slider gameSlider = new Slider();
Ball gameBall = new Ball();
int lives = 3;
//int[] l = 
boolean start = false;

void setup() {
  size(1200, 900);
  background(0); // Colour Background Black
  level1.createBlocks();
  level2.createBlocks();
  level3.createBlocks();
}

void draw() {
  if (start == false) {
    startScreen();
  }
  else {
    gamePlay();
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
  
  // Help Button
  textSize(35);
  noFill();
  circle(1120, 30, 50);
  fill(0);
  text("?",1121, 42);
  help();
  
  // Start Button
  text("START",width/2, (height/2)+350);
  //println(mouseX, mouseY);
}

void help() {
  if(mouseX >= 1095 && mouseX <= 1145 && mouseY>= 5 && mouseY<=55) {
    fill(0, 0, 0, 127);
    rect(950, 30, 400, 600);
  }
}
void gamePlay() {
  background(0);// Recolour Background Black
  if (level == 1){
     level1.displayBlocks();
  }
  else if (level ==2 ){
     level2.displayBlocks();       
  }
  else if (level == 3){
     level3.displayBlocks(); 
  }
  gameSlider.display();
  gameSlider.shift();
  
  gameBall.display();
  gameBall.ballStart();
  gameBall.update();
  if (level == 1){
     gameBall.collision(level1);
  }
  else if (level ==2 ){
     gameBall.collision(level2);     
  }
  else if (level == 3){
     gameBall.collision(level3);
  }
  gameBall.outOfBounds();
        
}

void mousePressed() {
  if (start == false && mouseX>= 545 && mouseX <= 650 && mouseY >= 775 && mouseY<= 800){
    start = true;
  }
}
