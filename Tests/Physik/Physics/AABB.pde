class CollisionResult
{
  Vec2 normal;
  float penetration;
}

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
  
  public AABB copy()
  {
    return new AABB(min, max);
  }
  
  public Vec2 getCenter()
  {
    return min.add(max.sub(min).div(2));
  }
  
  public boolean collides(AABB other)
  {
    if(max.x < other.min.x) return false;
    if(min.x > other.max.x) return false;
    if(max.y < other.min.y) return false;
    if(min.y > other.max.y) return false;
    return true;
  }
  
  public CollisionResult calcCollisionResult(AABB other)
  {
    CollisionResult result = new CollisionResult();
    result.normal = new Vec2();
    result.penetration = 0;
    
    Vec2 n = other.getCenter().sub(getCenter());
    float extent = (max.x - min.x) / 2;
    float otherExtent = (other.max.x - other.min.x) / 2;
    float xOverlap = extent + otherExtent - Math.abs(n.x);
    
    if(xOverlap > 0)
    {
      extent = (max.y - min.y) / 2;
      otherExtent = (other.max.y - other.min.y) / 2;
      float yOverlap = extent + otherExtent - Math.abs(n.y);
      
      if(yOverlap > 0)
      {
        if(xOverlap > yOverlap)
        {
          if(n.x < 0) result.normal = new Vec2(-1, 0);
          else result.normal = new Vec2(1, 0);
          result.penetration = xOverlap;
        }
        else
        {
          if(n.y < 0) result.normal = new Vec2(0, 1);
          else result.normal = new Vec2(0, -1);
          result.penetration = yOverlap;
        }
      }
    }
    
    return result;
  }
}