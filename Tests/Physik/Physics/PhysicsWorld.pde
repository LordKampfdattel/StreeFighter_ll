import java.util.ArrayList;

class PhysicsWorld
{
  private ArrayList<Body> bodies;
  private Vec2 gravity;
  
  public PhysicsWorld(Vec2 gravity)
  {
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
    
  }
}