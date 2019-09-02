// BIRD
class Bird{
  //global variables
  float yPos;
  float speedY = 0;
  int Fitness;
  boolean dead = true;
  
  //constructor
  Bird(float _y) {
    yPos = _y;
  }

//------------------------------------------------------------------------------------------------------------------------------

  void updateBird() {
   speedY += gravity;
   yPos += speedY;
  } 
  
  void drawBird() {
  stroke(255,255,0);
  fill(255,255,0);
  ellipse(birdXPos,yPos,birdSize,birdSize);  //xPos, yPos = centre of ellipse. birdSize = width + height of ellipse
  }
  
  void flapBird() {
   if (keyPressed){
     if(collision == false){ 
     speedY = -10;   
     }   
   }
  }
  
  void checkBounds() {
     if(yPos + birdSize/2 >= height - floorHeight){                  // if bird is hitting the ground
          dead = true;
          collision = true;
          gameOver = true;
        }    
    }
       
   void calculateFitness(){
     Fitness = millis();
   }
       
//------------------------------------------------------------------------------------------------------------------------------

  void runBird() {
  drawBird();
  flapBird();   
  updateBird();
  checkBounds();
  } 
}
