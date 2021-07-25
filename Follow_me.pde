float coinGain;
float ballNumber = 3;
int score = 0;


PImage powerCoin;
Paddle paddle;

PImage SpiderSp;
PGraphics pg;

import processing.sound.*;
SoundFile cfile;
SoundFile sfile;

spider Spider[] = new spider [3];
Bball bball[]= new Bball [2];
pCoins Pcoins[]= new pCoins [4];

void setup() {  
  size(800, 600);

  pg = createGraphics(width, height);
  pg.beginDraw();
  for ( int i = 0; i < height; i ++) {
    pg.stroke(i-150, i-150, i);
    pg.line(0, i, width, i);
  }

  pg.endDraw();

  powerCoin = loadImage("papaCoin.png");
  SpiderSp = loadImage("SpiderSpritenew.png");
  paddle = new Paddle(0, 0, 120, 10); 
  bball[0] = new Bball(width/2, 0, 2, 3);
  bball[1] = new Bball(width/4, 0, 2, 2);
  //bball[2] = new Bball(width/4,0,2,2);

  for (int i = 0; i < Pcoins.length; i ++) {
    Pcoins[i] = new pCoins(random(width), random(height), 4);
  }

  for ( int i = 0; i < Spider.length; i ++) {
    Spider[i] = new spider(random(width), 0, random(250, 350), 480);
  }
  cfile = new SoundFile(this, "coinSound.wav");
  sfile = new SoundFile(this, "SpiderHit.wav");
}


void draw() {

  image(pg, 0, 0); 

  for ( int i = 0; i < bball.length; i ++) {
    bball[i].display();
    bball[i].bounce();
    bball[i].BallHitPaddle(paddle);
  }
  for (int i = 0; i < Pcoins.length; i ++) {
    Pcoins[i].coinDisplay();
    Pcoins[i].coinFall();
    Pcoins[i].coinHitPaddle(paddle);
  }
  for (int i = 0; i < Spider.length; i ++) {
    Spider[i].showSpider();
    Spider[i].spiderHitPaddle(paddle);
  }

  paddle.show();
  paddle.movePaddle();
  textSize(20);
  text("score " + score, width/8, 30);
}
