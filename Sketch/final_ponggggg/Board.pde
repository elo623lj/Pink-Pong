class Board {
  float x,y;
  PVector points[] = new PVector[4];
  float position;
  int id;
  float easing = 0.2;
  Board(int tid,float tempx, float tempy){
    id=tid; x=tempx; y=tempy; 
    update();
  }
  
  void update(){
   float dy;
    dy = boardcor[id] - y; 
    y += dy*easing;
          
     if(y >theheight-halfheight-25)y=theheight-halfheight-25;
     if(y<halfheight+25)y=halfheight+25;
     
     
    points[0]=new PVector(x+halfwidth,y-halfheight);
    points[1]=new PVector(x+halfwidth,y+halfheight);
    points[2]=new PVector(x-halfwidth,y+halfheight);
    points[3]=new PVector(x-halfwidth,y-halfheight);
    
    for(int i=0;i<currentnumBalls;i++) {
    balls[i].checkBoardCollision(boards);
    balls[i].checkBoardPush(boards[id]);
    }
  }
  

 

}