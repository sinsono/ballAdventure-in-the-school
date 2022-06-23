class Bullet {

  float fx, fy;
  float sx=40;
  float sy=5;

  Bullet(float fx, float fy)
  {
    this.fx=fx+fx/2;
    this.fy=fy;
  }

  void bullet()
  {
    fill(allc);
    ellipse(fx, fy, sx, sy);
  }

  void move()
  {
    fx+=10;
  }
}
