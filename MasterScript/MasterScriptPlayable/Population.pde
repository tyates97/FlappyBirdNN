class Population{

  // global variables
  Bird[] birdArray;
  int[] fitnesses;
  boolean allBirdsDead;
  
  // Constructor
  Population(int size){
    birdArray = new Bird[size];
    
    //fill array with Bird objects
    for(int i=0; i<size; i++){
      birdArray[i] = new Bird(width/3);
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void drawPop(){
    for(int i=0; i < birdArray.length; i++){
      birdArray[i].drawBird();
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void updatePop(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].updateBird();
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void calculateFitness(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].calculateFitness();
      fitnesses[i] = birdArray[i].Fitness;
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void allBirdsDead(){
    for(int i=0; i<birdArray.length; i++){
      if(!birdArray[i].dead == true){
        gameOver = false;
      } else {
      gameOver = true;
      }
    }
  }
//------------------------------------------------------------------------------------------------------------------------------

  void runPop(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].runBird();
    }
  }

}
