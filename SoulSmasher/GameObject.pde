abstract class GameObject {
  private Vec2 pos;
  private Vec2 v;
  
  private Hitbox box;
  
  public GameObject(Vec2 pos) {
    this.pos = new Vec2();
    this.pos=pos;
  }
  
  
  public void move(Vec2 v) {
    this.pos=this.pos.add(v);
  }
  
  
  public Vec2 getPosition() {
    return this.pos;
  }
  
  public Vec2 getDirection() {
    return this.v;
  }
  
  public Hitbox getHitbox() {
    return this.box;
  }
  
  
  abstract void update();
  abstract void render();
}