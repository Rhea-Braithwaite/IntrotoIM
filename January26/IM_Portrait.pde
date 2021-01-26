/* Name:      Rhea Braithwaite
   Assigment: Portrait
   Date:      January 26, 2021
*/

size(800, 800);
background(165, 247, 255);

fill(242,230,230);//Limb colour
//Face
int faceWidth = 100;
int faceHeight = 130;

ellipse(width/2, height/5, faceWidth, faceHeight);

  //Eyebrows
int eyeBrowWidth = 20;
int eyeBrowHeight = 10;

arc((width/2)-21, (height/5)-30, eyeBrowWidth, eyeBrowHeight, PI ,TWO_PI);
arc((width/2)+21, (height/5)-30, eyeBrowWidth, eyeBrowHeight, PI ,TWO_PI);


  //Eyes
fill(255);//Eye Colour
int eyeWidth = 25;
int eyeHeight = 15;

ellipse((width/2)-20, (height/5)-17, eyeWidth, eyeHeight);
ellipse((width/2)+20, (height/5)-17, eyeWidth, eyeHeight);

  //Pupils
int pupilDim = 3;

fill(0);//Colour the pupils black
circle((width/2)-20, (height/5)-17, pupilDim);
circle((width/2)+20, (height/5)-17, pupilDim);

  //Nose
fill(255);//Nose colour
int noseWidth = 5;
int noseHeight = 8;

ellipse(width/2, (height/5)+10, noseWidth, noseHeight);

fill(242,230,230);//Limb colour

  //Lips
int lipsWidth = 50;
int lipsHeight = 30;

arc((width/2), (height/5)+30, lipsWidth, lipsHeight, PI/4, PI - PI/4);

//Neck
int neckWidth = 14;
int neckHeight = 20 ;

rectMode(CENTER);
rect(width/2, (height/4)+35, neckWidth, neckHeight);

//Upperbody
fill(249,250,182);//Shirt colour
int chestWidth = 86;
int chestHeight = 120;

rect(width/2, (height/3)+39, chestWidth, chestHeight, 8);

fill(242,230,230);//Limb colour
  //Upperarms
int upArmWidth = 20;
int upArmLength = 60;

pushMatrix();
rectMode(CENTER);
translate((width/2)+60, (height/3)+10);//Change the origin 
rotate(TWO_PI-(PI/4)); //Rotate the limb 315 degrees
rect(0, 0, upArmWidth, upArmLength, 10);
popMatrix();//Reset the origin to (0,0)

pushMatrix();
translate((width/2)-60, (height/3)+10);//Change the origin 
rotate(PI/4); //Rotate the limb 45 degrees
rect(0, 0, upArmWidth, upArmLength, 10);
popMatrix();//Reset the origin to (0,0)


  //Lowerarms
int lowArmWidth = 20;
int lowArmLength = 55;

pushMatrix();
rectMode(CENTER);
translate((width/2)+60, (height/3)+45);//Change the origin 
rotate(PI/5); //Rotate the limb 36 degrees
rect(0, 0, lowArmWidth, lowArmLength, 10);
popMatrix();//Reset the origin to (0,0)

pushMatrix();
translate((width/2)-60, (height/3)+45);//Change the origin 
rotate(TWO_PI-(PI/5)); //Rotate the limb 324 degrees
rect(0, 0, lowArmWidth, lowArmLength, 10);
popMatrix();//Reset the origin to (0,0)

//Legs
  //Thighs
int legWidth = 20;
int legLength = 80;
pushMatrix();
translate((width/2)+55, (height/2)-20);//Change the origin 
rotate(TWO_PI-(PI/8)); //Rotate the limb 337.5 degrees
rect(0, 0, legWidth, legLength, 10);
popMatrix();//Reset the origin to (0,0)

pushMatrix();
translate((width/2)-55,(height/2)-20);//Change the origin 
rotate(PI/8); //Rotate the limb 22.5 degrees
rect(0, 0, legWidth, legLength, 10);
popMatrix();//Reset the origin to (0,0)


  //Lower leg
pushMatrix();
translate((width/2)+55, (height/2)+25);//Change the origin 
rotate(PI/8); //Rotate the limb 22.5 degrees
rect(0, 0, legWidth, legLength, 10);
popMatrix();//Reset the origin to (0,0)

pushMatrix();
translate((width/2)-55, (height/2)+25);//Change the origin 
rotate(TWO_PI-(PI/8)); //Rotate the limb 337.5 degrees
rect(0, 0, legWidth, legLength, 10);
popMatrix();//Reset the origin to (0,0)//Reset the origin to (0,0)

//Hat
fill(232,17,9);//Hat colour
int midPoint = width/2;
int y = (height/8)-25;

ellipse(midPoint, y+25, 80, 22);//Hat base
rect(midPoint, y+5, 50, 30);//Top of hat
