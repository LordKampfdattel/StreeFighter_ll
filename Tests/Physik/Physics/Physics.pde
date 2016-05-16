class Thing
{
  private AABB collider;
  private static final float HALFSIZEX = 25;
  private static final float HALFSIZEY = 25;
  
  public Thing(Vec2 center)
  {
    collider = new AABB(new Vec2(center.x - HALFSIZEX, center.y - HALFSIZEY), 
      new Vec2(center.x + HALFSIZEX, center.y + HALFSIZEY));
  }
  
  public void move(Vec2 v)
  {
    collider.min.addEqual(v);
    collider.max.addEqual(v);
  }
  
  public void resolve(Thing other)
  {
    if(collider.collides(other.collider))
    {
      Vec2 overlap = collider.resolve(other.collider);
      move(overlap.x < overlap.y ? new Vec2(0, overlap.y) : new Vec2(overlap.x, 0));
    }
  }
  
  public void render()
  {
    fill(255, 0, 0);
    rect(collider.min.x, collider.min.y, 2 * HALFSIZEX, 2 * HALFSIZEY);
  }
}

ArrayList<Thing> things;
float speed = 20;
boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;

void setup()
{
  size(800, 600);
  
  things = new ArrayList<Thing>();
  things.add(new Thing(new Vec2(700, 300)));
  things.add(new Thing(new Vec2(500, 100)));
  things.add(new Thing(new Vec2(500, 300)));
  things.add(new Thing(new Vec2(500, 500)));
  things.add(new Thing(new Vec2(300, 300)));
}

void keyPressed()
{
  if(key == 'w')
  {
    moveUp = true;
  }
  else if(key == 's')
  {
    moveDown = true;
  }
  else if(key == 'a')
  {
    moveLeft = true;
  }
  else if(key == 'd')
  {
    moveRight = true;
  }
}

void keyReleased()
{
  if(key == 'w')
  {
    moveUp = false;
  }
  else if(key == 's')
  {
    moveDown = false;
  }
  else if(key == 'a')
  {
    moveLeft = false;
  }
  else if(key == 'd')
  {
    moveRight = false;
  }
}

void draw()
{
  if(moveLeft)
  {
    things.get(0).move(new Vec2(-speed, 0));
  }
  if(moveRight)
  {
    things.get(0).move(new Vec2(speed, 0));
  }
  if(moveUp)
  {
    things.get(0).move(new Vec2(0, -speed));
  }
  if(moveDown)
  {
    things.get(0).move(new Vec2(0, speed));
  }
  
  fill(255);
  rect(0, 0, width, height);
  
  for(int i = 0; i < things.size(); i++)
  {
    for(int j = 0; j < things.size(); j++)
    {
      if(i != j)
      {
        things.get(i).resolve(things.get(j));
      }
    }
    
    things.get(i).render();
  }
}