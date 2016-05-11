//die unterschiedlichen Character die der User nehmen kann:

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