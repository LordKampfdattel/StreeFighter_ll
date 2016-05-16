class AABB
{
  public Vec2 min;
  public Vec2 max;

  public AABB()
  {
    this.min = new Vec2();
    this.max = new Vec2();
  }

  public AABB(Vec2 min, Vec2 max)
  {
    this.min = min.copy();
    this.max = max.copy();
  }
  
  public boolean collides(AABB other)
  {
    if(max.x < other.min.x) return false;
    if(min.x > other.max.x) return false;
    if(max.y < other.min.y) return false;
    if(min.y > other.max.y) return false;
    return true;
  }
  
  public Vec2 resolve(AABB other)
  {
    float xOverlap = 0.0f, yOverlap = 0.0f;
    
    float centerX = (min.x + max.x) / 2.0f;
    float otherCenterX = (other.min.x + other.max.x) / 2.0f;
    float centerY = (min.y + max.y) / 2.0f;
    float otherCenterY = (other.min.y + other.max.y) / 2.0f;
    
    if(centerX < otherCenterX)
    {
      xOverlap = max.x - other.min.x;
    }
    else
    {
      xOverlap = other.max.x - min.x;
    }
    
    if(centerY < otherCenterY)
    {
      yOverlap = max.y - other.min.y;
    }
    else
    {
      yOverlap = other.max.y - min.y;
    }
    
    return new Vec2(xOverlap, yOverlap);
  }
}