class User {
  CharacterType character;
  boolean[] keys;
  
  User(CharacterType character) {
    this.character = character;
    this.keys = new boolean[4];    //key: walkLeft ; walkRight ; jump ; attack
  }
}