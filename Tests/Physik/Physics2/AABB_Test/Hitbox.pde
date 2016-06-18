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
    if(abs(this.pos.x-h.getPosition().x)<this.boxWidth+h.getWidth()) {
      if(abs(this.pos.y-h.getPosition().y)<this.boxHeight+h.getHeight()) {
        return true;
      }
    }
    
    return false;
  }
  
  public Vec2 getUpdatedV(Hitbox h, Vec2 v) {
    Hitbox nb = new Hitbox(this.pos.add(v), this.boxWidth, this.boxHeight);
    
    if(abs(nb.getPosition().x-h.getPosition().x)<nb.boxWidth/2+h.getWidth()/2) {
      if(abs(nb.getPosition().y-h.getPosition().y)<nb.boxHeight/2+h.getHeight()/2) {
        return new Vec2(abs(nb.getPosition().x-h.getPosition().x)-(nb.boxWidth/2+h.getWidth()/2), abs(nb.getPosition().y-h.getPosition().y)-(nb.boxHeight/2+h.getHeight()/2));
      }
    }
    
    return null;
  }
  
  public void render() {
    translate(this.pos.x, this.pos.y);
    stroke(0, 255, 0);
    noFill();
    rect(-this.boxWidth/2, -this.boxHeight/2, boxWidth, boxHeight);
    resetMatrix();
  }
  
  public Vec2 getPosition() {
    return this.pos;
  }
  
  public float getWidth() {
    return this.boxWidth;
  }
  
  public float getHeight() {
    return this.boxHeight;
  }
}