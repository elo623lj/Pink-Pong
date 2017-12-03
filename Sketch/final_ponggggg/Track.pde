class Track{
  float x;
  float y;
  int id;
  color c;
  float opacity;
  

  
  Track(float tempx,float tempy,color tempc, int tempid, float tempo){
    x=tempx;y=tempy;c=tempc;id=tempid;opacity=tempo;
    

  }
  
  void update(){
  opacity -=0.05;
  }  
  
}