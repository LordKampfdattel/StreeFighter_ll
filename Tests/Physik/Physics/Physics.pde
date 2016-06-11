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
  b1 = world.createBody(desc);
  
  desc.position = new Vec2(400, 50);
  desc.mass = 0.1f;
  b2 = world.createBody(desc);
  b2.addForce(new Vec2(0, 100));
  
  desc.position = new Vec2(600, 400);
  desc.mass = 1;
  b3 = world.createBody(desc);
  b3.addImpulse(new Vec2(-2000, -5000));
  
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