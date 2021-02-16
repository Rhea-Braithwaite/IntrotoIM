int boxX = 1005;
int boxY = -400;
int boxWidth = 650;
int boxHeight = 350;
int lineLength = 52; // For the description, the average length of a line is 52 characters
int rows;
int index;
int y = -190; // Y Coordinate of the movie row (Origin at 100, 920)
int x = 1040; // X Coordinate of the movie row (Origin at 100, 920)


class Movie {
  
  String title, rating, genre, description;
  int releaseDate, rottenTomatoes, x1, x2;
  float IMDb, y1, y2;
  color circleColour;
  
  
  Movie(String movieName, String movieRating, String movieGenre, String about, int year, float score1, int score2) {
    title = movieName;
    rating = movieRating;
    genre = movieGenre;
    description = about;
    releaseDate = year;
    IMDb = score1;
    rottenTomatoes = score2;
    circleColour = color(random(255), random(255), random(255)); 
    x1 = (score2 * 15); // Determine the x coordinate based on the X-Axis scale (Origin at 100, 920)
    y1 = score1 * -100; // Determine the y coordinate based on the Y-Axis scale (Origin at 100, 920)
    x2 = x1 + 100; // Determine the x coordinate (Origin at 0, 0)
    y2 = y1 + 930; // Determine the y coordinate (Origin at 0, 0)
  }
  
  void display() { // Draw a circle on the graph based on the x and y coordinates of the movie
    fill(circleColour, 127);
    circle(x1, y1, 50);
  }
  

  void info() {
    if(dist(mouseX, mouseY, x2, y2) <25  ){ // Determine if the mouse is within a circle
      if(boxOffice == false){ // If no other movie is being displayed
        inRange = true; // Mouse is within a circle
        boxOffice = true; // Movie information is to be displayed
    
        fill(0, 127); // Colour the rectangle black with half transparency
        rect(boxX, boxY, boxWidth, boxHeight); // Draw the rectangle for the movie information
        
        fill(255); // Colour the movie information white
        textFont(font, 30);
        textSize(30);
        textAlign(LEFT);
        
        // Display the movie information
        text("Title: "+title, boxX, boxY+30);
        text("Year: "+releaseDate, boxX, boxY+60);
        text("Rating: "+ rating, boxX, boxY+90);
        text("IMDb: "+IMDb, boxX, boxY+120);
        text("Rotten Tomatoes: "+rottenTomatoes, boxX, boxY+150);
        text("Genre: " + genre, boxX, boxY+180);
        text("Description: ", boxX, boxY+210);
        
        rows = round((description.length()/lineLength)) + 1; // Determine the number of rows for movie description
        int shift = 40; // Y Coordinate shift after each row
        for(index=0; index< rows-1; index++) { // Determine the starting index for each row of characters
          text(description.substring(index*lineLength, (index*lineLength)+lineLength), x, y+shift); // Display only 52 characters characters each time
          shift+=30;
        }
        text(description.substring(index*lineLength), x, y+shift); // For the last row, display all remaining characters
      }
    }
  }
}
