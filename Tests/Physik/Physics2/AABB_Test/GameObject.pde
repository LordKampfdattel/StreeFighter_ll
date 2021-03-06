abstract class GameObject {
  private Vec2 pos;
  Vec2 v;
  
  Hitbox box;
  
  PImage img;
  
  String type;
  
  
  public void move(float x, float y) {
    this.pos.x+=x;
    this.pos.y+=y;
  }
  
  public void move(Vec2 p) {
    this.pos=this.pos.add(p);
  }
  
  
  public Vec2 getPosition() {
    return this.pos;
  }
  
  
  public void updateHitbox() {
    this.box.setPosition(this.pos);
  }
  
  
  public void moveIntoHitbox(Hitbox hb) {
    
  }
  
  
  abstract void render();
  abstract void update();
}