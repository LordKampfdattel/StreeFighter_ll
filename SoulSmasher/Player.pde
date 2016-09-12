public enum classType {
  Ranger, 
  PetMaster
}

class Player extends DynamicGameObject {
  private classType classType;
  
  public Player(Vec2 pos, classType classType) {
    super(pos, 0, 0, 0, 0, false);
    
    this.classType=classType;
  }
  
  
  public void update() {
    
  }
  
  public void render() {
    
  }
  
  
  public classType giveType() {
    return this.classType;
  }
}