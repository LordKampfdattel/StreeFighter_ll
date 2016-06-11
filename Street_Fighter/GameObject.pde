abstract class GameObject {
  Vec2 pos;
  Vec2 v;
  
  Hitbox box;
  
  PImage img;
  
  String type;
  
  
  public void move(float x, float y) {
    this.pos.x+=x;
    this.pos.y+=y;
  }
  
  public void move(Vec2 p) {
    this.pos.add(p);
  }
  
  
  public Vec2 getPosition() {
    return this.pos;
  }
  
  
  abstract void render();
  abstract void update();
}