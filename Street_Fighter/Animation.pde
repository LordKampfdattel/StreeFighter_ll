class Animation {
  private PImage spriteSheet;
  private float spriteWidth;
  private float spriteHeight;
  private int animationLength;
  private int currFrame=0;
  private float speed;
  private boolean loop=false;
  
  
  public Animation(PImage spriteSheet, float spriteWidth, float spriteHeight, float speed, int scale, boolean loop) {
    this.spriteSheet = spriteSheet;
    this.spriteSheet.resize((int)this.spriteSheet.width*(int)scale, (int)this.spriteSheet.height*(int)scale);
    this.spriteWidth = spriteWidth*scale;
    this.spriteHeight = spriteHeight*scale;
    this.animationLength = (int)(this.spriteSheet.width/this.spriteWidth);
    this.speed = speed;
    this.loop = loop;
  }
  
  
  public void update() {
    if(frameCount%this.speed==0) {
      this.next();
    }
  }
  
  
  private void next() {
    if(!this.loop) {
      if(this.currFrame<this.animationLength) {
        this.currFrame++;
      }
    }else {
      if(this.currFrame<this.animationLength) {
        this.currFrame++;
      }
      if(this.currFrame>=this.animationLength) {
        this.currFrame=0;
      }
    }
  }
  
  
  public void drawImage() {
    translate(this.spriteWidth/4, this.spriteHeight/4);
    image(this.spriteSheet, (float)-this.spriteWidth/2, (float)-this.spriteHeight/2, (float)this.spriteWidth/2, (float)this.spriteHeight/2, (int)this.currFrame*(int)this.spriteWidth, 0, (int)(this.currFrame+1)*(int)this.spriteWidth, (int)this.spriteHeight);
    //image(this.spriteSheet, 0, 0, (float)this.spriteWidth/2, (float)this.spriteHeight/2, (int)this.currFrame*(int)this.spriteWidth, 0, (int)(this.currFrame+1)*(int)this.spriteWidth, (int)this.spriteHeight);
  }
}