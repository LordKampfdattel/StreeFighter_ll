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
  private ArrayList<Vec2> forces;
  private ArrayList<Vec2> impulses;
  
  public Body(BodyDesc desc)
  {
    accel = new Vec2();
    vel = new Vec2();
    pos = desc.pos.copy();
    mass = desc.mass;
    collider = desc.collider.copy();
    forces = new ArrayList<Vec2>();
    impulses = new ArrayList<Vec2>();
  }
  
  public void addForce(Vec2 force)
  {
    forces.add(force.copy());
  }
  
  public void addImpulse(Vec2 impulse)
  {
    impulses.add(impulse.copy());
  }
}