import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer song;
AudioSample sound;



import controlP5.*;
import javax.media.jai.*;
import jto.processing.sketch.mapper.*;
import com.sun.media.jai.util.*;
import ixagon.surface.mapper.*;

import processing.serial.*;
Serial myPort; 
float roty=0;

boolean playing=false;
boolean cubeshow=false;

//title img
PImage title,p1,p2,p3,p4;
boolean titlemove = false;
boolean titleleave = false;
boolean titleshow=true;
float titleroty=0;
float imagediff=0;
float titleopa=100;
float titlegray=255;

//for countframe
int framenow;
int frameneed1;
boolean framecounted1 = false;
int frameneed2;
boolean framecounted2 = false;



//for circular
float[] startPoint = new float[6];
float[] endPoint = new float[6];
float circularscale=0.3;
float circularthick=120;
float circularopa=60;
boolean circulardraw=true;
boolean circularfade=false;

//for rectpath
float rectpathwidth=71.25;
boolean rectpathdraw=false;
boolean rectpathdelete=false;
boolean rectpathshrink=false;
int rectpathcount=0;
int rectpathendcount=0;
int rectpathdeletecount=0;
Rectpath[] rectpaths =new Rectpath[21];

float bgleft=0;
float bgright=0;

String val;

float[] boardcor = {300,300};

private SketchMapper sketchMapper;

PFont myFont;

float max=0;

int theheight = 600;
int thewidth = 2850;
int numShadows = 15;
int numTracks = 200;

Ball[] balls;
int numBalls;
int currentnumBalls;

int mark[] = {0,0};
float x,y;

int halfwidth = 15; int halfheight = 100;
Board[] boards = {
  new Board(0,100,300),
  new Board(1,2750,300),
};

public void setup() {
  fullScreen(P3D);
  //size(800, 600, P3D);
  colorMode(RGB,255,255,255,100);
  background(255);
  smooth(8);
  myFont = createFont("Helvetica",300);
  
  minim = new Minim(this);
  //song = minim.loadFile("Don't You Worry Child (Instrumental).mp3", 1024);
  //song.loop();
  sound = minim.loadSample("4.wav");
  
  
  //serial
  String portName = Serial.list()[3]; 
  myPort = new Serial(this, portName, 9600);

  //for drawsketch
  sketchMapper = new SketchMapper(this, "layout.xml");
  sketchMapper.addSketch(new SketchLeft(this, 1050, 600));
  sketchMapper.addSketch(new SketchMiddle(this, 750, 600));
  sketchMapper.addSketch(new SketchRight(this, 1050, 600));
  
  //title img
  title = loadImage("title.png");
  p1 = loadImage("p1.jpg");
  p2 = loadImage("p2.jpg");
  p3 = loadImage("p3.png");
  p4 = loadImage("p4.png");
  
  //for circular
  for(int i=0;i<6;i++){
  startPoint[i]=random(360);
  endPoint[i]=random(360);
  while(endPoint[i]<50 || endPoint[i]>300)endPoint[i]=random(360);
  }
  
  //for rectpath
  float tx = rectpathwidth;
  for(int i=0;i<21;i++){
  rectpaths[i]=new Rectpath(tx);       
  tx+=2*rectpathwidth;
  }
  rectpaths[20]=new Rectpath(-71.25); 
  
  numBalls=8;
  currentnumBalls=8;
  balls = new Ball[numBalls];
  for (int i = 0; i < numBalls; i++) { 
    color thec = color(255,105,180);
    balls[i] = new Ball(thewidth/2, theheight/2,25,(round(random(1))*2-1)*random(5,10),(round(random(1))*2-1)*random(5,10),thec, i, balls);
  }
  

}

public void draw() {
  for (int i = 0; i < numBalls; i++) {
    if(frameCount == 100) balls[i].beginning=false;
  }
  
  sketchMapper.draw();
  //saveFrame("frames/####.tga");
}

float Distance(PVector A, PVector B, PVector P) //DistancePointToLineSegment
{
  float vx = P.x-A.x,   vy = P.y-A.y;   // v = A->P
  float ux = B.x-A.x,   uy = B.y-A.y;   // u = A->B
  float det = vx*ux + vy*uy; 

  if (det <= 0)
  { // its outside the line segment near A
    return sqrt( vx*vx + vy*vy );
  }
  float len = ux*ux + uy*uy;    // len = u^2
  if (det >= len)
  { // its outside the line segment near B
    return sqrt(  sq(B.x-P.x) + sq(B.y-P.y) );  
  }
  // its near line segment between A and B
  
  return sqrt( sq(ux*vy-uy*vx) / len );    // (u X v)^2 / len
}

void serialEvent(Serial myPort) {
  
  val = myPort.readStringUntil('\n');       
  
    
    if(val != null){ 
      
      int inA = val.indexOf("A");
      int inB = val.indexOf("B");
      int end = val.indexOf("E");
      
      if(inA>-1 && inB>-1 && end>-1){
      String strA = ""; String strB = "";
      strA = val.substring(inA+1,inB-1);
      strB = val.substring(inB+1,end-1);
      
      float h0 =  float(strA); 
      float h1 = float(strB); 
      
      if(h0>=5 && h0<=20){println(h0,map(h0,5,20,600,0));
      h0=map(h0,5,20,600,0);
      boardcor[0]=h0;   
      }    
      if(h0<5)boardcor[0]=600;
      
      if(h1>=5 && h1<=20){
      h1=map(h1,5,20,600,0);
      boardcor[1]=h1;
      }
      if(h1<5)boardcor[1]=600;
      
      }
    }
}