int jumping=0;
final int usual=0;
final int jump1=1;
final int jump2=2;

void move()
{
  if (hmovem.get(0)==true)
  {
    x+=width/240;
  }
  if (hmovem.get(1)==true)
  {
    x-=width/240;
  }
  if (fx+x<=er/2)
  {
    x=er/2-width/12;
  }
  if (fx+x>=width-er/2)
  {
    x=width-er/2-width/12;
  }

  switch(jumping) {

  case usual:
println(y);
    if (y>=0)
      y=0;
    else
    {
      y+=vy;
      vy+=height/857;
    }
    if (keyPressed && keyCode==UP)
    {
      jumping=jump1;
      vy=height/40;
      keyPressed=false;
    }

    break;


  case jump1:

    if (keyPressed && keyCode==UP)
    {
      jumping=jump2;
      vy=height/40;
      keyPressed=false;
    }

    y-=vy;
    vy-=height*0.0011668611435;


    if (y>=0)
    {
      y=0;
      vy=0;
      jumping=usual;
    }

    break;


  case jump2:


    y-=vy;
    vy-=height*0.0011668611435;

    if (y>=0)
    {
      y=0;
      vy=height/40;
      jumping=usual;
    }

    break;
  }
}
