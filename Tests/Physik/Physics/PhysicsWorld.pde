import java.util.ArrayList;

class PhysicsWorld
{
  private ArrayList<Body> bodies;
  private Vec2 gravity;
  
  public PhysicsWorld(Vec2 gravity)
  {
    bodies = new ArrayList<Body>();
    this.gravity = gravity.copy();
  }
  
  public Body createBody(BodyDesc desc)
  {
    Body body = new Body(desc);
    bodies.add(body);
    return body;
  }
  
  public void removeBody(Body body)
  {
    bodies.remove(body);
  }
  
  public void tick(float delta)
  {
    for(int i = 0; i < bodies.size(); i++)
    {
      Vec2 f = new Vec2();
      
      for(int j = 0; j < bodies.get(i).forces.size(); j++)
      {
        f.addEqual(bodies.get(i).forces.get(j));
      }
      
      for(int j = 0; j < bodies.get(i).impulses.size(); j++)
      {
        f.addEqual(bodies.get(i).impulses.get(j));
      }
      bodies.get(i).impulses.clear();
      
      bodies.get(i).accel = f.div(bodies.get(i).mass).add(gravity);
      bodies.get(i).vel.addEqual(bodies.get(i).accel.mult(delta));
      bodies.get(i).pos.addEqual(bodies.get(i).vel.mult(delta));
    }
  }
}