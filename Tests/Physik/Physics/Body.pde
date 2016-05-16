class BodyDesc
{
  Vec2 pos;
  float mass;
  AABB collider;
}

class Body
{
  private Vec2 accel;
  private Vec2 vel;
  private Vec2 pos;
  private float mass;
  private AABB collider;
  
  public Body(BodyDesc desc)
  {
    
  }
}