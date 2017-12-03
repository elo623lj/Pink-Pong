public class SketchRight extends AbstractSketch {
float nowwidth=1050;
float nowheight=600;
float imagex= -1850;
  
    public SketchRight(final PApplet parent, final int w, final int h) {
        super(parent, w, h);
    }

    @Override
    public void draw() {
        graphics.beginDraw();
        graphics.background(255);
        
        if(circulardraw){
        graphics.pushMatrix();
        graphics.translate(nowwidth/2,nowheight/2);
        graphics.scale(circularscale);
        circularscale += (0.60-0.30)/25;
        if(circularscale>0.6)circularscale = 0.6;
        drawcircular(circularthick,circularopa);
        circularthick -= (120.00-25.00)/25;
        if(circularthick<25)circularthick = 25;
        graphics.popMatrix();
        }
        
        if(titleshow){
        graphics.pushMatrix();
        graphics.translate(nowwidth/2,nowheight/2);
        graphics.rotateY(radians(titleroty));
        graphics.tint(titlegray, titleopa);
        if(rectpathendcount>=600)graphics.image(title,imagex-nowwidth/2-imagediff,-nowheight/2);
        graphics.popMatrix();
        }
        
        if(rectpathdraw){
        if(!framecounted2){frameneed2=frameCount+2;framecounted2=true;}
        if(frameCount==frameneed2&&rectpathcount<21){rectpathcount+=1;framecounted2=false;}       
        for(int i=0;i<rectpathcount;i++){
        drawrectpath(rectpaths[i]);
        }        
        }
        
        if(cubeshow){
        graphics.pushMatrix();
        graphics.ortho();
        graphics.translate(nowwidth/2,nowheight/2);
        graphics.rotateY(radians(roty));
        graphics.rotateX(radians(10));
        graphics.scale(150);
        drawCube();
        graphics.popMatrix();
     
        }
        
        if(playing){
        graphics.rectMode(CORNER);
        graphics.fill(245,219,189,bgright);
        if(bgright>0)bgright-=10;
        if(bgright<0)bgright=0;       
        graphics.rect(0,0,1050,600); 
           
        graphics.textFont(myFont);
        graphics.textAlign(CENTER, CENTER);
        graphics.fill(255,20,147,10);
        graphics.text(mark[1], 1050/2, 600/2);
        
        for(int i=0;i<currentnumBalls;i++) {
        displayTrack(balls[i]);
        }
        
        for(int i=0;i<currentnumBalls;i++) {
        balls[i].collide();
        balls[i].checkBoundaryCollision();
        balls[i].checkBoardCollision(boards);
        balls[i].update();
        displayBall(balls[i]);  
        }
        
        for(int i=0;i<currentnumBalls;i++) {
        displayHit(balls[i]);
        }
        
        boards[1].update();
        displayBoard(boards[1]);
        }
       
        
        graphics.endDraw();
    }

    @Override
    public void keyEvent(KeyEvent event) {

    }

    @Override
    public void mouseEvent(MouseEvent event) {

    }

    @Override
    public void setup() {

    }
    
    public void displayBoard(Board board){
    color thec = color(255,156,205);
    graphics.fill(thec);
    graphics.rectMode(RADIUS);
    graphics.rect(board.x-1800,board.y,halfwidth,halfheight);
  }
  
   public void displayBall(Ball ball) {      
    if(ball.reseted)for(int i=0;i<numShadows;i++){
      displayShadow(ball.shadows[i]);
    }    
    if(ball.x>1700){
    graphics.noStroke();
    graphics.fill(ball.c,ball.opacity);
    graphics.ellipseMode(RADIUS);
    graphics.ellipse(ball.x-1800, ball.y, ball.faker,ball.faker);
    }   
  }
  
    public void displayShadow(Shadow shadow){
    if(shadow.x>1700){ 
    float r = map(shadow.d,0,6,0,1);
    color c1 =color(255,105,180);
    color c2 = color(255,20,147);
    color c = lerpColor(c1, c2, r);
    int opacity=40-(shadow.d*5);
    graphics.fill(c,opacity);
    graphics.ellipse(shadow.x-1800, shadow.y, balls[shadow.id].radius-shadow.d*0.8, balls[shadow.id].radius-shadow.d*0.8);
    }
  }
  
  
    public void displayTrack(Ball ball){
    for(int i=0;i<numTracks;i++){
    if(ball.tracks[i].x>1700){ 
    graphics.fill(ball.tracks[i].c,ball.tracks[i].opacity);
    graphics.ellipse(ball.tracks[i].x-1800, ball.tracks[i].y, ball.radius, ball.radius);
    }
    }
  }

    public void displayHit(Ball ball){
    if(ball.hit.live && ball.hit.x>1700){
    for(int i=0;i<70;i++){
    float o = map(i,0,70,100,0);
    graphics.fill(ball.hit.c,o*ball.hit.opacity);
    graphics.rectMode(RADIUS);
    graphics.rect(ball.hit.x-1800,ball.hit.y-ball.hit.dir*45+ball.hit.dir*i,40+i*0.05,1);
    }       
  }
  }
  
  void drawcircular(float thick,float opa){
     graphics.colorMode(RGB,255,255,255,100);
     graphics.noStroke();
     for(int i = 3; i >=0; i--) {
     //for(int j=0;j<=i;j++)diff+=j*13;    
     startPoint[i]+=10;
     if(startPoint[i]%360<=10)endPoint[i]=random(360);
     while(endPoint[i]<50 || endPoint[i]>300)endPoint[i]=random(360);
     graphics.fill(255);
     graphics.ellipse(0, 0, 200+i*110,200+i*110);
     graphics.fill(255,105,180,opa);
     graphics.arc(0, 0,200+i*110-thick,200+i*110-thick, radians(startPoint[i]), radians(startPoint[i]+endPoint[i]));    
    }
    
    graphics.fill(255);
    graphics.ellipse(0,0,80,80);

  }
  
  void drawrectpath(Rectpath rp){
        float tx=rp.x;
        graphics.rectMode(CENTER);  
        graphics.fill(255);
        if(tx>=1650)graphics.rect(tx-1850,nowheight/2,rp.w,nowheight);  
        graphics.fill(255,105,180,rp.opa);
        if(tx>=1650)graphics.rect(tx-1850,nowheight/2,rp.w,nowheight);     
        tx+=rectpathwidth;
        graphics.fill(255);
        if(tx>=1650&&rp.w>0)graphics.rect(tx-1850,nowheight/2,rectpathwidth*2-rp.w,nowheight);        
        tx+=rectpathwidth;     
  }
  
void drawCube() {
  graphics.textureMode(NORMAL);
  graphics.stroke(255);
  graphics.strokeWeight(0.08);
  
  // +Z "front" face
  graphics.beginShape(QUADS);
  graphics.texture(p1);
  graphics.vertex(-1, -1,  1, 0, 0);
  graphics.vertex( 1, -1,  1, 1, 0);
  graphics.vertex( 1,  1,  1, 1, 1);
  graphics.vertex(-1,  1,  1, 0, 1);
  graphics.endShape();

  // -Z "back" face
  graphics.beginShape(QUADS);
  graphics.texture(p2);
  graphics.vertex( 1, -1, -1, 0, 0);
  graphics.vertex(-1, -1, -1, 1, 0);
  graphics.vertex(-1,  1, -1, 1, 1);
  graphics.vertex( 1,  1, -1, 0, 1);
  graphics.endShape();

  // +X "right" face
  graphics.beginShape(QUADS);
  graphics.texture(p3);
  graphics.vertex( 1, -1,  1, 0, 0);
  graphics.vertex( 1, -1, -1, 1, 0);
  graphics.vertex( 1,  1, -1, 1, 1);
  graphics.vertex( 1,  1,  1, 0, 1);
  graphics.endShape();
  
  // -X "left" face
  graphics.beginShape(QUADS);
  graphics.texture(p4);
  graphics.vertex(-1, -1, -1, 0, 0);
  graphics.vertex(-1, -1,  1, 1, 0);
  graphics.vertex(-1,  1,  1, 1, 1);
  graphics.vertex(-1,  1, -1, 0, 1);
  graphics.endShape();
  
  // +Y "bottom" face
  graphics.beginShape(QUADS);
  graphics.fill(255,140,198);
  graphics.vertex(-1,  1,  1, 0, 0);
  graphics.vertex( 1,  1,  1, 1, 0);
  graphics.vertex( 1,  1, -1, 1, 1);
  graphics.vertex(-1,  1, -1, 0, 1);
  graphics.endShape();

  // -Y "top" face
  graphics.beginShape(QUADS);
  graphics.fill(255,140,198);
  graphics.vertex(-1, -1, -1, 0, 0);
  graphics.vertex( 1, -1, -1, 1, 0);
  graphics.vertex( 1, -1,  1, 1, 1);
  graphics.vertex(-1, -1,  1, 0, 1);
  graphics.endShape();
  }
  
}