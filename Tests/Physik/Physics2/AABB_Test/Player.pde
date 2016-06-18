class Player extends GameObject {
  private boolean[] keys;
  private float movementSpeed=5;
  
  public Player(Vec2 pos) {
    super.pos = new Vec2();
    super.pos=pos;
    
    super.v = new Vec2();
    
    super.box = new Hitbox(super.pos, 70, 70);
    
    super.type = "Player";
    
    //keys:
    this.keys = new boolean[4];
    this.keys[0]=false;
    this.keys[1]=false;
    this.keys[2]=false;
    this.keys[3]=false;
  }
  
  
  public void update() {
    super.updateHitbox();
    this.updateKeys();
    this.updateMovement();
    this.tryToMove();
  }
  
  public void render() {
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect(super.pos.x, super.pos.y, super.box.getWidth(), super.box.getHeight());
  }
  
  
  
  private void updateKeys() {
    if(keyPressed) {
      if(key == 'w') {
        keys[0]=true;
      }
      if(key == 'a') {
        keys[1]=true;
      }
      if(key == 's') {
        keys[2]=true;
      }
      if(key == 'd') {
        keys[3]=true;
      }
      
      
      if(key != 'w') {
        keys[0]=false;
      }
      if(key != 'a') {
        keys[1]=false;
      }
      if(key != 's') {
        keys[2]=false;
      }
      if(key != 'd') {
        keys[3]=false;
      }
    }else {
      this.keys[0]=false;
      this.keys[1]=false;
      this.keys[2]=false;
      this.keys[3]=false;
    }
  }
  
  private void updateMovement() {
    if(this.keys[0]) {
      super.v.y=-this.movementSpeed;
    }else {
      if(keys[2]) {
        super.v.y=this.movementSpeed;
      }else {
        super.v.y=0;
      }
    }
    
    if(this.keys[1]) {
      super.v.x=-this.movementSpeed;
    }else {
      if(keys[3]) {
        super.v.x=this.movementSpeed;
      }else {
        super.v.x=0;
      }
    }
  }
  
  private void tryToMove() {
    boolean allreadyMoved=false;
    
    for(int i=0 ; i<TheGame.getGameObjects().size() ; i++) {
      GameObject mo = (GameObject) TheGame.getGameObjects().get(i);
      
      if(mo!=this) {
        if(super.box.getUpdatedV(mo.box, super.v) !=null && !allreadyMoved) {
          super.move(super.box.getUpdatedV(mo.box, super.v));
        }
      }
    }
    
    if(!allreadyMoved) {
      super.move(super.v);
    }
  }
}