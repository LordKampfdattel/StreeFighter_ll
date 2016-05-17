PhysicsWorld world;
Body body;

void setup()
{
  size(800, 600);
  
  world = new PhysicsWorld(new Vec2(0, 100));
  
  BodyDesc desc = new BodyDesc();
  desc.pos = new Vec2(200, 300);
  desc.mass = 1;
  desc.collider = new AABB(new Vec2(), new Vec2());
  body = world.createBody(desc);
  
  BodyDesc desc2 = new BodyDesc();
  desc2.pos = new Vec2(400, 300);
  desc2.mass = 10;
  desc2.collider = new AABB(new Vec2(), new Vec2());
  world.createBody(desc2);
  
  BodyDesc desc3 = new BodyDesc();
  desc3.pos = new Vec2(600, 300);
  desc3.mass = 100;
  desc3.collider = new AABB(new Vec2(), new Vec2());
  world.createBody(desc3);
  
  
  //body.addImpulse(new Vec2(0, -10000));
}

void draw()
{
  world.tick(1.0f / 60.0f);
  
  background(255, 255, 255);
  
  fill(255, 0, 0);
  
  for(int i = 0; i < world.bodies.size(); i++)
  {
    rect(world.bodies.get(i).pos.x - 50,world.bodies.get(i).pos.y - 50, 100, 100);
  }
}