class Camera {
  Vec2 offset;
  boolean locked;
  
  float sizeX, sizeY;      //obere linke und untere rechte ecke der map (Up Left ; Down Right)
  
  Camera(float sizeX, float sizeY) {
    this.offset = new Vec2();
    this.locked = true;
    
    this.sizeX=sizeX;
    this.sizeY=sizeY;
  }
  
  void lock() {
    locked = true;
  }
  
  void unlock() {
    locked = false;
  }
  
  void move(Vec2 v) {
    if(!locked) offset.addEqual(v);
    
    this.correctPosition();
  }
  
  void correctPosition() {
    if(offset.x<0) {
      offset.x=0;
    }
    
    if(offset.y<0) {
      offset.y=0;
    }
    
    
    if(offset.x>=(sizeX-width)) {
      offset.x=sizeX-width;
    }
    
    if(offset.y>=(sizeY-height)) {
      offset.y=sizeY-height;
    }
  }
  
  void setPosition(Vec2 v) {
    if(!locked) offset = v.copy();
  }
  
  void applyTransform() {
    translate(-offset.x, -offset.y);
  }
  
  Vec2 screenToWorld(Vec2 screenCoord) {
    return screenCoord.add(offset);
  }
  
}