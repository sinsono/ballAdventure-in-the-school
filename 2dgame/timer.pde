int time1=0;
int time2=0;
int retimer=0;

void timer()
{
  time1++;
  countdown.play();
  fill(abs(allc-255+time1*5));
  if (time1*3>=150)
    textSize(150);
  else
    textSize(time1*3);

  textAlign(CENTER);
  if (time2>=3)
  {
    if (lang==false)
      text("START", width/2, height/1.8);
    else
      text("スタート", width/2, height/1.8);
  } else
    text(abs(time2-3), width/2, height/1.8);
  textAlign(LEFT);

  if (retimer==1)
  {
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
  if (time2>=4)
  {
    if (retimer!=1)
    {
      Count=0;
      count=0;
    }
    ii=0;
    i1=0;
    i2=1;
    jj=0;
    j1=0;
    j2=1;
    status=game;
  } else
  {
    if (time1>=60)
    {
      time1=0;
      time2++;
    }
  }
  fill(allc);
  rect(width/2, height/1.02, width, height/8);
  cir(efill);

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
}
