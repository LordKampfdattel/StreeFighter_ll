class Sequence {
  private XML scene;
  private ArrayList<SceneObject> objects;
  private int sceneLength;      //in pixels
  private int time;             //in pixels
  private boolean pause=false;
  
  
  public Sequence(XML scene) {
    this.scene=scene;
    
    this.loadScene();
  }
  
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  
  private class SceneObject extends GameObject {
    private PImage img;
    private String name;
    private Vec2 lineOfSight;
    private Animation curAnimation;
    
    public SceneObject(Vec2 pos, Vec2 lineOfSight, PImage img, String name) {
      super(pos);
      super.v = new Vec2();
      
      this.lineOfSight = new Vec2();
      this.lineOfSight=lineOfSight;
      this.img=img;
      this.name=name;
    }
    
    
    public void update() {
      //Animation:
      if(this.curAnimation.finished() && !this.curAnimation.isLooped()) {
        this.curAnimation=null;
      }
      
      if(this.curAnimation!=null) {
        this.curAnimation.update();
      }
    }
    
    public void render() {
      if(this.curAnimation==null) {
        translate(super.getPosition().x, super.getPosition().y);
        rotate(this.lineOfSight.heading());
        image(this.img, -this.img.width/2, -this.img.height/2);
        resetMatrix();
      }else {
        translate(super.getPosition().x, super.getPosition().y);
        rotate(this.lineOfSight.heading());
        this.curAnimation.drawImage();
        resetMatrix();
      }
    }
    
    
    public String getName() {
      return this.name;
    }
    
    public Vec2 getLineOfSight() {
      return this.lineOfSight;
    }
    
    public void setMovement(Vec2 v) {
      super.v=v;
    }
  }
  
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  public void play() {
    if(!this.pause) {
      
    }
  }
  
  
  public void pause() {
    this.pause=true;
  }
  
  public void resume() {
    this.pause=false;
  }
  
  public void reset() {
    TheGame.setGameState(GameState.Sequence);
    
    this.loadScene();
  }
  
  
  
  private SceneObject getObject(String name) {
    for(int i=0 ; i<this.objects.size() ; i++) {
      SceneObject mo = (SceneObject) this.objects.get(i);
      
      if(mo.getName() == name) {
        return mo;
      }
    }
    
    return null;
  }
  
  
  
  private void loadScene() {
    this.objects = new ArrayList<SceneObject>();
    
    XML[] children=this.scene.getChildren();
    this.sceneLength=this.scene.getInt("SceneLength");
    
    for(int i = 0; i < children.length; i++) {
      this.parseSceneObject(children[i]);
    }
  }
  
  private void parseSceneObject(XML node) {
    //...
    
  }
  
  private void parseSound(String path) {
    TheGame.addSound(path);
  }
}