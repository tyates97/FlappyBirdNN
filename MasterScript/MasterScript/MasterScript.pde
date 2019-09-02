// Global Variables
float width = 550;
float height = 720;
float floorGrassLayerHeight = 10;
float floorEarthLayerHeight = 40;
float floorHeight = floorGrassLayerHeight + floorEarthLayerHeight;                 //50
float pipeSpeed = -5;     
float pipeMinHeight = floorHeight + 50;
float pipeGap = 250;
float pipeWidth = 80;
float gravity = 0.6;
float birdSize = 40;
float birdXPos = width/3;
int score = 0;
boolean gameOver;
boolean collision;


//create bird/pipes/game
Bird flaps = new Bird(height/2);
Pipe pipeA = new Pipe(width + birdXPos);
Pipe pipeB = new Pipe(width + birdXPos + (width - birdXPos)); 
Pipe pipeC = new Pipe(width + birdXPos + 2*(width - birdXPos));        
Game game = new Game();

//------------------------------------------------------------------------------------------------------------------------------

// make window
void setup() {
  size(550, 720);
}

// run the game
void draw() {
  background(51,255,255);   // background colour
  flaps.runBird();
  pipeA.runPipe();
  pipeB.runPipe();
  pipeC.runPipe();
  game.runGame();
}

//------------------------------------------------------------------------------------------------------------------------------  

  //TODO: add restart button when you die
  //TODO: add a high score feature
  //TODO: make jumping similar to game
  //TODO: make dimensions of screen/bird/pipes same as game
  //TODO: bird's collision moves as a square
  //TODO: add images
  //TODO: make bird rotate when jumping like game
  //TODO: NEURAL NET BABY
