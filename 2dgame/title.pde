
void title()
{
  background(abs(allc-255));

  fill(allc);
  textAlign(CENTER);
  if (lang==false)
  {
    textSize(width/12);
    text("BALL ADVENTURE", width/2, height/2.2);
    textSize(width/50);
    text("Click EnterKey to start", width/2.4+width/13, height/1.7);
  } else
  {
    textSize(width/12);
    text("ボールの冒険", width/2, height/2);
    textSize(width/50);
    text("エンターキーを押してスタート", width/2.4+width/13, height/1.5);
  }

  stroke(allc);
  strokeWeight(1);
  if (mouseX>=width/13-width/14 && mouseX<=width/13+width/14 && mouseY>=height/15-height/20 && mouseY<=height/15+height/20)
  {
    if (mousePressed==true)
    {
      status=language;
      mousePressed=false;
    }
    fill(200);
  } else
    noFill();
  rect(width/13, height/15, width/7, height/10);
  noStroke();

  fill(allc);
  if (lang==true)
  {
    textSize(width/23);
    text("言語", width/13, height/10);
  } else
  {
    textSize(width/40);
    text("LANGUAGE", width/13, height/12);
  }



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

  for (int i=i1; i<i2; i++)
  {
    land.add(new Land(random(width/40, width/20), random(height/20, height/6), random(width/240, width/120)));
    i1++;
  }
  for (int i=ii; i<land.size(); i++)
  {
    land.get(i).generate();
    land.get(i).move();
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
    }
  }

  cir(efill);
}
