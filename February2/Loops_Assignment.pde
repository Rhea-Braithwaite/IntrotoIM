size(1000, 800);

background(0);
stroke(255); // Colour of the lines

// Background circles
fill(84, 155, 98); //Colour of the circles (green)
for(int diameter = 800; diameter > 100; diameter = diameter - 120 ){
  circle(width/2, height/2, diameter);
}


// Extending Lines
pushMatrix();
translate(width/2, height/2);//Change the origin to the middle of the screen

float angle1 = PI/8;
int endPoint = -300;

for( float totRotation = 0; totRotation < TWO_PI; totRotation = totRotation + angle1){
  rotate(angle1); //Rotate each line by PI/8 radians
  line(0, 0, 0, endPoint);
}
popMatrix();


// Arcs
pushMatrix();

translate(width/2, height/2); //Change the origin to the middle of the screen

fill(89, 98, 252); //Colour of the arcs (blue)
float angle2 = PI/6;
float totRotation = 0;

while( totRotation < TWO_PI-angle2){
  rotate(angle2); //Rotate each arc by PI/6 radians
  arc(0, 0, 200, 200, angle2, PI-angle2, CHORD );
  totRotation = totRotation + angle2;
}

popMatrix();

//Center Circle
fill(255, 90, 49); // Colour of the center circle (orange)
int diameter = 80; 
circle(width/2, height/2, diameter);
