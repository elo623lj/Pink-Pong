class Shadow{
  float x;
  float y;
  int d;
  int id;
  float easing;
  float distance;
  
  Shadow(float tempx,float tempy,int tempd,int tempid){
    x=tempx;y=tempy;d=tempd;id=tempid;
    
   distance=d*5; 
  }
  
  void update(float speed){
  easing = map(speed,0,40,0.2,0.9);
  float dx,dy;
  dx = balls[id].x - x; 
  dy = balls[id].y - y; 
  if (sqrt(dx*dx + dy*dy) > distance){
    x += dx*easing/(distance/10);
    y += dy*easing/(distance/10);
    }
  }  
  
}