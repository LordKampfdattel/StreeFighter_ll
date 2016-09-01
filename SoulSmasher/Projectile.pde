//--------------------------------------------------------------------------------------------------------------

public enum MovementType {
  Normal,
  Following, 
  Special
}

//--------------------------------------------------------------------------------------------------------------


class Projectile extends GameObject {
  private DynamicGameObject owner;
  private DynamicGameObject target=null;
  private Vec2 dir;
  private int livingTime=0;
  private float speed;
  private int damage;
  private XML script;
  private Function function;
  private MovementType movementType=MovementType.Normal;
  
  
  //------------------------------------------------------------------------------------------------------------
  
  private class Function {
    private String function;
    private float x;
    private float xs;
    
    
    public Function(String function, float xs) {
      this.function=function;
      this.x=0;
      this.xs=xs;
    }
    
    //getter:
    public String getFunction() {
      return this.function;
    }
    
    public float getX() {
      return this.x;
    }
    
    public float getXs() {
      return this.xs;
    }
  }
  
  //------------------------------------------------------------------------------------------------------------
  
  
  public Projectile(Vec2 pos, DynamicGameObject owner, XML script) {
    super(pos);
    
    this.owner = owner;
    
    this.script=script;
    
    for(int i=0 ; i<this.script.getChildren().length ; i++) {
      if(this.script.getChildren()[i].getName()=="Statts") {
        this.setStatts(this.script.getChildren()[i].getChildren());
      }
    }
  }
  
  
  
  private void setStatts(XML[] children) {
    for(int i=0 ; i<children.length ; i++) {
      if(children[i].getName()=="setDamage") {
        
      }
      
      if(children[i].getName()=="setSpeed") {
        
      }
      
      if(children[i].getName()=="setFunction") {
        
      }
      
      if(children[i].getName()=="setMovementType") {
        
      }
    }
  }
  
  
  private void manageBehavior(XML[] children) {
    for(int i=0 ; i<children.length ; i++) {
      
    }
  }
  
  
  
  
  
  
  public void update() {
    this.livingTime++;
    
    for(int i=0 ; i<this.script.getChildren().length ; i++) {
      if(this.script.getChildren()[i].getName()=="Behavior") {
        this.manageBehavior(this.script.getChildren()[i].getChildren());
      }
    }
  }
  
  public void render() {
    
  }
  
  
  //Befehle:
  private void setDirection(Vec2 dir) {
    this.dir=dir;
  }
  
  private void setDamage(int damage) {
    this.damage=damage;
  }
  
  private void setSpeed(float speed) {
    this.speed = speed;
  }
  
  private void setFunction(String function, float xs) {
    this.function = new Function(function, xs);
  }
  
  private void setMovementType(String type) {
    if(type == "Normal") {
      this.movementType=MovementType.Normal;
    }
    if(type == "Following") {
      this.movementType=MovementType.Following;
    }
    if(type == "Special") {
      this.movementType=MovementType.Special;
    }
  }
  
  private void target(DynamicGameObject o) {
    this.target=o;
  }
  
  private void changeSpeedSlowTo(float speed, float factor) {
    this.speed = this.speed+(this.speed-speed)*factor;
  }
  
  private void changeDirectionSlowTo(Vec2 dir, float factor) {
    this.dir.x = this.dir.x+(this.dir.x-dir.x)*factor;
    this.dir.y = this.dir.y+(this.dir.y-dir.y)*factor;
  }
  
  private void setMovement(Function function) {          //da muss noch ne funktion übergeben werden die auch abgeleitet werden muss
    this.function = function;
  }
}