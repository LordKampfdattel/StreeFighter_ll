public enum CCType {
  
}

abstract class DynamicGameObject extends GameObject {        //die objets die auch agierren kennen:
  private int damage;
  private int attackSpeed;
  private int defense;
  private int agility;  //Beweglichkeit
  
  private Vec2 lineOfSight;    //weil man auch woander hingucken kann als da wo man hingeht.
  
  private ArrayList<CCType> ccs;
  
  
  public DynamicGameObject(Vec2 pos, int damage, int attackSpeed, int defense, int agility) {
    super(pos);
    
    this.damage=damage;
    this.attackSpeed=attackSpeed;
    this.defense=defense;
    this.agility=agility;
  }
  
  
  abstract public void update();
  
  abstract public void render();
  
  
  public Vec2 getLineOfSight() {
    return this.lineOfSight;
  }
  
  
  public int getDamage() {
    return this.damage;
  }
  
  public int getAttackSpeed() {
    return this.attackSpeed;
  }
  
  public int getDefense() {
    return this.defense;
  }
  
  public int getAgility() {
    return this.agility;
  }
  
  public ArrayList<CCType> getCCs() {
    return this.ccs;
  }
}