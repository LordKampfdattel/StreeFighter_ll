class Collision
{
  Vec2 normal;
  float penetration;
  Body a, b;
}



class Interval
{
  float min, max;
  
  Interval(float min, float max)
  {
    this.min = min;
    this.max = max;
  }
  
  boolean intersects(Interval other)
  {
    return min <= other.max && other.min <= this.max;
  }
  float subtract(Interval other)
  {
    return min(max, other.max) - max(min, other.min);
  }
}



Interval projectPolygonOnAxis(Vec2[] points, Vec2 axis)
{
  Vec2 a = axis.copy();
  a.normalize();
  
  Interval interval = new Interval(Float.POSITIVE_INFINITY, Float.NEGATIVE_INFINITY);
  
  for(int i = 0; i < points.length; i++)
  {
    float dot = a.scalarMult(points[i]);
    
    if(dot < interval.min)
    {
      interval.min = dot;
    }
    else if(dot > interval.max)
    {
      interval.max = dot;
    }
  }
  
  return interval;
}



Collision aabbVsAABB(AABB a, AABB b)
{
  Vec2[] edges = a.getEdges();
  Vec2[] pointsA = a.getPoints();
  Vec2[] pointsB = b.getPoints();
  boolean collision = true;
  Vec2 normal = new Vec2();
  float penetration = Float.POSITIVE_INFINITY;
  
  for(int i = 0; i < edges.length; i++)
  {
    Vec2 edge = edges[i].copy();
    edge.normalize();
    
    Interval aProj = projectPolygonOnAxis(pointsA, edge);
    Interval bProj = projectPolygonOnAxis(pointsB, edge);
    
    if(!aProj.intersects(bProj))
    {
      collision = false;
      break;
    }
    
    float p = abs(bProj.subtract(aProj));
    if(p < penetration)
    {
      normal = edge.copy();
      penetration = p;
    }
  }
  
  if(collision)
  {
    Collision result = new Collision();
    result.normal = normal;
    result.penetration = penetration;
    
    return result;
  }
  else
  {
    return null;
  }
}



interface Collider
{
  abstract Collision collidesWith(Collider other);
  abstract Collision collidesWithAABB(AABB other);
  abstract void setCenter(Vec2 center);
}



class AABB implements Collider
{
  Vec2 center;
  Vec2 halfSize;
  
  AABB(Vec2 center, Vec2 halfSize)
  {
    this.center = center.copy();
    this.halfSize = halfSize.copy();
  }
  
  Vec2[] getPoints()
  {
    Vec2[] points = new Vec2[4];
    points[0] = center.add(new Vec2(-halfSize.x, -halfSize.y));
    points[1] = center.add(new Vec2(halfSize.x, -halfSize.y));
    points[2] = center.add(new Vec2(halfSize.x, halfSize.y));
    points[3] = center.add(new Vec2(-halfSize.x, halfSize.y));
    
    return points;
  }
  
  Vec2[] getEdges()
  {
    Vec2[] edges = new Vec2[4];
    Vec2[] points = getPoints();
    
    edges[0] = points[1].sub(points[0]);
    edges[1] = points[2].sub(points[1]);
    edges[2] = points[3].sub(points[2]);
    edges[3] = points[0].sub(points[3]);
    
    return edges;
  }
  
  Collision collidesWith(Collider other)
  {
    return other.collidesWithAABB(this);
  }
  Collision collidesWithAABB(AABB other)
  {
    return aabbVsAABB(other, this);
  }
  void setCenter(Vec2 center)
  {
    this.center = center.copy();
  }
}