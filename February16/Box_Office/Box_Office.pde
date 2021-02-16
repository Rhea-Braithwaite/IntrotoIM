/* //<>//
  Concept:NETFLIX BOX OFFICE is a Data Visualization project with the data being a collection of information on different Netflix Movies. 
          This information includes the movie:
              Title
              Year
              Rating (Age Wise)
              IMDb Score
              Rotten Tomatoes Score
              Genre
              Description
          A graph is displayed to the user, with each circle representing a movie. Based on the IMDb and Rotten Tomatoes scores the user can then place 
          the mouse over a circle and have the movie information displayed to them.
  Name: Rhea Braithwaite
  Instruction: Press the mouse to transition from the start screen to the graph. Hover the mouse over a particle circle to see the movie information.
  Source of Data: Kaggle.com. Netflix Movies and TV Shows
*/

String dataSet[]; 
ArrayList<Movie> movies = new ArrayList<Movie>();
String data[];
boolean boxOffice = false;
boolean inRange = false;
final int dim = 10;
final int newX = 100;
final int newY = 920;
boolean coverScreen = true;
PFont font;

void setup () {
  size(1800, 990);
  
  font = createFont("Perpetua", 30);
  dataSet = loadStrings("DataSet.csv"); // Read all strings from the DataSet File
 
  for (int i=1; i<dataSet.length; i++){
    data = split(dataSet[i], ','); // For each row of the data, split it into its respective attributes
    movies.add(new Movie(data[0], data[2], data[5], data[6], int(data[1]), float(data[3]), int(data[4]))); // Create and add a movie to the movie array list.
  }
  frameRate(10);
}

int xAxis = 1600;
int yAxis = -900;
int xAxisScale = 150;
int yAxisScale = 100;

void draw () {
  if (coverScreen == true) {
    startScreen(); // Display the StartScreen
  }
  else{
    background(125); // Colour the background a shade of grey
    translate(newX, newY); // Translate origin to 100, 920
    verticalAxis(); // Draw and label the Y-Axis
    horizontalAxis();  // Draw and label the X-Axis
    moviePlot(); // Draw the movie graph and display the movie information
  }
}

void startScreen(){
  background(0); // Colour the background black
  // Netflix  logo
  textSize(900);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("N", width/2, (height/2)+300);
  
  // Project Name
  textSize(30);
  fill(255); // Colour the text white
  text("NETFLIX BOX OFFICE",width/2, (height/2));
  
  // Catchphrase
  text("The Place to Go, to find Information About a Show",width/2, (height/2)+350);
  
  
  // Prompt to see data
  textSize(15);
  text("Click Anywhere to Get Started Today", width/2, height-100);  
}

void verticalAxis(){
  
  pushMatrix();
  translate(-50, -460);// Translate origin temporarily to a new point to rotate the Y-Axis Label
  fill(0); // Colour the Y-Axis label black
  textFont(font, 30);
  textSize(30);
  textAlign(CENTER);
  rotate(PI+PI/2); // Rotate the Y-Axis Label by 270 degrees
  text("IMDb", 0, 0); // X-Axis label
  popMatrix();  
  
  line(0, 0, 0, yAxis); // Y-Axis
  for(int y = 0; y >= yAxis ; y -= yAxisScale) {
    fill(32, 41, 247); // Colour the Y-Axis numbers blue
    textSize(25);
    text(-y/100, -20, y+7); // Display the numbers for the scale of the Y-Axis
  }
}

void horizontalAxis() {
  fill(0); // Colour the X-Axis label black
  textFont(font, 30);
  textSize(30);
  textAlign(CENTER);
  text("ROTTEN TOMATOES",800, 55); // X-Axis label
  
  line(0, 0, xAxis, 0); // X-Axis
  
  int num = 0; // Number for the scale of the X-Axis 
  
  for(int x = 0; x < xAxis ; x += xAxisScale) {
    if (x != 0) {
      textSize(25);
      fill(32, 41, 247); // Colour the X-Axis numbers blue
      text(num, x-15, 22); // Display the numbers for the scale of the X-Axis
    }
    num += 10;// Increment the num variable for the next number to be drawn on the scale
  }  
}

void moviePlot(){
  for(Movie show: movies) {
    show.display(); // Draw each movie's circle 
    show.info(); // If mouse is in circle, display the movie's information
  }
  
  if(inRange == false){ // The mouse is not in the range of any circle
    boxOffice = false; // Display no movie information
  }
  
  inRange = false; // Reset the inRange variable for the next check to see if the mouse is within any circle
}


void mousePressed(){ // Event that stops the display of the start screen
  coverScreen = false;
}
