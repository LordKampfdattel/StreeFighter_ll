class Game {
  ArrayList<GameObject> objectColl;
  
  private TextureManager textureManager;
  
  private PImage background;
  
  
  public Game() {
    this.objectColl = new ArrayList<GameObject>();
    
    this.textureManager = new TextureManager();
    
    //this.textureManager.get("data/Images/Backgrounds/TestBackground.png");
    this.background= loadImage("data/Images/Backgrounds/TestBackground.png");
  }
  
  
  public void run() {
    this.updateEverything();
    this.renderEverything();
  }
  
  
  private void updateEverything() {
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      mo.update();
    }
  }
  
  private void renderEverything() {
    //background:
    translate(0, 0);
    //image(this.textureManager.get("data/Images/Backgrounds/TestBackground.png"), this.textureManager.get("data/Images/Backgrounds/TestBackground.png").width, this.textureManager.get("data/Images/Backgrounds/TestBackground.png").height);
    image(this.background, 0, 0);
    resetMatrix();
    
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      mo.render();
    }
  }
  
  
  
  public TextureManager getTextureManager() {
    return this.textureManager;
  }
}