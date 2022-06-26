import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//hjk
Spread [] spr;
Spread spread;

ArrayList <Bullet> bullet;
ArrayList <Land> land;
ArrayList <Sky> sky;
ArrayList<Boolean> hmovem;

Minim minim;
AudioPlayer countdown;
AudioPlayer broken;
AudioPlayer die;
AudioPlayer selection;
AudioPlayer choose;
AudioPlayer shot;
AudioPlayer kill;
AudioPlayer hop;
AudioPlayer step;
AudioPlayer up;


String [] ngu = {"諦", "め", "て", "た", "ま", "る", "か", "!", "!"};

final int device=-1;
final int language=0;
final int title=1;
final int timer=title+1;
final int game=timer+1;
final int select=game+1;
final int revival=select+1;
final int giveup=revival+1;
final int reset=giveup+1;
int status=device;
int devicec=0;

boolean lang=true;//true:Japanese  false:English
boolean which=false;

int allc=0; //AllColor
int a=0;
int C=0;
int t=0;
int Count=0;
int count=0;
int ii=0;
int i1=0;
int i2=1;
int jj=0;
int j1=0;
int j2=1;
int kk=0;
int k1=0;
int k2=0;
int dis=50;
int revivalc=0;
int iji=0;

float fx, fy;
float x, y;
float vy;
float er; //Ellipse Radius
int efill;


final int start=1;
final int fire=2;
final int sea=3;
final int tree=4;
int stage=start;


void setup()
{
  fullScreen();
  //size(1200, 600); //w:h = 2:1

  rectMode(CENTER);
  textMode(CENTER);

  PFont font = createFont("Meiryo", 50);
  textFont(font);

  minim=new Minim(this);
  countdown=minim.loadFile("countdown.mp3");
  broken=minim.loadFile("broken.mp3");
  die=minim.loadFile("spread.mp3");
  selection=minim.loadFile("selection.mp3");
  choose=minim.loadFile("choose.mp3");
  shot=minim.loadFile("shot.mp3");
  kill=minim.loadFile("kill.mp3");
  hop=minim.loadFile("jump1.mp3");
  step=minim.loadFile("jump2.mp3");
  up=minim.loadFile("up.mp3");

  bullet=new ArrayList<Bullet>();
  land=new ArrayList<Land>();
  sky=new ArrayList<Sky>();
  hmovem = new ArrayList<Boolean>();
  hmovem.add(false);
  hmovem.add(false);
  hmovem.add(false);
  hmovem.add(false);
  hmovem.add(false);

  x=0;
  y=0;
  vy=0;
  er= height*0.06;
  fx=width/2;
  fy=height/4;
  efill=allc;
  gc=3;

  spr = new Spread[6];
}

void draw()
{
  background(abs(efill-255));
  noStroke();

  switch(status) {

  case device:

    for (int i=-1; i<2; i+=2)
    {
      if (mousePressed)
      {
        if (mouseX>=width/2-i*width/8-width/8 && mouseX<=width/2-i*width/8+width/8 && mouseY>=height/2-height/12 && mouseY<=height/2+height/12)
          devicec=i;
      }
      if (devicec==i)
      {
        if (keyPressed && key==ENTER)
        {
          status=title;
          keyPressed=false;
        }

        fill(150);
      } else
        noFill();
      stroke(0);
      rect(width/2-i*width/8, height/2, width/4, height/6);
    }
    textSize(width/24);
    fill(0);
    text("SELECT THE DEVICE", width/3.5, height/5);
    text("スマホ", width/3.2, height/1.9);
    text("パソコン", width/1.85, height/1.9);
    textSize(30);
    text("エンターキーを押してスタート", width/3, height/1.5);

    break;


  case language:

    language();

    break;


  case title:

    if (keyPressed==true && key==ENTER)
    {
      j1=0;
      j2=1;
      fx=width/12;
      fy=height*0.885;
      efill=allc;
      status=timer;
      mousePressed=false;
      sky.clear();
      land.clear();
    }
    title();

    break;

  case timer:

    timer();

    break;


  case game:

    count++;

    b1();


    break;


  case select:

    C++;

    if (90>=C && C>=0)
      broken.play();

    if (C>=90)
    {
      selection.play();
      for (int i=-1; i<2; i+=2)
      {
        if (fx+x-er/2>=width/2+i*width/4-width/8 && fx+x-er/2<=width/2+i*width/4+width/8 && fy+y>=height/3-height/12 && fy+y<=height/3+height/12)
        {
          if (keyPressed && key==ENTER)
          {
            if (i==-1)
            {
              efill=abs(efill-255);
              which=true;
              status=revival;
            } else
            {
              allc=255;
              spr[0] = new Spread(fx+x, fy+y, -4, 4, 10);
              spr[1] = new Spread(fx+x, fy+y, 1.5, 6, 20);
              spr[2] = new Spread(fx+x, fy+y, 3.5, 4, 20);
              spr[3] = new Spread(fx+x, fy+y, 3.5, 3.5, 20);
              spr[4] = new Spread(fx+x, fy+y, 3, 1.5, 20);
              spr[5] = new Spread(fx+x, fy+y, 0, 0, 10);
              efill=abs(efill-255);
              which=false;
              status=giveup;
            }
            selection.close();
            C=0;
          }
          fill(allc);
          textSize(20);
          if (lang==false)
            text("PRESS 'ENTER' KEY", width/2+i*width/4-width/12, height/5);
          else
            text("エンターキーをクリック", width/2+i*width/4-width/12, height/5);
          fill(150);
        } else
          noFill();
        stroke(allc);
        strokeWeight(10);
        rect(width/2+i*width/4, height/3, width/4, height/6);
        strokeWeight(1);
      }
      if (fx+x-er/2>=width/2-1*width/4-width/8 && fx+x-er/2<=width/2-1*width/4+width/8 && fy+y>=height/3-height/12 && fy+y<=height/3+height/12 ||fx+x-er/2>=width/2+1*width/4-width/8 && fx+x-er/2<=width/2+1*width/4+width/8 && fy+y>=height/3-height/12 && fy+y<=height/3+height/12 )
        choose.play();
      else
        choose.rewind();
      fill(allc);
      textSize(width/21);
      text("まだいける", width/2-width/2.7, height/2.7);
      text("もう無理", width/2-width/3.15+width/2.1, height/2.7);

      if (hmovem.get(0)==true)
      {
        x+=width/200;
      }
      if (hmovem.get(1)==true)
      {
        x-=width/200;
      }

      if (hmovem.get(2)==true)
      {
        y-=width/200;
      }
      if (hmovem.get(3)==true)
      {
        y+=width/200;
      }
      if (fx+x<=er/2)
      {
        x=er/2-fx;
      }
      if (fx+x>=width-er/2)
      {
        x=width-er/2-fx;
      }
      if (fy+y<=er/2)
      {
        y=er/2-fy;
      }
      if (fy+y>=height-er/2)
      {
        y=height-er/2-fy;
      }
    }

    fill(efill);
    arc(fx+x-er/2, fy+y, er, er, radians(45), radians(225));
    arc(fx+x+er/2, fy+y, er, er, radians(315), radians(495));

    break;


  case revival:

    C++;

    if (C>=500)
      status=reset;
    else
      if (C>=400)
      {
        up.play();

        fill(allc);
        rect(width/2, height/1.02, width, height/8);

        for (int i=0; i<land.size(); i++)
        {
          land.get(i).generate();
        }
        for (int i=0; i<sky.size(); i++)
        {
          sky.get(i).generate();
        }
        if (efill==0)
        {
          if (allc<=efill)
            allc=efill;
          else
            allc-=5;
        } else
          if (allc>=efill)
            allc=efill;
          else
            allc+=5;
      }

    if (C>=360)
      cir(efill);
    else
    {
      fill(efill);
      arc(fx+x-er/2, fy+y, er, er, radians(45), radians(225));
      arc(fx+x+er/2, fy+y, er, er, radians(315), radians(495));
    }

    if (330>=C && C>=230)
    {
      t++;
      if (t>=10)
        t=0;
      else if (t>=7.5)
        y++;
      else
        if (t>=5)
          x--;
        else
          if (t>=2.5)
            y--;
          else
            x++;
    }

    if (220<=C)
      a=9;
    else
      if (200<=C)
        a=8;
      else
        if (180<=C)
          a=7;
        else
          if (160<=C)
            a=6;
          else
            if (140<=C)
              a=5;
            else
              if (120<=C)
                a=4;
              else
                if (100<=C)
                  a=3;
                else
                  if (80<=C)
                    a=2;
                  else
                    if (60<=C)
                      a=1;

    for (int i=0; i<a; i++)
    {
      fill(efill);
      textSize(50);
      text(ngu[i], width/4+i*50, height/7);
    }

    break;


  case giveup:

    C++;

    if (C>=300)
      status=reset;

    if (250>=C && C>=110)
      die.play();

    if (C>=120)
    {
      for (int i=0; i<5; i++)
      {
        spread=spr[i];
        spread.spread();
      }
      spr[5].move();
    } else
    {
      fill(efill);
      arc(fx+x-er/2, fy+y, er, er, radians(45), radians(225));
      arc(fx+x+er/2, fy+y, er, er, radians(315), radians(495));
    }

    break;


  case reset:

    allc=efill;
    vy=0;
    C=0;
    t=0;
    a=0;
    time1=0;
    time2=0;
    jumping=usual;
    countdown.rewind();
    selection.rewind();
    broken.rewind();
    gc=3;
    guard=false;
    recover=false;
  
    if (which==true)
    {
      up.rewind();
      retimer=1;
      status=timer;
    } else
    {
      fx=width/2;
      fy=height/4;
      die.rewind();
      retimer=0;
      x=0;
      y=0;
      allc=0;
      count=0;
      Count=0;
      efill=allc;
      bullet.clear();
      sky.clear();
      land.clear();
      status=title;
    }
    break;
  }
}


void keyPressed()

{
  if (key==CODED)
  {
    switch(keyCode) {

    case RIGHT:
      hmovem.set(0, true);
      break;

    case LEFT:
      hmovem.set(1, true);
      break;

    case UP:
      hmovem.set(2, true);
      break;

    case DOWN:
      hmovem.set(3, true);
      break;
    }
  }
  if (key==' ' && recover==false)
    guard=true;
}

void keyReleased()
{
  if (key==CODED)
  {
    switch(keyCode) {

    case RIGHT:
      hmovem.set(0, false);
      break;

    case LEFT:
      hmovem.set(1, false);
      break;

    case UP:
      hmovem.set(2, false);
      break;

    case DOWN:
      hmovem.set(3, false);
      break;
    }
  } else
    if (key==' ')
      guard=false;
}

void cir(int i)
{
  fill(i);
  circle(fx+x, fy+y, er);
}
