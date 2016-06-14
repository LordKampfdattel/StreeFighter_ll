class Force {
  private String name;
  private Vec2 v;
  
  
  public Force(String name, Vec2 v) {
    this.name = name;
    this.v = v;
  }
  
  
  public String getName() {
    return this.name;
  }
  
  public Vec2 getV() {
    return this.v;
  }
  
  public float getForce() {
    return sqrt(v.x*v.x+v.y*v.y);
  }
}