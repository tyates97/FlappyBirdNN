// PIPE
class Pipe{
  float xPos;
  float pipe1Height;
  float pipe2Height;
  float pipeSeparation = width - birdXPos; 
    
  Pipe(float _x){
  xPos = _x;
  pipe1Height = pipeMinHeight + random(height - 2*pipeMinHeight - pipeGap);
  pipe2Height = height - pipe1Height - pipeGap;
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

  void checkSuccess(){                       
    if(xPos - 2 <= birdXPos + 1 && xPos + 2 >= birdXPos - 1){                                       
      if(flaps.yPos - birdSize/2 >= pipe1Height && flaps.yPos + birdSize/2 <= height - pipe2Height){     
        if(collision == false){                                                                         
          score++;                                                                                      
        }
      }
    }
  }
 
  void checkCollision(){
    if(xPos <= birdXPos + birdSize/2 && birdXPos - birdSize/2 <= xPos + pipeWidth){                  // if bird is in xPos of pipe
      if(flaps.yPos - birdSize/2 <= pipe1Height || flaps.yPos + birdSize/2 >= height - pipe2Height){     // if bird is in yPos of either pipe 
          collision = true;
          flaps.dead = true;
          pipeSpeed = 0;
        }    
    }
  }
  
  void regeneratePipe(){
    if(xPos <= -pipeWidth){
      xPos = 3*(pipeSeparation) - pipeWidth;                                        // move pipe to be next in sequence
      pipe1Height = pipeMinHeight + random(height - 2*pipeMinHeight - pipeGap);     // create top of pipe 
      pipe2Height = height - pipe1Height - pipeGap;                                 // create bottom of pipe
    }
  }
  
//------------------------------------------------------------------------------------------------------------------------------
  
  void runPipe(){
    movePipe();
    drawPipe();
    checkCollision();
    checkSuccess();
    regeneratePipe();
  }
}
