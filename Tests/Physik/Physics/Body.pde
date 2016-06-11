class BodyDesc
{
  Vec2 position;
  float mass;
  Collider collider;
}

class Body
{
  Vec2 position;
  Vec2 velocity;
  float mass;
  Collider collider;
  ArrayList<Vec2> impulses;
  ArrayList<Vec2> forces;
  
  Body(BodyDesc desc)
  {
    position = desc.position.copy();
    velocity = new Vec2();
    mass = desc.mass;
    collider = desc.collider;
    impulses = new ArrayList<Vec2>();
    forces = new ArrayList<Vec2>();
  }
  
  void addImpulse(Vec2 impulse)
  {
    impulses.add(impulse);
  }
  
  int addForce(Vec2 force)
  {
    for(int i = 0; i < forces.size(); i++)
    {
      if(forces.get(i).x == 0 && forces.get(i).y == 0)
      {
        forces.set(i, force);
        return i;
      }
    }
    
    forces.add(force);
    return forces.size() - 1;
  }
  
  void removeForce(int index)
  {
    if(index >= 0 && index < forces.size())
    {
      forces.set(index, new Vec2());
    }
  }
}