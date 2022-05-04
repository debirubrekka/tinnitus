import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Get average amplitude of buffer
// Calculate lerpedAmplitude
// Draw a circle
// Make an array of type float the same size as the buffer
// Lerp each element of the array to the corresponding element in the buffer
// Use the lerped values from the array to do the visualisation instead of using the buffer

void setup()
{
  size(1024, 1024,P3D);
  
   minim = new Minim(this);
   ap = minim.loadFile("Super Ghostbusters- 10 Ghooooostbuster.mp3.mp3", 1024);
   ap.play();
   ab = ap.mix;
   halfH = height/2;
   cx= width/2;
  cy= height/2;
   colorInc= 255/(float)ab.size();
   colorMode(HSB);
   
   
}

Minim minim;
AudioPlayer ap;
AudioInput ai;
AudioBuffer ab;
float  x,y;
float cx, cy;
float r =1;
float halfH;
float lerpedAverage = 0;
float colorInc;
float theta=0;
float[] lerpedBuffer = new float[1024];

void draw()
{
  background(190,200,100);
  fill(0,200,150);
  noStroke();
 // ellipse(width/2,500,2500,500);
  
  x=cx+sin(theta) * r;
  y=cy+cos(theta) * r;
 // rect 20;
  theta += 0.05f;
  r+=1;
  float sum = 0;
 
  for(int i = 0;i<ab.size();i++)
  {
    
    sum += abs(ab.get(i)); 
    lerpedBuffer[i] = lerp(lerpedBuffer[i], ab.get(i), 0.1f);
 
    stroke(colorInc * i, 200, 255);    
    line(i,halfH-lerpedBuffer[i],i,halfH-lerpedBuffer[i]*halfH);
    
  //  triangle(i, halfH-lerpedBuffer[i]*halfH * 1.0f+i/1500, halfH+lerpedBuffer[i]*halfH * 1.0f-1500, i,i,i);
    fill(190, 180, 200);
    noStroke();
 // rect(0,0,1024,250);
 
   
  }
  pushMatrix();
  float average = sum / (float) ab.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  strokeWeight(5);
   stroke(20,255,255);
 
  fill (190,200,150);
  circle(width/2, height/2, 1200+lerpedAverage * 50);
  fill (190,200,175);
  circle(width/2, height/2,1000+lerpedAverage * 50 );
  fill( 190,200,200);
   circle(width/2, height/2, 800+lerpedAverage * 50);
    fill(20,200,250);
    noStroke();
    circle(width/2,height/2, 600);
    fill( 190,200,200);
    
    rect(120,420,760,10);
    rect(140,370,720,9);
    rect(160,330,700,8);
    rect(170,295,680,7);
    rect(190,270,640,6);
    rect(250,250,560,5);
    rect(250,230,550,4);
    
    fill(0,0,0);
    rect (400,512,30,-80);
    rect (300,512,30,-120);
    rect (500,512,30,-130);
    rect (550,512,30,-150);
    rect (450,512,35,-50);
    fill(190,200,200*lerpedAverage);
     rect(0,height/2,1024,1024);
     
      fill(r % 256,255,255);
    stroke(30,255,255);
   translate(width * .25, height/ 2, 0);
  rotateX(theta);  // TWO_PI,PI, QUARTER_PI
  rotateY(theta);  // TWO_PI,PI, QUARTER_PI
  rotateZ(theta);  // TWO_PI,PI, QUARTER_PI
 float size = map(average,0,1,100,200);
 box(size);
  popMatrix();
  
  translate(width * .75, height/2, 0);
  rotateX(theta);  // TWO_PI,PI, QUARTER_PI
  rotateY(theta);  // TWO_PI,PI, QUARTER_PI
  rotateZ(theta);  // TWO_PI,PI, QUARTER_PI
  box(size);
//for(int i = 0 ; i < ab.size(); i++)
  {
 // stroke (i * colorInc, 255, 255);
 // line(i-250,halfH,i-250,halfH + ab.get(i) *halfH);

}
}
