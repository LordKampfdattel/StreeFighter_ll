//-------------------------------------------------------------------------------------------------------------------
public enum Constants {
  G(6.67408*pow(10, -11)),
  g(9.81);
  
  private final float value;
  
  Constants(float value) {
    this.value=value;
  }
  
  public float  value() { return this.value; }
}

//-------------------------------------------------------------------------------------------------------------------

class World {
  private ArrayList<Body> bodyColl;
  
  
  public World() {
    this.bodyColl = new ArrayList<Body>();
  }
  
  
  public void run() {
    this.updateEverything();
    this.renderEverything();
  }
  
  
  private void updateEverything() {
    //updateGravaty:
    this.updateGravity();
    
    for(int i=0 ; i<this.bodyColl.size() ; i++) {
      Body mb = (Body) this.bodyColl.get(i);
      
      mb.update();
    }
  }
  
  private void renderEverything() {
    for(int i=0 ; i<this.bodyColl.size() ; i++) {
      Body mb = (Body) this.bodyColl.get(i);
      
      mb.render();
    }
  }
  
  
  
  private void updateGravity() {
    for(int i=0 ; i<this.bodyColl.size() ; i++) {
      Body mb = (Body) bodyColl.get(i);
      
      if(!mb.hasForce("Gravety")) {
        mb.addForce(new Force("Gravety", new Vec2(0, Constants.G.value()*((mb.getMass()+10000000)/(1000000)))));
      }
    }
  }
  
  
  
  public ArrayList<Body> getBodies() {
    return this.bodyColl;
  }
  
  public void addBody(Body b) {
    this.bodyColl.add(b);
  }
  
  public void removeBody(Body b) {
    this.bodyColl.remove(b);
  }
}