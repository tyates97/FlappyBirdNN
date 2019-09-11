// Global Variables
float width = 550;
float height = 720;
float floorGrassLayerHeight = 10;
float floorEarthLayerHeight = 40;
float floorHeight = floorGrassLayerHeight + floorEarthLayerHeight;                 //50
float pipeSpeed = -5;     
float pipeMinHeight = 150;
float pipeGap = 250;
float pipeWidth = 80;
float gravity = 0.6;
float birdSize = 40;
float birdXPos = width/3;
int populationSize = 25;
int timeOfPrevStart;
int totalPipes = 100;
boolean gameOver;



//create bird/pipes/game
Pipe pipeA = new Pipe(width + birdXPos);
Pipe pipeB = new Pipe(width + birdXPos + (width - birdXPos));         
Game game = new Game();
Population pop = new Population(populationSize);  //<>//

//------------------------------------------------------------------------------------------------------------------------------

// make window
void setup() {
  size(550, 720);
}

// run the game
void draw() {
  background(51,255,255);   // background colour
  
  if(pop.allBirdsDead()){
    pop.calculateFitness();    
    timeOfPrevStart = millis(); 
    pop.naturalSelection();    
    pop.mutateBabies();        
    pipeA.reset(width + birdXPos);
    pipeB.reset(width + birdXPos + (width - birdXPos));
  } else {
    pop.runPop();
    pipeA.runPipe();
    pipeB.runPipe();
    game.runGame();
    
  }
}
