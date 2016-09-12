//--------------------------------------------------------------------------------------------------------------

public enum MovementType {
  Normal,
  Following, 
  Special
}

//--------------------------------------------------------------------------------------------------------------



public interface AngleFunc {
  public abstract float get(float t);
}

public class LinearAngleFunc implements AngleFunc {
  private float m;
  private int startTime;
  
  public LinearAngleFunc(float m, int startTime) {
    this.m = m;
    this.startTime = startTime;
  }
  
  public float get(float t) {
    return m * (t - startTime);
  }
}



class Projectile extends GameObject {
  private PImage img;
  private float imgScale;
  private Animation animation;
  private DynamicGameObject owner;
  //private DynamicGameObject target=null;
  private Vec2 dir;
  private int livingTime=0;
  private float speed;
  private int damage;
  private XML script;
  private LinearAngleFunc function;
  private MovementType movementType=MovementType.Normal;
  
  //fuer den Getroffenden Gegner um den zu debuffen
  private int chance;        //in %
  
  private int damageInfluence=0;
  private int attackSpeedInfluence=0;
  private int defenseInfluence=0;
  private int agilityInfluence=0;  //Beweglichkeit
  
  
  //------------------------------------------------------------------------------------------------------------
  
  
  
  
  
  //private class Function {                      //WICHTIG: man muss die ableitung angeben!!!!!
  //  private String functionType;
    
  //  private int degree;
  //  private float[] values;
    
  //  private float a;
  //  private float d;          //verschiebung
    
  //  private float x;
  //  private float xs;
    
    
  //  public Function(int degree, float[] values, float xs) {            //Polynom ; degree=grad
  //    this.degree=degree;
      
  //    this.values = new float[this.degree+1];
  //    this.values=values;
    
  //    this.x=0;
  //    this.xs=xs;
      
  //    this.functionType = "Polynomial";
  //  }
    
  //  public Function(float a, float d, float xs) {
  //    this.a=a;
  //    this.d=d;
      
  //    this.xs=xs;
      
  //    this.functionType = "Sinus";
  //  }
    
    
    
  //  public void update() {
  //    this.x++;
  //  }
    
    
  //  public void reset() {
  //    this.x=0;
  //  }
    
    
  //  //getter:    
  //  public float getX() {
  //    return this.x;
  //  }
    
  //  public float getXs() {
  //    return this.xs;
  //  }
    
  //  public float getValue() {
  //    float finalValue=0;
      
  //    if(this.functionType == "Polynomial") {
  //      for(int i=0 ; i<this.values.length ; i++) {
  //        float value = this.values[this.values.length-1-i];
          
  //        if(i == 0) {
  //          finalValue += value;
  //        }else {
  //          finalValue += value*(pow(this.x*this.xs, this.degree-i-1));
  //        }
  //      }
        
  //      return finalValue;
  //    }
      
  //    if(this.functionType == "Sinus") {
  //      return this.a*sin((this.x*this.xs)-this.d);
  //    }
      
  //    return 0;
  //  }
    
  //  public float getValue(float time) {
  //    float finalValue=0;
      
  //    if(this.functionType == "Polynomial") {
  //      for(int i=0 ; i<this.values.length ; i++) {
  //        float value = this.values[this.values.length-1-i];
          
  //        if(i == 0) {
  //          finalValue += value;
  //        }else {
  //          finalValue += value*(pow(time*this.xs, this.degree-i-1));
  //        }
  //      }
        
  //      return finalValue;
  //    }
      
  //    if(this.functionType == "Sinus") {
  //      return this.a*sin(time*this.xs-this.d);
  //    }
      
  //    return 0;
  //  }
    
  //  public float getAlphaDeg() {
  //    return 180 - (180 - 90 - atan(abs(this.getValue())));       //       HIER IST DER FEHLER!!!
  //  }
    
  //  public float getAlphaDeg(float time) {
  //    return 180 - (180 - 90 - atan(abs(this.getValue(time))));
  //  }
    
  //  public float getAlphaRad() {
  //    float deg = 180 - (180 - 90 - atan(abs(this.getValue())));
      
  //    return deg*(PI/180);
  //  }
    
  //  public float getAlphaRad(float time) {
  //    float deg = 180 - (180 - 90 - atan(abs(this.getValue(time))));
      
  //    return deg*(PI/180);
  //  }
    
  //  public String getType() {
  //    return this.functionType;
  //  }
  //}
  
  //------------------------------------------------------------------------------------------------------------
  
  
  public Projectile(Vec2 pos, Vec2 startDir, DynamicGameObject owner, XML script) {
    super(pos);
    
    this.dir = new Vec2();
    this.dir = startDir;
    
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
      if(children[i].getName()=="setDamageInfluence") {
        this.setDamageInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setAttackSpeedInfluence") {
        this.setAttackSpeedInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setDefenseInfluence") {
        this.setDefenseInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setAgilityInfluence") {
        this.setAgilityInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setRandomDirection") {
        this.setRandomDirection();
      }
      
      if(children[i].getName()=="setRandomSpeed") {
        this.setRandomSpeed(children[i].getFloat("min"), children[i].getFloat("max"));
      }
      
      if(children[i].getName()=="setDirection") {
        this.setDirection(new Vec2(children[i].getFloat("x"), children[i].getFloat("y")));
      }
      
      if(children[i].getName()=="setImage") {
        this.setImage(children[i].getString("Path"), children[i].getFloat("Scale"));
      }
      
      if(children[i].getName()=="setAnimation") {
        this.setAnimation(children[i].getString("Path"), children[i].getFloat("SpriteWidth"), children[i].getFloat("SpriteHeight"), children[i].getFloat("Speed"), children[i].getFloat("Scale"));
      }
      
      if(children[i].getName()=="setDamage") {
        this.setDamage(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setSpeed") {
        this.setSpeed(children[i].getFloat("Value"));
      }
      
      if(children[i].getName()=="setPolynomialFunction") {
        float[] values = new float[children[i].getInt("Degree")+1];
        
        for(int j=0 ; j<children[i].getInt("Degree")+1 ; j++) {
          values[j] = children[i].getFloat("Value"+j);
        }
        
        this.setPolynomialFunction(children[i].getInt("Degree"), values, children[i].getFloat("xs"));
      }
      
      if(children[i].getName()=="setSinusFunction") {
        this.setSinusFunction(children[i].getFloat("a"), children[i].getFloat("d"), children[i].getFloat("xs"));
      }
      
      if(children[i].getName()=="setMovementType") {
        this.setMovementType(children[i].getString("Type"));
      }
    }
  }
  
  
  private void manageBehavior(XML[] children) {
    for(int i=0 ; i<children.length ; i++) {
      if(children[i].getName()=="setDamageInfluence") {
        this.setDamageInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setAttackSpeedInfluence") {
        this.setAttackSpeedInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setDefenseInfluence") {
        this.setDefenseInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setAgilityInfluence") {
        this.setAgilityInfluence(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setRandomDirection") {
        this.setRandomDirection();
      }
      
      if(children[i].getName()=="setRandomSpeed") {
        this.setRandomSpeed(children[i].getFloat("min"), children[i].getFloat("max"));
      }
      
      if(children[i].getName()=="setDirection") {
        this.setDirection(new Vec2(children[i].getFloat("x"), children[i].getFloat("y")));
      }
      
      if(children[i].getName()=="setDamage") {
        this.setDamage(children[i].getInt("Value"));
      }
      
      if(children[i].getName()=="setSpeed") {
        this.setSpeed(children[i].getFloat("Value"));
      }
      
      if(children[i].getName()=="setPolynomialFunction") {
        float[] values = new float[children[i].getInt("Degree")+1];
        
        for(int j=0 ; j<children[i].getInt("Degree")+1 ; j++) {
          values[j] = children[i].getFloat("Value"+j);
        }
        
        this.setPolynomialFunction(children[i].getInt("Degree"), values, children[i].getFloat("xs"));
      }
      
      if(children[i].getName()=="setSinusFunction") {
        this.setSinusFunction(children[i].getFloat("a"), children[i].getFloat("d"), children[i].getFloat("xs"));
      }
      
      if(children[i].getName()=="setMovementType") {
        this.setMovementType(children[i].getString("Type"));
      }
      
      if(children[i].getName()=="moveNormal") {
        this.moveNormal();
      }
      
      if(children[i].getName()=="targetPlayer") {
        this.targetPlayer(children[i].getFloat("dist"));
      }
      
      if(children[i].getName()=="targetNearEnemy") {
        this.targetNearEnemy(children[i].getFloat("dist"));
      }
      
      if(children[i].getName()=="moveSpecial") {
        this.moveSpecial();
      }
      
      if(children[i].getName()=="changeSpeedSlowTo") {
        this.changeSpeedSlowTo(children[i].getFloat("Value"), children[i].getFloat("Factor"));
      }
      
      if(children[i].getName()=="changeDirectionSlowTo") {
        this.changeDirectionSlowTo(new Vec2(children[i].getFloat("x"), children[i].getFloat("y")), children[i].getFloat("Factor"));
      }
    }
  }
  
  
  
  
  
  
  public void update() {
    this.livingTime++;
    
    if(this.function != null) {
      //this.function.update();
    }
    
    if(this.animation != null) {
      this.animation.update();
    }
    
    for(int i=0 ; i<this.script.getChildren().length ; i++) {
      if(this.script.getChildren()[i].getName()=="Behavior") {
        this.manageBehavior(this.script.getChildren()[i].getChildren());
      }
    }
  }
  
  public void render() {
    //Images scales!!!!!
    if(this.animation != null) {
      translate(super.getPosition().x, super.getPosition().y);
      rotate(this.dir.heading());
      this.animation.drawImage();
      resetMatrix();
    }else {
      translate(super.getPosition().x, super.getPosition().y);
      rotate(this.dir.heading());
      scale(this.imgScale, this.imgScale);
      image(this.img, -this.img.width/2, -this.img.height/2);
      resetMatrix();
    }
  }
  
  
  //Befehle:
  private void setImage(String path, float scale) {
    this.animation=null;
    
    this.img = loadImage("data/Projectile/Images/"+path+".png");
    this.imgScale=scale;
  }
  
  private void setAnimation(String path, float spriteWidth, float spriteHeight, float speed, float scale) {
    this.img=null;
    
    this.animation = new Animation(loadImage("data/Projectile/Animations/"+path+".png"), spriteWidth, spriteHeight, speed, scale, true, false);
  }
  
  private void setDirection(Vec2 dir) {
    this.dir=dir;
  }
  
  private void setRandomDirection() {
    this.dir = new Vec2(random(-10, 10), random(-10, 10));
  }
  
  private void setDamage(int damage) {
    this.damage=damage;
  }
  
  private void setSpeed(float speed) {
    this.speed = speed;
  }
  
  private void setRandomSpeed(float min, float max) {
    this.speed = random(min, max);
  }
  
  private void setPolynomialFunction(int degree, float[] values, float xs) {
    //this.function = new Function(degree, values, xs);
    this.function = new LinearAngleFunc(0.001f, this.livingTime);
  }
  
  private void setSinusFunction(float a, float d, float xs) {
    //this.function = new Function(a, d, xs);
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
  
  private void moveNormal() {
    Vec2 vv = new Vec2();
    vv = this.dir;
    vv.normalize();
    vv = vv.mult(this.speed);
    super.move(vv);
  }
  
  private void targetPlayer(float dist) {
    if(dist == -1) {        //dist --> infinite
      Vec2 vv = new Vec2(TheGame.getPlayer().getPosition().x - super.getPosition().x, TheGame.getPlayer().getPosition().y - super.getPosition().y);
      vv.normalize();
      vv.mult(this.speed);
      super.move(vv);
    }else {
      if(dist(super.getPosition().x, super.getPosition().x, TheGame.getPlayer().getPosition().x, TheGame.getPlayer().getPosition().x) <= dist) {
        Vec2 vv = new Vec2(TheGame.getPlayer().getPosition().x-super.getPosition().x, TheGame.getPlayer().getPosition().y-super.getPosition().y);
        vv.normalize();
        vv.mult(this.speed);
        super.move(vv);
      }else {
        this.moveNormal();
      }
    }
  }
  
  private void targetNearEnemy(float dist) {
    DynamicGameObject to=null;
    
    for(int i=0 ; i<TheGame.getGameObjects().size() ; i++) {
      try {
        DynamicGameObject mo = (DynamicGameObject) TheGame.getGameObjects().get(i);
        
        if(to == null) {
          to=mo;
        }else {
          if(dist(super.getPosition().x, super.getPosition().y, mo.getPosition().x, mo.getPosition().y) < dist(super.getPosition().x, super.getPosition().y, to.getPosition().x, to.getPosition().y)) {
            to=mo;
          }
        }
      }catch (Exception e) {
        
      }
    }
    
    if(dist == -1) {        //dist --> infinite
      if(to != null) {
        Vec2 vv = new Vec2(to.getPosition().x-super.getPosition().x, to.getPosition().y-super.getPosition().y);
        vv.normalize();
        vv.mult(this.speed);
        super.move(vv);
      }
    }else {
      if(to != null) {
        if(dist(super.getPosition().x, super.getPosition().y, to.getPosition().x, to.getPosition().y) <= dist) {
          Vec2 vv = new Vec2(to.getPosition().x-super.getPosition().x, to.getPosition().y-super.getPosition().y);
          vv.normalize();
          vv.mult(this.speed);
          super.move(vv);
        }else {
          this.moveNormal();
        }
      }
    }
  }
  
  private void moveSpecial() {
    if(this.function != null) {
      //Vec2 VV = new Vec2(0, this.speed);
      /*Vec2 VV  = new Vec2();
      VV = this.dir.copy();
      VV.normalize();
      VV = VV.mult(this.speed);
      //println(this.function.getAlphaDeg());
      VV.rotate(this.function.get(this.livingTime));
      super.move(VV);*/
      //...
      //...
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //...
      //...
      
      this.dir = new Vec2(sin(function.get(this.livingTime)), -cos(function.get(livingTime)));
      super.move(dir.mult(this.speed));
    }
  }
  
  private void changeSpeedSlowTo(float speed, float factor) {
    this.speed = this.speed+(this.speed-speed)*factor;
  }
  
  private void changeDirectionSlowTo(Vec2 dir, float factor) {
    this.dir.x = this.dir.x+(this.dir.x-dir.x)*factor;
    this.dir.y = this.dir.y+(this.dir.y-dir.y)*factor;
  }
  
  private void setDamageInfluence(int value) {
    this.damageInfluence = value;
  }
  
  private void setAttackSpeedInfluence(int value) {
    this.attackSpeedInfluence = value;
  }
  
  private void setDefenseInfluence(int value) {
    this.defenseInfluence = value;
  }
  
  private void setAgilityInfluence(int value) {
    this.agilityInfluence = value;
  }
}