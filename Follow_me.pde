float coinGain;
float ballNumber = 3;
int score = 0;
int die = 0;
int gameScreen = 0;


PImage powerCoin;
Paddle paddle;

PImage SpiderSp;
PGraphics pg;

//import processing.sound.*;
//SoundFile cfile;
//SoundFile sfile;

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
  //cfile = new SoundFile(this, "coinSound.wav");
  //sfile = new SoundFile(this, "SpiderHit.wav");
}


void draw() {
// Display the contents of the current screen
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}


void initScreen() {
  background(255, 204, 0);
  textSize(32);
  fill(25, 32, 152);
  textAlign(CENTER);
  text("click to start! ", width/2, height/2);
  // codes of initial screen
}



void gameScreen(){
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
  if (die > 3) {
    gameOver();
  }
  // game contents 
  
}


void gameOverScreen() {
    background(51);
    textSize(32);
    textAlign(CENTER);
    fill(255, 178, 23);
    text("score " + score, width/2, height/2);
    String screen = "Looks like the spider ate you!";
    text(screen, width/2, height/4);  // Text wraps within text box
  // codes for game over screen
  }



/********* INPUTS *********/

public void mousePressed() {
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==0) {
    startGame();
  }
}


/********* OTHER FUNCTIONS *********/

// This method sets the necessary variables to start the game  
void startGame() {
  gameScreen=1;
}

void gameOver(){
  gameScreen=2;
}

class Paddle {
  float w;
  float h;
  float px;
  float py;
  Paddle ( float px, float py, float w, float h) {
    this.px=px;
    this.py=py;
    this.w=w;
    this.h=h;
  }

  void show() {
    rectMode(CENTER);
    fill(191, 78, 8);
    rect(px, py, w, h );
  }
  void movePaddle() {
    px = constrain(mouseX, 0, width-w/2);
    py = 500;
  }
}



class Bball {
  float bx;
  float by;
  float bxs;
  float bys;
  float r;


  Bball(float x, float y, float xs, float ys) {
    this.bx = x;
    this.by = y;
    this.bxs = xs;
    this.bys = ys;
    r = 15;
  }
  void display() {
    noStroke();
    fill(7, 121, 59);
    circle(bx, by, r*2);
  }

  void bounce() {
    bx = bx + bxs;
    by = by + bys;

    if (bx < 0 || bx > width - 10) {
      bxs = -bxs;
    }

    if (by < 0) {
      bys = -bys;
    }
  }
  //void GoToNewLevel() {
  //  if (ballNumber = 0){


  //  }
  //}


  void BallHitPaddle(Paddle p) {
    if ( by + r  > p.py - (p.h/2) && by - r  < p.py + (p.h/2) &&(bx - r  > (p.px-p.w/2) 
      || bx + r  > (p.px-p.w/2))&& (bx + r < (p.px-p.w/2) + p.w || bx - r < (p.px-p.w/2) + p.w)) {
      score ++;
      bys = abs(bys)*-1;
    } 
  }
}

class pCoins {
  boolean cdebouncer;
  float cx;
  float cy;
  float cys;
  int cr;

  pCoins(float cx, float cy, float cys) {
    this.cx = cx;
    this.cy = cy;
    this.cys = cys;

    cr = 25;
    powerCoin.resize(cr, cr);
  }
  void coinDisplay() {
    if (cdebouncer == false) {
      image(powerCoin, cx, cy);
    }
  }

  void coinFall() {
    cy = cy + cys;
    if (cy > height) {
      cdebouncer = false;
      cy = -cr*2;
      cx = random(width);
    }
  }
  void coinHitPaddle(Paddle p) {
    if ( cy + cr  == p.py - (p.h/2) && (cx + cr  > (p.px-p.w/2) && cx - cr  < (p.px+p.w/2)) ) {
      cdebouncer = true;
      score ++;
      //cfile.play();
    }
  }
}

class spider {
  boolean sdebouncer;
  float Sx;
  float Sy;
  float Sx2;
  float period;
  float amplitude;
  int Ss;
  spider(float Sx, float Sy, float period, float amplitude) {
    this.Sx = Sx;
    this.Sy = Sy;
    this.period = period;
    this.amplitude =amplitude;
    Ss = 40;
    SpiderSp.resize(Ss, Ss);
  }
  void showSpider() {
    fill(250);
    strokeWeight(10);
    line(0, 0, 0, Sy);
    image(SpiderSp, Sx, Sy);
    Sy = abs(amplitude*sin((frameCount/period)*TWO_PI));
  }

  void update() {
  }
  void spiderHitPaddle(Paddle p) {
    
    if ( Sy+40 > p.py - (p.h/2) && sdebouncer == false && (Sx > (p.px-p.w/2) &&  Sx  < (p.px+p.w/2))) {
      sdebouncer = true;
      score --;
      die ++;
      //sfile.stop();
      //sfile.play();
     
    } else if (sdebouncer == true && Sy < height/2 ) {
      sdebouncer = false;
    } 
   
  }
}
