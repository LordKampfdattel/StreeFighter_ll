class Body {
  private Vec2 pos;
  private ArrayList<Force> forces;
  private Hitbox box;
  
  private float mass;
  
  private boolean Static;
  
  
  public Body(Vec2 pos, Vec2 size, float mass, boolean Static) {
    this.pos = new Vec2();
    this.pos=pos;
    this.forces = new ArrayList<Force>();
    this.box=new Hitbox(this.pos, size);
    this.mass = mass;
    this.Static=Static;
    
    this.forces.add(new Force("", new Vec2(0, 7)));
  }
  
  //-------------------------------------------------------------------------------------------------------------------
  private class Hitbox {    //AABB
    private Vec2 pos;
    private Vec2 size;
    
    
    public Hitbox(Vec2 pos, Vec2 size) {
      this.pos=pos;
      this.size=size;
    }
    
    
    public Vec2 getPos() {
      return this.pos;
    }
    
    public void setPos(Vec2 pos) {
      this.pos=pos;
    }
    
    public Vec2 getSize() {
      return this.size;
    }
    
    
    public boolean collide(Hitbox other, Vec2 vv) {
      Vec2 otherPos = other.getPos().add(vv);
      
      if(abs(this.pos.x-otherPos.x)<this.getSize().x+other.getSize().x) {
        if(abs(this.pos.y-otherPos.y)<this.getSize().y+other.getSize().y) {
          return true;
        }
      }
      return false;
    }
    
    public boolean collide(Vec2 v, Hitbox other, Vec2 vv) {
      if(abs(this.pos.add(v).x-other.getPos().add(vv).x)<this.getSize().x+other.getSize().x) {
        if(abs(this.pos.add(v).y-other.getPos().add(vv).y)<this.getSize().y+other.getSize().y) {
          return true;
        }
      }
      return false;
    }
    
    public Vec2 collideDetailed(Vec2 v, Hitbox other, Vec2 vv) {
      if(this.collide(v, other, vv)) {
        return new Vec2(this.pos.add(v).x-other.getPos().add(vv).x-(this.getSize().x/2+other.getSize().x/2), this.pos.add(v).y-other.getPos().add(vv).y-(this.getSize().y/2+other.getSize().y/2));
      }
      
      return null;
    }
  }
  //-------------------------------------------------------------------------------------------------------------------
  
  
  
  public boolean collide(Body other, Vec2 vv) {
    return this.box.collide(other.getBox(), vv);
  }
  
  
  
  public Vec2 getPos() {
    return this.pos;
  }
  
  public float getMass() {
    return this.mass;
  }
  
  public Force getAllForces() {
    Vec2 vv = new Vec2();
    
    for(int i=0 ; i<this.forces.size() ; i++) {
      Force mf = (Force) this.forces.get(i);
      
      vv = vv.add(mf.getV());
    }
    
    return new Force("Gesamte Kraft", vv);
  }
  
  public ArrayList<Force> getForces() {
    return this.forces;
  }
  
  public void addForce(Force nf) {
    this.forces.add(nf);
  }
  
  public boolean hasForce(String s) {
    for(int i=0 ; i<this.forces.size() ; i++) {
      Force mf = (Force) this.forces.get(i);
      
      if(mf.getName() == s) {
        return true;
      }
    }
    
    return false;
  }
  
  public Hitbox getBox() {
    return this.box;
  }
  
  
  
  public void update() {
    //Hitbox:
    this.box.setPos(this.pos.copy());
    
    if(!this.Static) {
      this.correctPosition();
    }
  }
  
  public void render() {
    noFill();
    stroke(255);
    rect(this.pos.x-this.box.getSize().x/2, this.pos.y-this.box.getSize().y/2, this.box.getSize().x, this.box.getSize().y);
  }
  
  
  
  private void move(Vec2 v) {
    this.pos = this.pos.add(v);
  }
  
  private void move(float x, float y) {
    this.pos = this.pos.add(new Vec2(x, y));
  }
  
  private void correctPosition() {
    boolean allreadyMoved=false;
    
    for(int i=0 ; i<TheWorld.getBodies().size() ; i++) {
      Body mb = (Body) TheWorld.getBodies().get(i);
      
      if(mb!=this) {
        if(this.box.collide(this.getAllForces().getV(), mb.getBox(), mb.getAllForces().getV())) {
          this.move(0, this.getAllForces().getV().add(this.box.collideDetailed(this.getAllForces().getV(), mb.getBox(), mb.getAllForces().getV())).y);
          allreadyMoved=true;
        }
      }
    }
    
    if(!allreadyMoved) {
      this.move(this.getAllForces().getV());
    }
  }
}