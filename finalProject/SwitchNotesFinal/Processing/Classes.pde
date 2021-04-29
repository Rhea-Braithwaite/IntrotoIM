
class Song{
  int numNotes, noteIndex, score, bonus;
  Note[] notes;
  boolean songEnd;
  
  Song(int totNotes){
    numNotes = totNotes;
    noteIndex = 0;
    notes = new Note[numNotes];
    songEnd = false;
    score = 0;
    bonus = 0;
  }
  
  void initialize(int num){ 
    // Create all the game notes, assign the song notes to each one as well as a random lane number
    for(int i = 0; i < numNotes; i++){
      int lane = int(random(1, 5));
      String s;
      if (num == 0){ // Song 1 and use the corresponding data variable
        s = data1[i];
      }
      else{ // Song 2 and use the corresponding data variable
        s = data2[i];
      }
      
      int[] values = int(split(s, ','));
      int note = values[0];
      int len = values[1];
      notes[i] = new Note(lane, note, len); // Create note
    }
  }
  
  void shift(){
    frameCheck++;
    displayScore();
    if (frameCheck >= start){ // Game Begins after 3 seconds
    
      if (songEnd == false){ // If the song is not completed continue moving the notes
        if(noteIndex == 0 && notes[0].start == false){ // When the game begins have the first note begin moving
            notes[0].start = true;
            noteIndex ++;
        }
        
        for (int i = 1; i < numNotes; i++){
          if (i == noteIndex && notes[i].start == false){ // If the current note has not started moving then
            if(notes[i-1].y >= notes[i-1].checkPoint){ // Check if the previous note has reached checkpoint on the screen. If it has, the next note starts moving
              notes[i].start = true;
              noteIndex ++;
            }
          }
        }
        
        for(int i = 0; i< numNotes; i++){ // Update the location and display each note if it has alread started moving 
            if (notes[i].start == true){
              notes[i].update();
              notes[i].display();
              notes[i].pressed();
            }
        }
        
        if (noteIndex >= numNotes && notes[numNotes-1].start == false ){ // If the last note has reached the end of the screen the song is finished
          songEnd = true;
        }
      }
      else{
        endOfLevel(); // Display the end of song screen
      }
    }
  }
  
  void displayScore(){ // Display the song score
    textAlign(RIGHT);
    textSize(30);
    fill(255);
    text("Score:" + str(score), width-50, 50 );
  }
  
  void endOfLevel(){
    if (complete.isPlaying() == false && played == false){ // If the sound file for song completion is not playing, and has not been played before, play the file
      complete.play();
      played = true; // Sound file has been played already
    }    
    int scoreTot = numNotes * 100; // Calculate highest possible score
    bonus = difficultyBonus;
    
    // Display song completed text
    background(84, 49, 88);
    textSize(70);
    textAlign(CENTER);
    text("SONG COMPLETED", width/2, 150);
      
    if (score == 0){ 
      // Display 3 empty stars
      image(emptyStarImg, (width/2)-200, (height/2)-150);
      image(emptyStarImg, width/2, (height/2)-150);
      image(emptyStarImg, (width/2)+200, (height/2)-150);
    }
    else if (score < (scoreTot/3)){
      // Display 1 full and 2 empty
      image(starImg, (width/2)-200, (height/2)-150);
      image(emptyStarImg, width/2, (height/2)-150);
      image(emptyStarImg, (width/2)+200, (height/2)-150);
    }
    else if (score >= (scoreTot/3) && score < (2*scoreTot/3)){
      // Display 2 full and 1 emtpy stars
      image(starImg, (width/2)-200, (height/2)-150);
      image(starImg, width/2, (height/2)-150);
      image(emptyStarImg, (width/2)+200, (height/2)-150);
    }
    else {
      // Display 3 full stars
      image(starImg, (width/2)-200, (height/2)-150);
      image(starImg, width/2, (height/2)-150);
      image(starImg, (width/2)+200, (height/2)-150);
    }
    
    // Display score, diffculty bonus, and total score
    textSize(45);
    text("Score: " + score, width/2, (height/2)+50);
    text("Difficulty Bonus: " + bonus, width/2, (height/2)+125);
    text("Total Score: " + (bonus+score), width/2, (height/2)+200);
    
    noFill();
    rectMode(CENTER);
    textSize(30);
    
    // Restart Button
    text("RESTART", 200, (height/2)+260);
    rect(200, (height/2)+250, 170, 50, 10);
    
    // Menu Button
    text("MENU", width-200,(height/2)+260);
    rect(width-200, (height/2)+250, 170, 50, 10);
    
    if (mousePressed){
      if (mouseX >= 115 && mouseX <= 285 && mouseY>= 625 && mouseY <= 675){ // Mouse is pressed within the bounds of the Restart button
        // Reinitialize variables so that the song can play again
        reset();
        frameCheck = 0;
        transparency = 255;
        played = false;
      }
      else if (mouseX >= 715 && mouseX <= 885 && mouseY>= 625 && mouseY <= 675){ // Mouse is pressed within the bounds of the Menu button
        // Reinitialize variables so that the song can play again and on the next draw have the Start Screen be displayed
        reset();
        startGame=false;
        frameCheck = 0;
        played = false;
      }
    }
  }
  
 void reset(){
    // Reinitalize song variables
    noteIndex = 0;
    songEnd = false;
    //pause = false;
    score =0;
    bonus = 0;
    
    // Sleect a new random lane for each note
    for(int i = 0; i < numNotes; i++){
      int lane = int(random(1, 5));
      notes[i].reset(lane);
    }
  }
}


// Note variables
final int NOTEWIDTH = 120;
final int NOTEHEIGHT = 120;
final int NOTEY = 0;
final float NOTEINTERVAL = 4;

class Note {
  int nWidth, nHeight, lane, note, len, checkPoint;
  float x, y, interval;
  PImage img;
  boolean start, played, colour, rest;
  
  Note (int LANE, int NOTE, int LENGTH){
    colour = false;
    played = false;
    start = false;
    lane = LANE;
    x = (LANE*laneWidth)-(laneWidth/2);
    y = NOTEY;
    nWidth = NOTEWIDTH;
    nHeight = NOTEHEIGHT;
    interval = NOTEINTERVAL;
    note = NOTE;
    len = LENGTH;
    img = noteImg;
    
    if (len == 1){ // Length = 1 beat 
      checkPoint = 320;
    }
    else if (len == 2){ // Length = 2 beats 
      checkPoint = 500;
    }
    else if (len == 4){ // Length = 4 beats 
      checkPoint = 750; 
    }
    else if (len == 5){ // Length = half a beat 
      checkPoint = 270;
    }
  }
  
  void update(){ // Update the position of the note, so that it falls down the screen
      interval = gameInterval; // Set note interval
      y = y + interval;
      
      if(y - (nHeight/2) >= height){ // if note reaches the bottom of the screen, it stops moving
        start = false;
      }
  }
  
  void display() { // Display the note Image
    noTint();
    image(img, x, y, nWidth, nHeight);
     if (colour == true){ // If the note has been pressed, display a translucent circle over it
      fill(225, 164, 250, 127);
      circle(x, y, nWidth);
    }
  }
  
  void pressed(){
    int laneSwitch = playLane;
    if (laneSwitch == lane && played == false){ // If the note's lane matches the lane that is being pressed, and the note has not been played
      if(y-(nHeight/2)>= barHeight && y+(nHeight/2)< height){ // Note perfectly in play zone
        played =  true;
        songs[songIndex].score += 100; // Score increases 
        colour = true;
        noteToPass = note; // Note to pass to Arduino
        lengthToPass = len; // Length to pass to Arduino
       
      }
      else if (y-(nHeight/2)< barHeight && y+(nHeight/2)>= barHeight){ // note only marginally in play zone (bottom half inside)
        played = true;
        songs[songIndex].score += 50; // Score increases by half
        colour = true;
        noteToPass = note; // Note to pass to Arduino
        lengthToPass = len; // Length to pass to Arduino
      }
      else if (y-(nHeight/2)> barHeight && y+(nHeight/2)> height){ // Note only marginally in play zone (top half inside)
        played = true;
        songs[songIndex].score += 50; // Score increases by half
        colour = true;
        noteToPass = note; // Note to pass to Arduino
        lengthToPass = len; // Length to pass to Arduino
      }
    }
  }
  
  void reset(int LANE){ // Reset the x and y position of the note as well as it's other variables
    lane = LANE;
    x = (LANE*laneWidth)-(laneWidth/2);
    y = NOTEY;
    colour = false;
    played = false;
  }
  
}
