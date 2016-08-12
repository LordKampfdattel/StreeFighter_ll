class TimeLine extends MenuPart {
  private int curTime=0;
  private int maxTime;
  
  public TimeLine(Vec2 pos, Vec2 size, String name, int maxTime) {
    super(pos, size, name);
    
    this.maxTime=maxTime;
  }
  
  
  public void update() {
    this.updateMouseCollision();
  }
  
  public void render() {
    fill(255);
    stroke(0);
    rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x, super.size.y);
    
    fill(0);
    line((super.pos.x-super.size.x/2), 
      super.pos.y, 
      (super.pos.x-super.size.x/2)+((float)this.curTime/(float)this.maxTime)*super.size.x, 
      super.pos.y);
  }
  
  
  private void updateMouseCollision() {
    if(super.mouseCollides() && mousePressed) {
      //this.curTime=round((mouseX-(super.pos.x-super.size.x/2))/(super.size.x-(super.pos.x-super.size.x/2)))*this.maxTime;//round(((mouseX-((width-(super.pos.x-super.size.x/2))/4))/super.size.x)*this.maxTime);
     
      curTime = round((mouseX - (super.pos.x - super.size.x / 2)) / super.size.x * (float)maxTime);
    }
    
    if(this.curTime<0) {
      this.curTime=0;
    }
    if(this.curTime>this.maxTime) {
      this.curTime=this.maxTime;
    }
  }
  
  
  
  //getter:
  public int getCurTime() {
    return this.curTime;
  }
  
  public int getMaxTime() {
    return this.maxTime;
  }
  
  
  //setter:
  public void setCurTime(int time) {
    this.curTime=time;
  }
  
  public void setMaxTime(int time) {
    this.maxTime=time;
  }
}