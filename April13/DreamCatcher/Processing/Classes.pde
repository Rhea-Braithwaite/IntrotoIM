
// DreamCatcher Variables
final int DCX = 450;
final int DCY = 770;
final int DCWIDTH = 122;
final int DCHEIGHT = 170;
final int interv = 5;

class DreamCatcher {
  int x, y, dcWidth, dcHeight, interval, radius;
  PImage img;
  
  DreamCatcher() {
    x = DCX;
    y = DCY;
    dcWidth = DCWIDTH;
    dcHeight = DCHEIGHT;
    interval = interv;
    img = dc;
  }
  
  void display() {
    image(img, x, y, dcWidth, dcHeight);
  }
  
  void reset() { //Reset the slider's position to the middle of the screen
    x = DCX;
    y = DCY;    
  }
}

// Dream variables
final int DREAMWIDTH = 122;
final int DREAMHEIGHT = 170;
final int DREAMY = 0;
final int DREAMINTERVAL = 1;

class Dream {
  int x, y, dWidth, dHeight, interval, type;
  PImage img;
  boolean start, caught;
  
  Dream (PImage pic, int i){
    start = false;
    caught = false;
    x = int(random(DREAMWIDTH/2, width-(DREAMWIDTH/2)));;
    y = DREAMY;
    dWidth = DREAMWIDTH;
    dHeight = DREAMHEIGHT;
    interval = DREAMINTERVAL;
    img = pic;
    type = i;
  }
  
  void update(){ // Update the position of the dream, so that it falls down the screen on every even frame
    if (frameCount % 2 == 0){
      y = y + interval;
    }
  }
  
  void reset(){ // Reset the position of the dream at a random position
    x = int(random(DREAMWIDTH/2, width-(DREAMWIDTH/2)));
    y = DREAMY;
  }
  
  void catchDream(){ // If the dream collides with with the DreamCatcher it is caught or if dream reaches the bottom of the screen
    if ( (x - dWidth/2 >= gameDC.x - DCWIDTH) && (x + dWidth/2 <= gameDC.x + DCWIDTH) && (y - dHeight/2 >= gameDC.y - DCHEIGHT) && (y + dHeight/2 <= gameDC.y + DCHEIGHT) ){
      if (type == badDream){ // If it is a bad dream then the score increases
        score += 50; 
      }
      caught = true;
      start = false;
      reset();
    }  
    
    if (y >= height){ // If the dream reaches the bottom of the screen then reset its position
      if (type == goodDream){ // If a good dream reaches the bottom
        bonus += 20;
      }
      else{ // If a bad dream reaches the bottom of the screen then a life is lost
        lives --;  
        if(lives == 0){ // If all lives are lost, start the countdown for the display of the Game Over Screen
          check = frameCount;
        }
      }
      
      start = false;
      reset();
    }   
 
    
  }
  void display() {
    image(img, x, y, dWidth, dHeight);
  }
  
}
