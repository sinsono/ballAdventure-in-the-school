boolean guard=false;
boolean recover=false;
float gc;

void b1()
{
  if (count>=dis)
  {
    if (Count>=dis/3)
      j2++;
    i2++;
    count=0;
    Count++;
  }

  if (Count>=dis)
  {
    if (allc<=0)
    {
      allc=0;
      efill=0;
    } else
    {
      allc-=5;
      efill-=5;
    }
  } else
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
      if (guard==true)
      {
        gc--;
        land.get(i).x=-width*2;
      } else
      {
        allc=abs(efill-255);
        efill=abs(efill-255);
        status=select;
      }
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
        if (guard==true)
        {
          sky.get(i).x=-width*2;
          gc--;
        } else
        {
          allc=abs(efill-255);
          efill=abs(efill-255);
          status=select;
        }
      }
    }
  }
  if (gc<=0)
  {
    guard=false;
    recover=true;
  }

  /*
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
   }*/
  move();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(er/4);
  if (guard==true)
  {
    drawPolygon(fx+x, fy+y, er*1.2, 6);
  }
  drawPolygon(width/30, height/15, width/50, 6);

  if (recover==true)
  {
    println(gc);
    gc+=0.007;
    if (gc>=3)
    {
      gc=3;
      recover=false;
    }
  }
  rectMode(CORNER);
  fill(#19F7FC);
  noStroke();
  rect(width/10, height/20, map(gc-1, 0, 2, width/9, width/3), height/30);
  rectMode(CENTER);
  
  for (int i=0; i<4; i++)
  {
    fill(allc);
    textSize(height/25);
    text(i, width/10+width/9*i, height/5.5);
  }

  /*textSize(height/12);
   text("×"+gc, width/17, height/10);*/
}

void drawPolygon(float x, float y, float r, int vertexNum) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (int i = 0; i < vertexNum; i++) {
    vertex(r*cos(radians(360*i/vertexNum)), r*sin(radians(360*i/vertexNum)));
  }
  endShape(CLOSE);
  popMatrix();
}
