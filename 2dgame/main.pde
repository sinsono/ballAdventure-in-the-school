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


final int language=0;
final int title=1;
final int timer=title+1;
final int game=timer+1;
final int select=game+1;
final int revival=select+1;
final int giveup=revival+1;
final int reset=giveup+1;
int status=title;

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

void setup()
{
  //fullScreen();
  size(1200, 600); //w:h = 2:1

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

  x=0;
  y=0;
  vy=0;
  er= height*0.06;
  fx=width/2;
  fy=height/4;
  efill=allc;

  spr = new Spread[6];
}

void draw()
{
  background(abs(efill-255));
  noStroke();

  switch(status) {

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
    if (count>=dis)
    {
      if (Count>=dis/3)
        j2++;
      i2++;
      count=0;
      Count++;
    }

    if (Count>=dis/3.8)
    {
      if (allc>=255)
      {
        allc=255;
        efill=255;
      } else
      {
        allc+=5;
        efill+=5;
      }
    }

    fill(allc);
    rect(width/2, height/1.02, width, height/8);
    cir(efill);

    for (int i=kk; i<bullet.size(); i++)
    {
      for (int j=ii; j<land.size(); j++)
      {
        if (land.size()!=0)
        {
          if (bullet.get(i).fx+bullet.get(i).sx/2>=land.get(j).x-land.get(j).sizex/2 &&  bullet.get(i).fx-bullet.get(i).sx/2<=land.get(j).x+land.get(j).sizex/2 && bullet.get(i).fy+bullet.get(i).sy/2>=height*0.9166666-land.get(j).sizey && bullet.get(i).fy-bullet.get(i).sy/2<=height*0.9166666)
          {
            if (kill.isPlaying()==false)
              kill.rewind();
            kill.play();
            bullet.remove(i);
            land.remove(j);
          }
        }
      }
      for (int h=jj; h<sky.size(); h++)
      {
        if (bullet.get(i).fx+bullet.get(i).sx/2>=land.get(h).x-land.get(h).sizex/2 && bullet.get(i).fy+bullet.get(i).sy/2>=height*0.9166666-land.get(h).sizey && bullet.get(i).fy-bullet.get(i).sy/2<=height*0.9166666)
        {
          kill.play();
          bullet.remove(i);
          sky.remove(h);
        }
      }
    }

    for (int i=i1; i<i2; i++)
    {
      land.add(new Land(random(width/40, width/20), random(height/20, height/6), random(width/240, width/120)));
      i1++;
    }
    for (int i=ii; i<land.size(); i++)
    {
      land.get(i).generate();
      land.get(i).move();
      if (fx+x+er/2>=land.get(i).x-land.get(i).sizex/2 && fx+x-er/2<=land.get(i).x+land.get(i).sizex/2 && fy+y+er/2>=height*0.9166666-land.get(i).sizey && fy+y-er/2<=height*0.9166666)
      {
        allc=abs(efill-255);
        efill=abs(efill-255);
        status=select;
      }
    }

    if (Count>=dis/3)
    {
      for (int j=j1; j<j2; j++)
      {
        sky.add(new Sky(random(width/30, width/12), random(height/60, height/30), random(width/240, width/120), random(height/24, height*0.6666666666)));
        j1++;
      }

      for (int i=jj; i<sky.size(); i++)
      {
        sky.get(i).generate();
        sky.get(i).move();
        if (fx+x+er/2>=sky.get(i).x-sky.get(i).sizex/2 && fx+x-er/2<=sky.get(i).x+sky.get(i).sizex/2 && fy+y+er/2>=sky.get(i).y-sky.get(i).sizey/2 && fy+y-er/2<=sky.get(i).y+sky.get(i).sizey/2)
        {
          allc=abs(efill-255);
          efill=abs(efill-255);
          status=select;
        }
      }
    }

    if (keyPressed && key==' ')
    {
      k2++;
      keyPressed=false;
    }
    for (int i=k1; i<k2; i++)
    {
      shot.rewind();
      bullet.add(new Bullet(fx+x, fy+y));
      k1++;
    }
    for (int i=kk; i<bullet.size(); i++)
    {
      shot.play();
      bullet.get(i).bullet();
      bullet.get(i).move();
    }
    move();

    break;


  case select:

    C++;

    if (90>=C && C>=0)
      broken.play();

    if (C>=90)
    {
      if (selection.isPlaying()==false)
        selection.rewind();
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

    if (which==true)
    {
      up.rewind();
      retimer=1;
      status=timer;
    } else
    {
      fx=width/2;
      fy=height/4;
      broken.rewind();
      die.rewind();
      selection.rewind();
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
  }
}

void cir(int i)
{
  fill(i);
  circle(fx+x, fy+y, er);
}
