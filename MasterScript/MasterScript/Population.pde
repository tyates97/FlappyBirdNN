class Population{

  // global variables
  int fitnessSum;
  int generation = 1;
  Bird bestBird;
  Bird[] birdArray;
  int[] fitnesses = new int[populationSize]; 
  int[] score = new int[populationSize];
  
  // Constructor
  Population(int size){
    birdArray = new Bird[size];
    
    //fill array with Bird objects
    for(int i=0; i<size; i++){
      birdArray[i] = new Bird();
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void calculateFitness(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].calculateFitness();
      fitnesses[i] = birdArray[i].fitness;
      //print("fitness" + i + " = " + birdArray[i].fitness + " ");
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void calculateScores(){
    for (int i=0; i<birdArray.length; i++){
      score[i] = birdArray[i].score;
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  boolean allBirdsDead(){
    for(int i=0; i<birdArray.length; i++){
      if(!birdArray[i].dead){
        return false;
      }    
    }
    return true;
  }

//------------------------------------------------------------------------------------------------------------------------------

  void naturalSelection(){
    Bird[] newBirdArray = new Bird[populationSize];
    calculateFitnessSum();    
    calculateBestBird();      
    
    for(int i=0; i<newBirdArray.length; i++){
      Bird parent = selectParent();  
      newBirdArray[i] = parent.getBaby();
    }
    
    newBirdArray[newBirdArray.length-1] = bestBird.getBaby();
    newBirdArray[newBirdArray.length-1].isChampion = true;
    
    birdArray = newBirdArray;
    generation++;
  } 
 
//------------------------------------------------------------------------------------------------------------------------------
  
  void calculateFitnessSum(){
    fitnessSum = 0; 
    for(int i=0; i<birdArray.length;i++){
      fitnessSum += fitnesses[i];
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  Bird selectParent(){
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i=0; i<birdArray.length; i++){
      runningSum+=birdArray[i].fitness;
      if(runningSum >= rand){
        return birdArray[i];
      }
    }
    return null;
  }

//------------------------------------------------------------------------------------------------------------------------------

  void mutateBabies(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].mutate();
    }
  }
  
//------------------------------------------------------------------------------------------------------------------------------

  void calculateBestBird(){
    int maxFitness = 0;
    int index = 0;
    for(int i=0; i<birdArray.length; i++){
      if(birdArray[i].fitness > maxFitness){
        maxFitness = birdArray[i].fitness;
        index = i;
      }
    }
    
    if(generation == 1){
      bestBird = birdArray[index];      
    } else if(birdArray[index].fitness > bestBird.fitness) {    //this isn't happening
      bestBird = birdArray[index];
    }
  }

//------------------------------------------------------------------------------------------------------------------------------

  void runPop(){
    for(int i=0; i<birdArray.length; i++){
      birdArray[i].runBird();
      if(!birdArray[i].dead){
        birdArray[i].timeAtDeath = millis();
      }
    }
    
      calculateScores();    
      allBirdsDead();
  }

}
