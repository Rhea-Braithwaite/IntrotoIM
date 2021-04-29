import processing.sound.*; //* load the sound library

import processing.serial.*; //* load the serial library
Serial myPort;

int laneWidth = 250;
int barHeight = 630;
int checkPoint = 320;
int numNotes = 42;
int start = 300;
int noteIndex = 0;
int playLane=0;
int prevL;
int noteToPass = 0;
int lengthToPass = 0;

int transparency = 255;
int delay = 255;
PFont iowan;

//Note[] notes = new Note[numNotes];
PImage bgd, noteImg, helpImg, startImg, starImg, emptyStarImg;

String data1[];
String data2[];

boolean startGame = false;
boolean help = false;
//boolean songEnd = false;
int totSongs = 2;

int songIndex = 0;
Song[] songs = new Song[totSongs];

int frameCheck;

int difficultyBonus = 0;
int gameInterval = 0;
int lane1 = 0;
int lane2 = 0;
int lane3 = 0;
int lane4 = 0;
int speed = 0;

SoundFile complete, background;

boolean played = false;
void setup(){
  size(1000, 800);
  
  // Create preferred font
  PFont.list();
  iowan = createFont("IowanOldStyle-BlackItalic", 30);
  
  // Load sound files 
  background = new SoundFile(this, "data/sounds/background.mp3");
  complete = new SoundFile(this, "data/sounds/win.mp3");
  
  // Load images
  bgd = loadImage("data/images/bg.jpg");
  noteImg = loadImage("data/images/note.png");
  helpImg = loadImage("data/images/help4.png");
  startImg = loadImage("data/images/start.jpg");
  starImg = loadImage("data/images/star.png");
  emptyStarImg = loadImage("data/images/empty.png");
  
  // Load the song notes from the notes file
  data1 = loadStrings("data/files/notes2.txt");
  data2 = loadStrings("data/files/notes4.txt");
  
  // Createand initialize the songs
  songs[0] = new Song(42);
  songs[1] = new Song(51);
  
  songs[0].initialize(0);
  songs[1].initialize(1);
  
  // Check and select the correct port
  printArray(Serial.list());
  String portname=Serial.list()[3];
  println(portname);
  myPort = new Serial(this,portname,9600);
  myPort.clear();
  myPort.bufferUntil('\n');
  
  imageMode(CENTER);
}

void draw(){
  if (startGame == false){ // If no song has been selected remain on the start screen
    startScreen(); 
  }
  else{ // If a song has been selected start the game
    gameBackground();
    songs[songIndex].shift();
  }
}


void startScreen(){
  backgroundMusic();
  textFont(iowan);
  
  image(startImg, width/2, height/2);
  tint(255, 178);
  
  // Display the help circle and question mark
  noFill();
  stroke(225, 164, 250);
  circle(width-50, 40, 50);
  fill(255);
  textSize(45);
  text("?", width-48, 56);
  
  // Game Title
  textSize(100);
  textAlign(CENTER);
  text("Switch Notes", width/2, (height/5));
  
  // Note images to represent each song
  image(noteImg, width/4, (height/2)-65);
  textSize(25);
  text("Twinkle, Twinkle Little Star", (width/4)+15, (height/2)+50);
  image(noteImg, (3*width)/4, (height/2)-65);
  text("Jingle Bells", (3*width)/4, (height/2)+50);
  
  // Start Instructions
  fill(84, 49, 88);
  textSize(45);
  text("Please Select a Song",width/2, (height/2)+350);
  
  howToPlay();
  
  if( mousePressed){
    // Mouse Pressed within the image circle of the first song
    // Delay to give processing time to calculate the gameInterval
    if (dist(mouseX, mouseY, width/4, (height/2)-65) <= 60 && delay == 0){
      songIndex = 0;
      startGame = true;
      frameCheck = 0;
      transparency = 255;
    }
    // Mouse Pressed within the image circle of the second song
    // Delay to give processing time to calculate the gameInterval
    else if (dist(mouseX, mouseY, (3*width)/4, (height/2)-65) <= 60 && delay == 0){
      songIndex = 1;
      startGame = true;
      frameCheck = 0;
      transparency = 255;
    }
  }
 
 // Display a blank screen that slowly fades out as a representation of the delay
 fill(84, 49, 88, delay);
 if (delay > 0){
   rectMode(CENTER);
   rect(width/2, height/2, width, height);
   delay --;
  } 
  
}

void howToPlay(){
  if (dist(width-50, 40, mouseX, mouseY)<=50){ // The mouse is within the help circle
    background(84, 49, 88); // Make the background a shade of purple
    
    // Display the help circle and question mark
    noFill();
    circle(width-50, 40, 50);
    fill(0);
    textSize(45);
    text("?", width-48, 56);
    
    // Rectangle
    rectMode(CENTER);
    fill(255, 200);
    rect(width/2 - 15, height/2 + 5, width-70, height-50);
    
    // How to play text
    fill(0, 220);
    textSize(30);
    text("HOW TO PLAY", width/2, 100);
    
    // Instructions Image
    image(helpImg, width/2, height/2);
  }
}

void gameBackground(){// Display the gamebackground
  if(background.isPlaying() == true){ // If the game background music is playing reset the position and pause the file
      background.jump(0); 
      background.pause();
    }
  
  // Background image
  image(bgd, width/2, height/2);
 
 
 // Draw the four lanes
  strokeWeight(3);
  stroke(225, 164, 250);

  for(int i = 0; i<5; i ++){
    line(i*laneWidth, 0, i*laneWidth, height);
  }
  
  // Draw the zone where the switch should be pressed for the note
  line(0, barHeight, width, barHeight);
  line(0, height, width, height);
  
  // Transparency for the initial display and then fading out of the name of the song
  if (transparency > 0 ){
    transparency --;
  }
  
  // Display of the text for the song name
  fill(255, transparency);
  textAlign(CENTER);
  textSize(50);
  if(songIndex == 0){
    text("Tinkle, Twinkle, Little Star",width/2, height/2);
  }
  else{
    text("Jingle Bells",width/2, height/2);
  }
  
}

void check(){
  
  // Determine the interval by which the notes must move and difficulty bonus based on the speed passed by Arduino
  if(startGame == false){
    if (speed == 1){
      gameInterval = 4;
      difficultyBonus = 0;
    }
    else if(speed == 2){
      gameInterval = 6;
      difficultyBonus = 300;
    }
    else if (speed == 3){
      gameInterval = 8;
      difficultyBonus = 600;
    }
  }
  
  // Determine the lane which is being pressed based on the lane values passed by Arduino
  if (lane1 == 0 && lane2 == 0 && lane3 == 0 && lane4 == 0 ){
     playLane = 0;
  }
  else{
     if (lane1 == 1){
      playLane = 1;
    }
    else if (lane2 == 1){
      playLane = 2;
    }
    else if (lane3 == 1){
      playLane= 3;
    }
    else if (lane4 == 1){
      playLane = 4;
    }
    else{
      playLane = 0; // If no lane is being selected
    }
  }
  //println("Speed:", speed);
  //println("Interval", gameInterval);
}


void backgroundMusic(){
  if(background.isPlaying() == false){ // If the game background music is not playing and the game level has started, loop the sound file
    background.loop();
  }
}

void serialEvent(Serial myPort){ // Accept the values of the switches and speed from Arduino
  String s = myPort.readStringUntil('\n');
  
  s = trim(s);
  if (s!= null){
    int laneValues[] = int(split(s,','));
    if(laneValues.length == 5){
      lane1 = laneValues[0];
      lane2 = laneValues[1];
      lane3 = laneValues[2];
      lane4 = laneValues[3];
      speed = laneValues[4];
     
      check();
    }
  }
  
  myPort.write(int(noteToPass)+","+int(lengthToPass)+"\n");
  noteToPass=0; // Reinitialize note to pass so that the note is not played constantly
}
