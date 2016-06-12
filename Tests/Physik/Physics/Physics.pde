float last = 0;
float time = 0;
PhysicsEngine world = new PhysicsEngine(new Vec2(0, 100));
Body b1, b2, b3, b4;

void drawBody(Body b)
{
  resetMatrix();
  translate(b.position.x, b.position.y);
  fill(255, 255, 255);
  
  float w, h;
  w = ((AABB)b.collider).halfSize.x;
  h = ((AABB)b.collider).halfSize.y;
  rect(-w, -h, 2 * w, 2 * h);
}

void setup()
{
  size(800, 600);
  frameRate(60);
  
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
  b2.addForce(new Vec2(0, 100));
  
  desc = new BodyDesc();
  desc.position = new Vec2(600, 400);
  desc.mass = 1;
  desc.collider = new AABB(desc.position, new Vec2(25, 25));
  b3 = world.createBody(desc);
  b3.addImpulse(new Vec2(-12000, -4000));
  
  desc = new BodyDesc();
  desc.position = new Vec2(400.f, 500.f);
  desc.mass = 0;
  desc.collider = new AABB(desc.position, new Vec2(500, 10));
  b4 = world.createBody(desc);
  
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
  
  System.out.println(b1.position.x + " " + b1.position.y);
  
  drawBody(b1);
  drawBody(b2);
  drawBody(b3);
  drawBody(b4);
}