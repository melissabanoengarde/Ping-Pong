//Melissa Banoen-Garde

import ddf.minim.*;

Minim minim;
AudioSnippet music;
AudioSnippet introsong;

PImage bg;
//int y;

int  gameScreen = 0;

int x, y, w, h, speedX, speedY;
/*int y;
int w;
int h;
int speedX;
int speedY;*/
int paddleXL, paddleYL, paddleW, paddleH, paddleS;
int paddleXR, paddleYR;
boolean upL, downL;
boolean upR, downR;

color colorL = color(255, 0, 0);
color colorR = color(32, 3, 252);

int scoreL = 0;
int scoreR = 0;

int winScore = 11;

PFont font;                   //font of score

void setup() {
  
  size (800, 800);
  //background(#ffffff); 
  bg = loadImage("PINGPONG COVER.jpg");
  font = loadFont ("MyanmarMN-Bold-30.vlw");  //font of score in data file
  
  x = width/2;
  y = height/2;
  w = 25;
  h = 25;
  speedX = 7;
  speedY = 5;
  
  textSize(30);
  textFont (font);
  textAlign(CENTER, CENTER);
  rectMode (CENTER);
  
  paddleXL = 20;            //L paddle
  paddleYL = height/2;
  
  paddleXR = width -20;     //R paddle
  paddleYR = height/2;
  
  paddleW = 20;        //both paddles's width, height, & speed
  paddleH = 100;
  paddleS = 9;
  
  minim = new Minim (this);
  music = minim.loadSnippet("pingpong_audio.aif");
  introsong = minim.loadSnippet("intro.aif");
  
  
}


void draw() {     //order of coding matters 

//Start Screen
  if (gameScreen == 0) { 
    initScreen(); 
    introsong.play();
    //introsong.rewind();
  } 
  else if (gameScreen == 1) {
    gameScreen();
  }
}

public void mousePressed() {
  if (gameScreen == 0) {
    startGame();
  }
  if (mousePressed) {
      introsong.pause();
     music.play();
    music.loop();
  }
}

void startGame() {
  gameScreen = 1;
}

void initScreen() {
  //background (#ffffff);
   background(bg);
  textAlign (CENTER, CENTER);
  text ("CLICK 2 START", width/2, 350);
  textSize (12);
  fill (0);
  text ("Player 1: 'q' for up, 'a' for down", width/2, 390);
    text ("Player 2: 'o' for up, 'l' for down", width/2, 405);
  textSize (20);
  fill (#000000);
  

}

//[Game Screen]
void gameScreen() {
 
  
  background (#ffffff);
  textSize(30);
  text ("RED VS BLUE", width/2, 50); 
  
  drawCircle();
  moveCircle();
  bounceOff(); 
  
  drawPaddles();
  movePaddle();
  restrictPaddle();
  contactPaddle(); //L Paddle
  
  score();
  gameOver();
  
}

void drawPaddles() {
 fill (colorL);
 rect (paddleXL, paddleYL, paddleW, paddleH);
  fill (colorR);
  rect (paddleXR, paddleYR, paddleW, paddleH);
}

void movePaddle() {
   if (upL) {    //R paddle
     paddleYL = paddleYL - paddleS;
  }
 if (downL) {
   paddleYL = paddleYL + paddleS;
  }
     if (upR) {  //L paddle
     paddleYR = paddleYR - paddleS;
  }
 if (downR) {
   paddleYR = paddleYR + paddleS;
  }
}

void drawCircle() {
  fill (0);
  noStroke();
  ellipse (x, y, w, h);     //circle
}

void moveCircle() {
  x = x + speedX;      //recall that 'w' is weight
  y = y+ speedY;
}

void bounceOff() {
    if ( x > width - 25) {
    setup();
    speedX = -speedX;
    scoreL = scoreL +1;
  }  
 else if ( x < 0 + 25) {
   setup();
   scoreR = scoreR +1;
 }
 
 if ( y > height -25) {
   speedY = -speedY;
 }
 
 else if (y < 0 +25) {
   speedY = -speedY;
 }
  
}

void keyPressed() {
  if (key == 'q') {  //L paddle
    upL = true;
  }
   if (key == 'a' ) {
    downL = true;
  }
    if (key == 'p') {  //R paddle
    upR = true;
  }
   if (key == 'l' ) {
    downR = true;
  }
}

void score() {
  fill (0);
  text(scoreL, 100, 50);
  text(scoreR, 685, 50);
}

void gameOver() {
  if ( scoreL == winScore) {
    background (255, 163, 163);
    gameOverPage ("Red wins!", colorL);
}
if (scoreR == winScore) {
  background (166, 203, 255);
  gameOverPage ("Blue wins!", colorR);
}
}

void gameOverPage(String text, color c) {
  speedX = 0;
  speedY = 0;
  
  fill (0);
  text ("GAME OVER", width/2, height/3-40);
  text ("Play again?" ,width/2, height/3+40);
  fill (c);
  text (text, width/2, height/3);
  
  if (mousePressed) {
    scoreR = 0;
    scoreL = 0;
    speedX = 7;
    speedY = 5;
     introsong.pause();
     music.pause();
   
  }
    
}

void keyReleased() {
    if (key == 'q' ) {
    upL = false;
  }
   if (key == 'a') {
    downL = false;
   }
       if (key == 'p') {  //R paddle
    upR = false;
  }
   if (key == 'l' ) {
    downR = false;
  }
}

void restrictPaddle() {
  if (paddleYL - paddleH/2 < 0) {    //L paddle
    paddleYL = paddleYL + paddleS;
  }
   if (paddleYL + paddleH/2 > height) {
    paddleYL = paddleYL - paddleS;
  }
    if (paddleYR - paddleH/2 < 0) {    //R paddle
    paddleYR = paddleYR + paddleS;
  }
   if (paddleYR + paddleH/2 > height) {
    paddleYR = paddleYR - paddleS;
  }
}

void contactPaddle() {
  if (x - w/2 < paddleXL + paddleW/2 && y - h/2 < paddleYL + paddleH/2 && y + h/2 > paddleYL - paddleH/2) {
    if (speedX < 0){
      speedX = - speedX;
    }
  }
  //R paddle
    else if (x + w/2 > paddleXR - paddleW/2 && y - h/2 < paddleYR + paddleH/2 && y + h/2 > paddleYR - paddleH/2) {
    if (speedX > 0) {
      speedX = - speedX;
    }
  }

 
  
}
