class Sky {

  float sizex, sizey;
  float x, y;
  float speed;

  Sky(float sizex, float sizey, float speed, float y)
  {
    this.sizex=sizex;
    this.sizey=sizey;
    this.speed=speed;
    this.y=y;
    x=width+sizex/2;
  }

  void generate()
  {
    stroke(allc);
    strokeWeight(2);
    fill(abs(allc-255));
    rect(x, y, sizex, sizey);
  }

  void lang(boolean lang)
  {
    fill(allc);
    textSize(sizex);
    if (lang==true)
      text("日本語", x, y);
    else
      text("ENGLISH", x, y);
  }

  void move()
  {
    x-=speed;
  }
}
