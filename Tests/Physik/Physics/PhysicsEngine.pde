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
      if(bodies.get(i).invMass == 0) continue;
      
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
      
      Vec2 a = f.mult(bodies.get(i).invMass).add(gravity);
      bodies.get(i).velocity.addEqual(a.mult(time));
      bodies.get(i).position.addEqual(bodies.get(i).velocity.mult(time));
      bodies.get(i).collider.setCenter(bodies.get(i).position);
    }
    
    for(int i = 0; i < bodies.size(); i++)
    {
      if(bodies.get(i).invMass == 0) continue;
      
      for(int j = 0; j < bodies.size(); j++)
      {
        if(j != i)
        {
          Collision coll = bodies.get(i).collider.collidesWith(bodies.get(j).collider);
          
          if(coll != null)
          {
             bodies.get(i).position.subEqual(coll.normal.mult(coll.penetration));
            
             if(bodies.get(j).invMass != 0)
             {
              Vec2 v1 = bodies.get(i).velocity;
              float m1 = 1.f / bodies.get(i).invMass;
              Vec2 v2 = bodies.get(j).velocity;
              float m2 = 1.f / bodies.get(j).invMass;
              
              bodies.get(i).velocity = bodies.get(j).velocity = v1.mult(m1).add(v2.mult(m2)).div(m1 + m2);
             }
          }
        }
      }
    }
  }
}