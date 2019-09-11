// BIRD
class Bird{
  //global variables
  float xPos = birdXPos;
  float yPos = height/2;
  float speedY;
  float speedX;
  float distanceFromFloor = height - floorHeight - yPos;
  int timeAtDeath;
  int fitness = 0;
  int score;
  boolean dead;
  boolean isChampion;
  float[] weights = new float[5];
  float[] neuronLayer = new float[5];
  
  //constructor
  Bird() {
       
    for(int i=0; i<weights.length; i++){      //Neural Net Weights
      weights[i] = random(-1, 1);    
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void updateBird() {
    xPos += speedX;
    yPos += speedY;
    speedY += gravity;
  } 
  
  void drawBird() {
  
    if(isChampion){
      stroke(255,0,0);    //red
      fill(255,0,0);
      ellipse(xPos,yPos,birdSize,birdSize);  //xPos, yPos = centre of ellipse. birdSize = width + height of ellipse
    } else {
      stroke(255,255,0);  //yellow
      fill(255,255,0);
      ellipse(xPos,yPos,birdSize,birdSize);  //xPos, yPos = centre of ellipse. birdSize = width + height of ellipse
    }  
  }
  
  void flapBird() {
    if(dead == false){ 
      speedY = -10;   
    }   
  }
       
   void calculateFitness(){
     if(score>0){
       fitness = (timeAtDeath - timeOfPrevStart) + 1000*score;
     } else {
       fitness = (timeAtDeath - timeOfPrevStart + 1000*score)/ (1+ int( sqrt( sq(calculateNearestPipe().pipe1Height + pipeGap/2 - yPos) + sq(calculateNearestPipe().xPos - xPos) ) ) );
     }
   }
   
   void checkDead(){
     if(dead == true){
       speedY = 0;
       speedX = pipeSpeed;
     }
   }
   
  //TODO: very messy. Clean up. 
  void checkSuccess(){
    if(pipeA.xPos - 2 <= birdXPos && pipeA.xPos + 2 >= birdXPos || pipeB.xPos - 2 <= birdXPos && pipeB.xPos + 2 >= birdXPos){          
      if(yPos - birdSize/2 >= pipeA.pipe1Height && yPos + birdSize/2 <= height - pipeA.pipe2Height || yPos - birdSize/2 >= pipeB.pipe1Height && yPos + birdSize/2 <= height - pipeB.pipe2Height){
        if(dead == false){                                                                         //so long as the bird isn't dead
          score++;                                                                                //increment the score
        }
      }
    }
  }
  
  //TODO: very messy, same as above. clean.
  void checkCollisionA(){
    for(int i=0; i<populationSize; i++){  
      if(pipeA.xPos <= xPos + birdSize/2 && birdXPos - birdSize/2 <= pipeA.xPos + pipeWidth){                  // if bird is in xPos of pipeA
        if(yPos - birdSize/2 <= pipeA.pipe1Height || yPos + birdSize/2 >= height - pipeA.pipe2Height){              // if bird collides with pipeA
          dead = true;
        }    
      }
    }  
  }
  
  void checkCollisionB(){
    for(int i=0; i<populationSize; i++){  
      if(pipeB.xPos <= birdXPos + birdSize/2 && birdXPos - birdSize/2 <= pipeB.xPos + pipeWidth){                  // if bird is in xPos of pipeB
        if(yPos - birdSize/2 <= pipeB.pipe1Height || yPos + birdSize/2 >= height - pipeB.pipe2Height){              // if bird collides with pipeB
          dead = true;
        }    
      }
    }  
  }

  void checkBounds() {
    if(yPos + birdSize/2 >= height - floorHeight){                  // if bird is hitting the ground
      dead = true;
    }    
  }
  
  Bird getBaby(){
    Bird baby = new Bird();
    for(int i=0; i<weights.length; i++){
      baby.weights[i] = weights[i];
    }
    return baby;
  }

//------------------------------------------------------------------------------------------------------------------------------
//BRAIN

  Pipe calculateNearestPipe(){
      if(pipeA.xPos - xPos < 0){ //pipeA behind bird returns B
      return pipeB;
    } else if(pipeB.xPos - xPos < 0){ //pipeB behind bird returns A
      return pipeA;
    } else if (pipeA.xPos - xPos < pipeB.xPos - xPos){ //pipeA closer to bird (both in front) returns B
      return pipeA;
    } else{ //pipeB closer to bird (both in front) returns A
      return pipeB;
    }
  }
  
  float[] createNeuronLayer(){
     neuronLayer[0] = calculateNearestPipe().xPos - xPos;          // horizontal distance to nearest pipe
     neuronLayer[1] = -(calculateNearestPipe().pipe1Height - yPos);    // vertical distance to top pipe
     neuronLayer[2] = height - floorHeight - calculateNearestPipe().pipe2Height - yPos;    //vertical distance to bottom pipe
     neuronLayer[3] = speedY;
     neuronLayer[4] = distanceFromFloor;
     
     return neuronLayer;
  }
  
  void calculateNNOutput(){
    float layer1Output = 0.0;
    float output = 0.0;
    for(int i=0; i<weights.length ; i++){
      layer1Output = layer1Output + (weights[i]*neuronLayer[i]);
    }
    
    output = 1/(1+exp(-layer1Output));          //sigmoid, to put it between 0 and 1
    
    if(output < 0.5){
      flapBird();
    }
  }
  
  void mutate(){
    float mutationRate = 0.25;
    float rand = random(1);
    if(rand<mutationRate){
      weights[int(random(weights.length))] = random(-1,1);
    }
  }
       
//------------------------------------------------------------------------------------------------------------------------------

  void runBird() {
  drawBird();
  createNeuronLayer();
  calculateNNOutput();
  checkCollisionA();
  checkCollisionB();
  checkBounds();
  checkSuccess();
  checkDead();
  updateBird();
  } 
}
