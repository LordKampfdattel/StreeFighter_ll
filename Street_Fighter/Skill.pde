//-----------------------------------------------------------------------------------------------------------------------
class SkillBox extends Hitbox {
  private int curLength;
  private int delay;
  private int activeLength;
    
    
  SkillBox(Vec2 pos, float boxWidth, float boxHeight, int activeLength, int delay) {
    super(pos, boxWidth, boxHeight);
    
    this.curLength=-delay;
    this.delay=delay;
    this.activeLength=activeLength;
  }
    
    
  public void update() {
    this.curLength++;
  }
  
  public void render() {
    if(this.isActive()) {
      super.render();
    }
  }
    
  public int giveActiveLength() {
    return this.activeLength;
  }
  
  public boolean isActive() {
    return this.curLength>0 && !this.finished();
  }
    
  public boolean finished() {
    return this.curLength>=this.activeLength;
  }
  
  public void reset() {
    this.curLength=-this.delay;
  }
}
//-----------------------------------------------------------------------------------------------------------------------



//-----------------------------------------------------------------------------------------------------------------------
class Skill {
  private Animation animation;
  
  public Skill(Animation animation) {
    this.animation=animation;
  }
  
  
  public Animation getAnimation() {
    return this.animation;
  }
}

//-----------------------------------------------------------------------------------------------------------------------

class ActiveSkill extends Skill {
  private ArrayList<SkillBox> boxes;
  
  public ActiveSkill(Animation animation, ArrayList<SkillBox> boxes) {
    super(animation);
    
    this.boxes = new ArrayList<SkillBox>();
    this.boxes = boxes;
  }
  
  
  public void update() {
    super.getAnimation().update();
    
    for(int i=0 ; i<this.boxes.size() ; i++) {
      SkillBox mb = (SkillBox) this.boxes.get(i);
      mb.update();
    }
    
    //reseting SkillBoxes:
    if(super.getAnimation().finished() && super.getAnimation().isLooped()) {
      this.resetSkillBoxes();
    }
  }
  
  
  private void resetSkillBoxes() {
    for(int i=0 ; i<this.boxes.size() ; i++) {
      SkillBox mb = (SkillBox) this.boxes.get(i);
      mb.reset();
    }
  }
  
  
  public ArrayList<SkillBox> getBoxes() {
    return this.boxes;
  }
  
  public boolean collideWithBoxes(Hitbox h) {
    for(int i=0 ; i<this.boxes.size() ; i++) {
      SkillBox mb = (SkillBox) this.boxes.get(i);
      
      if(mb.collide(h) && !mb.finished()) {
        return true;
      }
    }
    
    return false;
  }
}

//-----------------------------------------------------------------------------------------------------------------------

class PassiveSkill extends Skill {
  private int damageInfluence;
  private int defensiveInfluence;
  private int speedInfluence;
  private int jumpHeightInfluence;
  
  public PassiveSkill(Animation animation, int damageInfluence, int defensiveInfluence, int speedInfluence, int jumpHeightInfluence) {
    super(animation);
    
    this.damageInfluence=damageInfluence;
    this.defensiveInfluence=defensiveInfluence;
    this.speedInfluence=speedInfluence;
    this.jumpHeightInfluence=jumpHeightInfluence;
  }
  
  
  public int getDamageInfluence() {
    return this.damageInfluence;
  }
  
  public int getDefensiveInfluence() {
    return this.defensiveInfluence;
  }
  
  public int getSpeedInfluence() {
    return this.speedInfluence;
  }
  
  public int getJumpHeightInfluence() {
    return this.jumpHeightInfluence;
  }
}

//-----------------------------------------------------------------------------------------------------------------------