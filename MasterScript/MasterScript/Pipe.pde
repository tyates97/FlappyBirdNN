// PIPE
class Pipe{
  int regenCounter;            // current regeneration count
  int maxRegenCounter;         // keeping track of when to start randomising heights
  float xPos;
  float pipe1Height;
  float pipe2Height;
  float pipeSeparation = width - birdXPos;
  float[] pipe1Heights = new float[totalPipes];
  float[] pipe2Heights = new float[totalPipes];
    
  Pipe(float _x){
  xPos = _x;
  pipe1Height = pipeMinHeight + random(height - floorHeight - 2*pipeMinHeight - pipeGap);
  pipe1Heights[regenCounter] = pipe1Height;
  pipe2Height = height - pipe1Height - pipeGap;
  pipe2Heights[regenCounter] = pipe2Height;
  }
  
//------------------------------------------------------------------------------------------------------------------------------

  void drawPipe(){  
    stroke(0,255,0);
    fill(0,255,0);
    rect(xPos, 0, pipeWidth, pipe1Height);
    rect(xPos, 0 + pipe1Height + pipeGap, pipeWidth, pipe2Height);
  }  
  
  void movePipe(){
    xPos += pipeSpeed;
  }
  
  void regeneratePipe(){
    if(xPos <= -pipeWidth){    //if pipe goes offscreen
      xPos = 2*(pipeSeparation) - pipeWidth;                                        // move pipe to be next in sequence
      regenCounter++;
      if(regenCounter <= maxRegenCounter){
        pipe1Height = pipe1Heights[regenCounter];
        pipe2Height = pipe2Heights[regenCounter];
      } else {
        maxRegenCounter = regenCounter;
        pipe1Height = pipeMinHeight + random(height - 2*pipeMinHeight - pipeGap);     // create top of pipe
        pipe1Heights[regenCounter] = pipe1Height;
        pipe2Height = height - pipe1Height - pipeGap;                                 // create bottom of pipe
        pipe2Heights[regenCounter] = pipe2Height;
      }
    }
  }
  
  void reset(float xCoOrd){
    xPos = xCoOrd;
    regenCounter = 0;
    pipe1Height = pipe1Heights[regenCounter];
    pipe2Height = pipe2Heights[regenCounter];
  }
//------------------------------------------------------------------------------------------------------------------------------
  
  void runPipe(){
    movePipe();
    drawPipe();
    regeneratePipe();
  }
}
