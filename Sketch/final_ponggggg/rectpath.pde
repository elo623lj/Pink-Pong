class Rectpath {
  float x;
  float w = rectpathwidth;
  float opa=20;
  
  Rectpath(float tx){
    x=tx;
  }
  
  void update(){
  opa+=5;
  if(opa>=80)opa=80;
  if(w==60){
    x+=75;
    if(x>=2921.25){
      x= 0-71.25+x-2921.25;
      if(rectpathdelete){x=-3000;w=0;rectpathdeletecount+=1;if(rectpathdeletecount==21){rectpathdraw=false;frameneed1=frameCount+30;}}
    }
  }
  }
  
  void shrink(){
  w-=10;
  if(w<=60&&w>0)w=60;
  }
  

 

}