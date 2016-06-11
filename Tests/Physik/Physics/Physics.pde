float last = 0;
float time = 0;
PhysicsEngine world = new PhysicsEngine(new Vec2(0, 100));
Body b1, b2, b3;

void drawBody(Body b)
{
  resetMatrix();
  translate(b.position.x, b.position.y);
  fill(255, 255, 255);
  rect(-25, -25, 50, 50);
}

void setup()
{
  size(800, 600);
  
  BodyDesc desc = new BodyDesc();
  desc.position = new Vec2(200, 100);
  desc.mass = 1;
  desc.collider = new AABB(desc.position, new Vec2(25, 25));
  b1 = world.createBody(desc);
  b1.addImpulse(new Vec2(1000, 7000));
  
  desc = new BodyDesc();
  desc.position = new Vec2(400, 50);
  desc.mass = 0.1f;
  desc.collider = new AABB(desc.position, new Vec2(25, 25));
  b2 = world.createBody(desc);
  b2.addForce(new Vec2(0, 40));
  
  desc = new BodyDesc();
  desc.position = new Vec2(600, 400);
  desc.mass = 1;
  desc.collider = new AABB(desc.position, new Vec2(25, 25));
  b3 = world.createBody(desc);
  b3.addImpulse(new Vec2(-10000, -4000));
  
  last = (float)millis() / 1000.f;
}

void draw()
{
  background(#dddddd);
  
  float cur = (float)millis() / 1000.f;
  float delta = cur - last;
  last = cur;
  time += delta;
  
  world.update(delta);
  
  drawBody(b1);
  drawBody(b2);
  drawBody(b3);
}