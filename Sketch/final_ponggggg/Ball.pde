class Ball {
  float x, y;
  float radius;
  float vx;
  float vy;
  color c;
  int id;
  Ball[] others;
  
  float spring = 0.1;
  float opacity = 50;
  float faker;
  boolean reseted = true;
  boolean beginning = true;
  boolean counted = false;
  Shadow[] shadows = new Shadow[numShadows];
  Track[] tracks = new Track[numTracks];
  Hit hit = new Hit(0,0,0,0,false);
  int currentTrack=0;
 
  Ball(float tempx, float tempy, float tempr,float tempvx, float tempvy,color tempc,int tempid, Ball[] tempo) {
    x = tempx;
    y = tempy;
    radius = tempr;
    vx = tempvx; 
    vy = tempvy;
    c=tempc;
    id = tempid;
    others = tempo;
    
    faker=radius;
    
    for(int i=0;i<numShadows;i++){
      shadows[i]= new Shadow(x,y,i+1,id);
    }
    
    for(int i=0;i<numTracks;i++){
      tracks[i]= new Track(0,0,0,0,0);
    }
   
  } 
  
  void update() {
    if(faker<radius){
       faker += 1;
       opacity = map(faker,0,radius,0,90);
    }
    if (faker>=radius && !reseted && !beginning ){
      faker=radius;
      opacity = 90;
      
      vx=(round(random(1))*2-1)*random(8,10);
      vy=(round(random(1))*2-1)*random(8,10);
      
      reseted=true;
     }
    
    if(reseted){
      PVector speed = new PVector(vx,vy);
      
    if(speed.mag()<9){
      speed.mult(1.1);
      vx=speed.x;vy=speed.y;
    }
    
    if(speed.mag()>13){
      speed.mult(0.9);
      vx=speed.x;vy=speed.y;
    }
           
    x+=vx;
    y+=vy;
    
    for(int i=0;i<numShadows;i++){
      shadows[i].update(abs(vx)+abs(vy));
    }
    
    for(int i=0;i<numTracks;i++){
      tracks[i].update();
    }
    
    tracks[currentTrack]=new Track(x,y,c,id,5);
    currentTrack += 1;
    if(currentTrack==numTracks)currentTrack=0;
    }
    
    hit.update();
  }
  
  void reset(){    
    x=thewidth/2;
    y=theheight/2;
    
    
    faker=0;
    vx=0; vy=0;
    reseted=false;
    counted = false;
   
    for(int i=0;i<15;i++){
      shadows[i].x = x;
      shadows[i].y = y;
    }
  }
  
  void collide() {
    if(reseted && !beginning){
    for (int i = id + 1; i < currentnumBalls; i++) {
      if(others[i].reseted && !others[i].beginning){
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].radius + radius;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
     }
    }   
  }
  }
  
  void checkBoundaryCollision() {
    if (x > thewidth-radius+500) {
      reset();
    } else if (x < radius-500) {
      reset();
    } else if (y > theheight-radius) {
      hit = new Hit(x,y,1,-1,true);
      y = theheight-radius;
      vy *= -1;
    } else if (y < radius) {
      hit = new Hit(x,y,1,1,true);
      y = radius;
      vy *= -1;
    }
    if (x > thewidth-radius) {
      if(!counted){
        mark[0]+=1;
        bgleft=70;
        sound.trigger();
      }
      counted = true;
    } else if (x < radius) {
      if(!counted){
      mark[1]+=1;
      bgright=70;
      sound.trigger();
      }
      counted = true;
    }
    
  }
  
  void checkBoardCollision(Board[] thisboards){
    for (Board board : thisboards) {
      for (int i=0;i<=3;i++){  
          PVector P,nextP;
          P = board.points[i]; 
          if(i==3) nextP = board.points[0];
              else nextP = board.points[i+1];
          PVector position = new PVector(x,y);
          if (Distance(P,nextP,position) < radius) {
              if(P.x==nextP.x)vx*=-1;
              if(P.y==nextP.y)vy*=-1;
          }
      }
    }    
  }
  
  void checkBoardPush(Board thisboard){
      for (int i=0;i<=3;i++){  
          PVector P,nextP;
          P = thisboard.points[i]; 
          if(i==3) nextP = thisboard.points[0];
              else nextP = thisboard.points[i+1];
          PVector position = new PVector(x,y);
          if (Distance(P,nextP,position) < radius) {
              if(P.x==nextP.x){
                vx*=-1;
                if(P.x>thisboard.x) x=P.x+radius;
                if(P.x<thisboard.x) x=P.x-radius;
              }
              if(P.y==nextP.y){
                vy*=-1;
                if(P.y>thisboard.y) y=P.y+radius;
                if(P.y<thisboard.y) y=P.y-radius;
              }
          }
      }   
  }
  

}