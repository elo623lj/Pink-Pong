class Hit{
  float x;
  float y;
  color c;
  float opacity;
  boolean live;
  int dir;
  

  
  Hit(float tempx,float tempy,float tempo,int tdir, boolean tlive){
    x=tempx;y=tempy;opacity=tempo;dir=tdir;live=tlive;
    
    c=color(245,219,189);
  }
  
  void update(){
  if(live){
      opacity -=0.015;
      if(opacity<=0){
          opacity=0;live=false;
      }
  }  
  
}

}