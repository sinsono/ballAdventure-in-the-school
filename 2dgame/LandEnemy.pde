class Land{
  
  float sizex,sizey;
  float x;
  float speed;
  
  Land(float sizex, float sizey,float speed)
  {
    this.sizex=sizex;
    this.sizey=sizey;
    this.speed=speed;
    x=width+sizex/2;
  }
  
  void generate()
  {
    fill(allc);
    rect(x,height*0.9166666-sizey/2,sizex,sizey);
  }
  
  void move()
  {
    x-=speed;
  }
}
