boolean white;
GridSquare[][] grid;
BlackGridSquare[][] bGrid;
int rows;
int cols;
int gridSquareSize;

void setup() {

  size(400, 400);
  noStroke();
  rows = 8;
  cols = 8;
  gridSquareSize = 50;

  grid = new GridSquare[cols/2][rows/2];
  bGrid = new BlackGridSquare[cols/2][rows/2];
  
  // do a double for loop to run through the grid 2D array
  // creating new alternating black and white GridSquare objects
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(white){grid[i/2][j/2] = new GridSquare(i, j, gridSquareSize);}
      else {
        bGrid[i/2][j/2] = new BlackGridSquare(i, j, gridSquareSize);
      }
      white = !white;
    }
    white = !white;
  }
}

void draw() {
  
  // every time daw runs, we want to go through the grid 2d array and update and render each GridSquare object
  // update represents getting hungry
  // render takes care of drawing
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      bGrid[i][j].update();
      bGrid[i][j].render();
    }
  }
  
  // determine which gid slot mouse is over
  int currentHorizSquare = mouseX / 50;
  int currentVertSquare = mouseY / 50;

  // do mouseOver-based feeding only on **valid** grid slots
  if (currentHorizSquare >= 0 && currentHorizSquare <= 7 && currentVertSquare >= 0 && currentVertSquare <= 7) {
      bGrid[currentHorizSquare][currentVertSquare].feed();
  }
}