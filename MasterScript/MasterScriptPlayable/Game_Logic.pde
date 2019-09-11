//GAME LOGIC  
class Game{
  
  void checkGameOver(){  
    if(collision == true){
      textSize(32);
      textAlign(CENTER);
      fill(255);
      text("Game Over", width/2, height/2);       // game over text appears
    }
    
    if(gameOver == true){
      pipeSpeed = 0;       //game stops moving
      gravity = 0;
      flaps.speedY = 0;
      
    }
  } 
  
  void showScore(){
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text(score, width/2, height/4);
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
    checkGameOver();
    drawFloor();
    showScore();
  }
}
