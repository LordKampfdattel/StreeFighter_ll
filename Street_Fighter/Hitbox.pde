class Hitbox {                //mit AABB collision
  private Vec2 pos;
  private float boxWidth;
  private float boxHeight;
  
  Hitbox(Vec2 pos, float boxWidth, float boxHeight) {
    this.pos = pos;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
  }
  
  Hitbox(Vec2 pos, PImage img) {
    this.pos = pos;
    this.boxWidth = img.width;
    this.boxHeight = img.height;
  }
  
  void setPosition(Vec2 pos) {
    this.pos = pos.copy();
  }
  
  public boolean collide(Hitbox h) {    //AABB
    if(abs(this.pos.x-h.givePosition().x)<this.boxWidth+h.giveWidth()) {
      if(abs(this.pos.y-h.givePosition().y)<this.boxHeight+h.giveHeight()) {
        return true;
      }
    }
    
    return false;
  }
  
  public void render() {
    translate(this.pos.x, this.pos.y);
    stroke(0, 255, 0);
    noFill();
    rect(-this.boxWidth/2, -this.boxHeight/2, boxWidth, boxHeight);
    resetMatrix();
  }
  
  public Vec2 givePosition() {
    return this.pos;
  }
  
  public float giveWidth() {
    return this.boxWidth;
  }
  
  public float giveHeight() {
    return this.boxHeight;
  }
}