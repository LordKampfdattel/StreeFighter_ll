class User {
  Character character;
  boolean[] keys;
  
  User(Character character) {
    this.character = character;
    this.keys = new boolean[4];    //key: walkLeft ; walkRight ; jump ; attack
  }
}