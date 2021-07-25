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
      cfile.play();
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
      //sfile.stop();
      sfile.play();
    } else if (sdebouncer == true && Sy < height/2 ) {
      sdebouncer = false;
    }
    println(sdebouncer);
  }
}
