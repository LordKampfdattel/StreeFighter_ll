class Wall extends GameObject {
  
  public Wall(Vec2 pos, Vec2 size) {
    super.pos = new Vec2();
    super.pos=pos;
    super.v = new Vec2();
    
    super.box = new Hitbox(super.pos, size.x, size.y);
    
    super.type="Wall";
  }
  
  
  public void update() {
    super.updateHitbox();
  }
  
  public void render() {
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect(super.pos.x, super.pos.y, super.box.getWidth(), super.box.getHeight());
  }
}