class Enemy extends DynamicGameObject {
  private XML script;
  private float speed;
  private ArrayList<String> states;
  private String curState;
  private int damageInfluence;
  private int attackSpeedInfluence;
  private int defenseInfluence;
  private int agilityInfluence;
  
  private int livingTime=0;
  
  //vision:
  private float visionAngle;
  private float visionDist;
  
  //Animations:
  private ArrayList<EnemyAnimation> animations;
  private EnemyAnimation curAnimation;
  
  
  
  //------------------------------------------------------------------------------------------------------------------------------------
  
  private class EnemyAnimation {
    private String name;
    private Animation animation;
    
    EnemyAnimation(Animation animation, String name) {
      this.name=name;
      this.animation=animation;
    }
    
    public String getName() {
      return this.name;
    }
    
    public Animation getAnimation() {
      return this.animation;
    }
  }
  
  //------------------------------------------------------------------------------------------------------------------------------------
  
  
  
  
  public Enemy(Vec2 pos, int damage, int attackSpeed, int defense, int agility, XML script) {
    super(pos, damage, attackSpeed, defense, agility);
    
    this.script=script;
    
    this.states = new ArrayList<String>();
    this.animations = new ArrayList<EnemyAnimation>();
    
    for(int i=0 ; i<this.script.getChildren().length ; i++) {
      if(this.script.getChildren()[i].getName()=="Statts") {
        this.setStatts(this.script.getChildren()[i].getChildren());
      }
    }
  }
  
  
  private void setStatts(XML[] children) {
    for(int i=0 ; i<children.length ; i++) {
      if(children[i].getName()=="setDamage") {
        this.setDamage(children[i].getInt("value"));
      }
      
      if(children[i].getName()=="setAttackSpeed") {
        this.setAttackSpeed(children[i].getInt("value"));
      }
      
      if(children[i].getName()=="setDefense") {
        this.setDefense(children[i].getInt("value"));
      }
      
      if(children[i].getName()=="setAgility") {
        this.setAgility(children[i].getInt("value"));
      }
      
      
      if(children[i].getName()=="addState") {
        this.addState(children[i].getString("Name"));
      }
      
      
      if(children[i].getName()=="setVision") {
        this.setVision(children[i].getFloat("Angle"), children[i].getFloat("Dist"));
      }
      
      
      if(children[i].getName()=="addAnimation") {
        this.addAnimation(new Animation(loadImage(children[i].getString("Path")), children[i].getFloat("Width"), children[i].getFloat("Height"), children[i].getFloat("Speed"), children[i].getFloat("Scale"), true, false), children[i].getString("Name"));
      }
    }
  }
  
  
  private void manageBehavior(XML[] children) {
    for(int i=0 ; i<children.length ; i++) {
      //Abfragen:
      if(children[i].getName()=="distBetweenPlayer") {
        if(this.distBetweenPlayer(children[i].getString("Operator"), children[i].getFloat("Dist"))) {
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      if(children[i].getName()=="ownLifeCondition") {
        if(this.ownLifeCondition(children[i].getString("Operator"), children[i].getFloat("Value"))) {
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      if(children[i].getName()=="playerLifeCondition") {
        if(this.playerLifeCondition(children[i].getString("Operator"), children[i].getFloat("Value"))) {
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      if(children[i].getName()=="hasCC") {
        if((this.hasCC(children[i].getString("CCType")) && children[i].getString("bool")=="true") || (!this.hasCC(children[i].getString("CCType")) && children[i].getString("bool")=="false")) {    //boolean auch in der skriptsprache damait es acuh flase sein kann!
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      if(children[i].getName()=="playerHasCC") {
        if((this.playerHasCC(children[i].getString("CCType")) && children[i].getString("bool")=="true") || (!this.playerHasCC(children[i].getString("CCType")) && children[i].getString("bool")=="false")) {
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      if(children[i].getName()=="frameCount") {
        if(this.frameCount(children[i].getInt("Wert"), children[i].getString("Operator"))) {            //operator[=, <, >, %]
          this.manageBehavior(children[i].getChildren());
        }
      }
      
      //in Vision...
        
        
      
      
      //Befehle:
      
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
  
  
  
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  //Befehle:
  private void move(float x, float y) {
    
  }
  
  private void follow(DynamicGameObject o) {
    
  }
  
  private void moveTo(Vec2 pos) {
    
  }
  
  private void circleAround(Vec2 pos) {
    
  }
  
  private void teleport(Vec2 pos) {
    
  }
  
  private void variateMovement(ArrayList<Vec2> directions, float tick) {
    
  }
  
  private void setAnimation(String name) {
    for(int i=0 ; i<this.animations.size() ; i++) {
      EnemyAnimation ma = (EnemyAnimation) this.animations.get(i);
      
      if(ma.getName() == name) {
        this.curAnimation=ma;
      }
    }
  }
  
  private void shoot(String scriptname, Vec2 direction) {
    
  }
  
  private void shoot(String scriptname, Vec2 pos, Vec2 direction) {
    
  }
  
  private void spawnEnemy(String scriptname, Vec2 pos) {
    
  }
  
  private void attack(float angle1, float angle2, float range) {
    
  }
   
  private void setState(String name) {
    
  }
    
  private void buff(String name, int value) {
    
  }
  
  private void debuff(String name, int value) {
    
  }
  
  
  
  //setter:
  private void setVision(float angle, float dist) {
    this.visionAngle=angle;
    this.visionDist=dist;
  }
  
  private void setDamage(int value) {
    super.damage=value;
  }
  
  private void setAttackSpeed(int value) {
    super.attackSpeed=value;
  }
  
  private void setDefense(int value) {
    super.defense=value;
  }
  
  private void setAgility(int value) {
    super.agility=value;
  }
  
  private void addState(String name) {      //fuer das verhalten(zb totStellen)
    this.states.add(name);
  }
  
  private void addAnimation(Animation a, String name) {
    this.animations.add(new EnemyAnimation(a, name));
  }
  
  
  
  //abfragen:
  private boolean distBetweenPlayer(String opareator, float value) {
    return false;
  }
  
  private boolean ownLifeCondition(String operator, float value) {
    return false;
  }
  
  private boolean playerLifeCondition(String operator, float value) {
    return false;
  }
  
  private boolean hasCC(String type) {
    return false;
  }
  
  private boolean playerHasCC(String type) {
    return false;
  }
  
  private boolean frameCount(int wert, String operator) {                  //mit livingTime machen
    return false;
  }
  
  private boolean inVision(GameObject o) {
    return false;
  }
}