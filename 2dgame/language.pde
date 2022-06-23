void language()
{
  count++;
  if (count>=15)
  {
    j2++;
    count=0;
  }
  for (int j=j1; j<j2; j++)
  {
    sky.add(new Sky(random(width/30, width/12), random(height/90, height/30), random(width/240, width/120), random(height/24, height*0.6666666666)));
    j1++;
  }
  for (int i=jj; i<sky.size(); i++)
  {
    sky.get(i).lang(lang);
    sky.get(i).move();
  }


  if (mousePressed==true)
  {
    if (mouseY>=height/1.2-height/24 && mouseY<=height/1.2+height/24)
    {
      if (mouseX>=width/2.4-width/16 && mouseX<=width/2.4+width/16)
      {
        iji=0;
        lang=true;
      }
      if (mouseX>=width/2.4+width/8-width/16 && mouseX<=width/2.4+width/8+width/16)
      {
        iji=1;
        lang=false;
      }
      mousePressed=false;
    }
  }

  for (int i=0; i<2; i++)
  {
    if (i==iji)
      fill(200);
    else
      noFill();
    stroke(allc);
    rect(width/2.4+i*width/8, height/1.2, width/8, height/12);
  }

  fill(allc);
  textSize(width/40);
  textAlign(CENTER);
  text("日本語", width/2.4, height/1.17);
  text("ENGLISH", width/2.4+width/8, height/1.17);
  textSize(width/50);
  if (lang==true)
    text("スペースキーで戻る", width/1.2, height/1.15);
  else
    text("Press SpaceKey to back", width/1.2, height/1.15);

  if (keyPressed && key==' ')
    status=title;
}
