class Level {
  private XML map;
  
  private Level topLevel, botLevel, leftLevel, rightLevel;
  
  
  public Level(XML map, Level topLevel, Level botLevel, Level leftLevel, Level rightLevel) {
    this.map=map;
    
    this.topLevel=topLevel;
    this.botLevel=botLevel;
    this.leftLevel=leftLevel;
    this.rightLevel=rightLevel;
  }
  
  public Level(XML map) {
    this.map=map;
    
    this.topLevel=null;
    this.botLevel=null;
    this.leftLevel=null;
    this.rightLevel=null;
  }
  
  
  public XML getMap() {
    return this.map;
  }
  
  
  public void loadMap() {
    XML[] children = this.map.getChildren();
    
    for(int i = 0; i < children.length; i++) {
      parseMapFile(children[i]);
      parseMapEnemy(children[i]);
    }
  }
  
  
  private void parseMapFile(XML node) {
    String type=node.getName();
    
    if(type=="Dirt") {
      float x=node.getFloat("x");
      float y=node.getFloat("y");
      
      TheGame.addGameObject(new Dirt(new Vec2(x, y)));
    }
    if(type=="Wall") {
      float x=node.getFloat("x");
      float y=node.getFloat("y");
      
      TheGame.addGameObject(new Wall(new Vec2(x, y)));
    }
    if(type=="Water") {
      float x=node.getFloat("x");
      float y=node.getFloat("y");
      
      TheGame.addGameObject(new Water(new Vec2(x, y)));
    }
  }
  
  private void parseMapEnemy(XML node) {
    String type=node.getName();
    
    if(type=="TestEnemy") {
      //...
    }
  }
  
  
  
  public Level getTopLevel() {
    return this.topLevel;
  }
  
  public Level getBotLevel() {
    return this.botLevel;
  }
  
  public Level getLeftLevel() {
    return this.leftLevel;
  }
  
  public Level getRightLevel() {
    return this.rightLevel;
  }
  
  
  
  public void setTopLevel(Level l) {
    this.topLevel=l;
  }
  
  public void setBotLevel(Level l) {
    this.botLevel=l;
  }
  
  public void setLeftLevel(Level l) {
    this.leftLevel=l;
  }
  
  public void setRightLevel(Level l) {
    this.rightLevel=l;
  }
}