class Spread {

  float fx;
  float fy;
  float deg=0;
  float ro;
  float sx;
  float sy;
  float vy=5;

  Spread(float fx, float fy, float sx, float sy, float ro)
  {
    this.fx=fx;
    this.fy=fy;
    this.sx=sx;
    this.sy=sy;
    this.ro=ro;
  }

  void spread()
  {
    pushMatrix();
    translate(fx, fy);
    rotate(radians(deg));
    fill(efill);
    ellipse(0, 0, 15, 7.5);
    deg+=ro;
    fx+=sx;
    fy+=sy;
    popMatrix();
  }
  void move()
  {
    pushMatrix();
    translate(fx, fy);
    rotate(radians(deg));
    fill(efill);
    ellipse(0, 0, 15, 7.5);
    deg+=ro;
    fy-=vy;
    vy-=0.15;
    popMatrix();
  }
}
