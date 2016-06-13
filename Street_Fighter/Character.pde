//die unterschiedlichen Character die der User nehmen kann:

/*
enum CharacterType {
  TestCharacter(10, 5, 5, 3, null);  //animation muss noch gemacht werden (300x600)
  
  //texture
  private final int ofense;
  private final int defense;
  private final float speed;
  private final float jumpHeight;
  //animations:
  private final Animation standingAnimation;
  
  CharacterType(int ofense, int defense, float speed, float jumpHeight, Animation standingAnimation) {
    this.ofense = ofense;
    this.defense = defense;
    this.speed = speed;
    this.jumpHeight = jumpHeight;
    this.standingAnimation = standingAnimation;
  }
  
  public int ofense() { return this.ofense; }
  public int defense() { return this.defense; }
  public float speed() { return this.speed; }
  public float jumpHeight() { return this.jumpHeight; }
  public Animation standingAnimationt() { return this.standingAnimation; }
}
*/

public class Character extends GameObject {
  //stats:
  private int ofense;
  private int defense;
  private float speed;
  private float jumpHeight;
  
  //animations:
  private Animation standingAnimation;
  private Animation runningAnimation;
  private Animation jumpingAnimation;
  
  //skills:
  private ActiveSkill jab;
  
  private String name;
  
  
  public Character(Vec2 pos, String name) {
    super.pos = new Vec2();
    super.pos=pos;
    super.v = new Vec2();
    
    this.name=name;
    
    super.type="Character";
  }
  
  
  public void update() {
    super.move(super.v);
    this.updateAnimations();
  }
  
  public void render() {
    
  }
  
  
  private void updateAnimations() {
    this.standingAnimation.update();
    this.runningAnimation.update();
    this.jumpingAnimation.update();
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

public class TestCharacter extends Character {          //75x100
  private PImage image;
  
  public TestCharacter(Vec2 pos) {
    super(pos, "TestCharacter");
    
    //super.img = loadImage("Brokkoli.png");//"data/SpriteSheets/TestCharacter.png");
    super.standingAnimation = new Animation(TheGame.getTextureManager().get("data/SpriteSheets/TestCharacter/StandingAnimation.png"), 14376/12, 2529, 3, 0.5, true, false);
    super.runningAnimation = new Animation(TheGame.getTextureManager().get("data/SpriteSheets/TestCharacter/WalkAnimation.png"), 17355/15, 2537, 2, 0.5, true, false);
    
    ArrayList<SkillBox> boxes = new ArrayList<SkillBox>();
    boxes.add(new SkillBox(super.getPosition().add(new Vec2(-160, -80)), 30, 30, 2, 8));
    super.jab = new ActiveSkill(new Animation(TheGame.getTextureManager().get("data/SpriteSheets/TestCharacter/JabAnimation.png"), 9366/6, 2478, 3, 0.5, true, false), boxes);
  }
  
  
  public void update() {
    //super.update();
    //super.standingAnimation.update();
    //super.runningAnimation.update();
    //super.move(-4, 0);
    
    //super.jab.getAnimation().update();
    super.jab.update();
    
    for(int i=0 ; i<super.jab.getBoxes().size() ; i++) {
      SkillBox mb = (SkillBox) super.jab.getBoxes().get(i);
      
      //mb.update();
      mb.render();
    }
  }
  
  public void render() {
    translate(super.pos.x, super.pos.y);
    //super.standingAnimation.drawImage();
    //super.runningAnimation.drawImage();
    
    super.jab.getAnimation().drawImage();
    resetMatrix();
  }
}