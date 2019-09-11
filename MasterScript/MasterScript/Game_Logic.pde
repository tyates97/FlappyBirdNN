//GAME LOGIC  
class Game{ 
int highScore;
  
  void showScore(){
    int maxScore = 0;
    for(int i=0; i<pop.birdArray.length; i++){
      if(pop.birdArray[i].score > maxScore){
        maxScore = pop.birdArray[i].score;
      }
      if(maxScore > highScore){
        highScore = maxScore;
      }
    }
    
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("Score: " + maxScore, 3*width/4, height/6 - 30);
    
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("High Score: " + highScore, 3*width/4, height/6 + 30);
   }

   
  void showGeneration(){
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("Generation: " + pop.generation, 3*width/4, height/6);    
  }
  
  void drawFloor(){
    stroke(125,68,39);
    fill(125,68,39);
    rect(-2, height - floorEarthLayerHeight, width + 2, floorEarthLayerHeight);  //making the earth layer of the ground
    
    stroke(46,70,0);
    fill(46,70,0);
    rect(-2, height - floorHeight, width + 2, floorGrassLayerHeight);            //making the grass layer of the ground

  } 
 
//------------------------------------------------------------------------------------------------------------------------------
 
  void runGame(){
    drawFloor();
    pop.calculateScores();
    showScore();
    showGeneration();
  }
}
