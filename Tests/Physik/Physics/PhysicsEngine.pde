class PhysicsEngine
{
  Vec2 gravity;
  ArrayList<Body> bodies;
  
  PhysicsEngine(Vec2 gravity)
  {
    this.gravity = gravity.copy();
    bodies = new ArrayList<Body>();
  }
  
  Body createBody(BodyDesc desc)
  {
    Body b = new Body(desc);
    bodies.add(b);
    return b;
  }
  
  void removeBody(Body body)
  {
    bodies.remove(body);
  }
  
  void update(float time)
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
      
      Vec2 a = f.div(bodies.get(i).mass).add(gravity);
      bodies.get(i).velocity.addEqual(a.mult(time));
      bodies.get(i).position.addEqual(bodies.get(i).velocity.mult(time).add(a.mult(time).mult(time).mult(0.5)));
    }
  }
}