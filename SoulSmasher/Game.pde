public enum GameState {
  inGame,
  Pause,
  MainMenu,
  GameMenu,
  Sequence;
}


class Game {
  private ArrayList<GameObject> objectColl;
  
  //sound:
  private Minim minim;
  private ArrayList<AudioPlayer> player;
  
  //level:
  private ArrayList<Level> level;
  private int curLevel=0;
  
  
  //Menu:
  private Menu mainMenu;
  private Menu gameMenu;
  
  //GameState:
  private GameState state = GameState.MainMenu;
  
  //InputManager:
  InputManager inputManager;
  
  
  
  public Game() {
    this.objectColl = new ArrayList<GameObject>();
    
    this.minim = new Minim(SoulSmasher.this);
    this.player = new ArrayList<AudioPlayer>();
    
    this.level = new ArrayList<Level>();
    this.level.add(new Level(loadXML("data/Level/erste richtige Map.xml"), null, null, null, null));
    
    this.inputManager = new InputManager();
    
    //hauptMenu:
    this.mainMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "HauptMenu", color(55));
    this.mainMenu.addPart(new Button(new Vec2(width/4, height/2), new Vec2(60, 60), "NewGameButton", color(#00D665)));
    
    TextBox b1 = new TextBox(new Vec2(width/4, height/2+50), new Vec2(50, 20), "New Game", false);
    b1.write("new Game");
    b1.setReworkAble(false);
    this.mainMenu.addPart(b1);
    
    this.mainMenu.addPart(new Button(new Vec2(width-width/4, height/2), new Vec2(60, 60), "loadGameButton", color(#00D665)));
    
    TextBox b2 = new TextBox(new Vec2(width-width/4, height/2+50), new Vec2(50, 20), "load Game", false);
    b2.write("load Game");
    b2.setReworkAble(false);
    this.mainMenu.addPart(b2);
    
    TextBox fileName = new TextBox(new Vec2(width-width/4, height/2-50), new Vec2(200, 20), "fileName", true);
    fileName.setReworkAble(true);
    this.mainMenu.addPart(fileName);
  }
  
  
  public void run() {
    if(this.mainMenu.getButton("NewGameButton").isActive() && this.state!=GameState.inGame) {
      this.loadLevel();
      this.state=GameState.inGame;
    }
    
    if(this.state==GameState.MainMenu) {
      this.mainMenu.update();
      this.mainMenu.render();
    }
    
    if(this.state==GameState.inGame) {
      this.updateEverything();
      this.renderEverything();
      this.playSounds();
    }
  }
  
  
  private void updateEverything() {
    this.inputManager.update();
    this.updateGameState();
    
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      mo.update();
    }
  }
  
  private void renderEverything() {
    this.renderBackground();
    
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      mo.render();
    }
  }
  
  
  
  //der Background wird vom level gerendert:
  private void renderBackground() {
    
  }
  
  
  
  //updateGameStates:
  private void updateGameState() {
    //while in main menu:
    if(this.state==GameState.GameMenu) {
      if(this.mainMenu.getButton("NewGameButton").isActive()) {
        
      }
    }
  }
  
  
  //changeGameState:    (fuer die sequencen)
  public void setGameState(GameState s) {
    this.state=s;
  }
  
 
  //GameObjects:
  public ArrayList<GameObject> getGameObjects() {
    return this.objectColl;
  }
  
  public void addGameObject(GameObject no) {
    this.objectColl.add(no);
  }
  
  public void removeGameObject(GameObject no) {
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      if(mo==no) {
        this.objectColl.remove(no);
      }
    }
  }
  
  public void resetGameObjects() {
    this.objectColl = new ArrayList<GameObject>();
  }
  
  
  
  //Level:
  private void loadLevel() {
    Level ml = (Level) this.level.get(this.curLevel);
    ml.loadMap();
  }
  
  private void loadNewLevel(Level l) {
    //removeFile:
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      try {
        File mf = (File) this.objectColl.get(i);
        this.objectColl.remove(mf);
      }catch(Exception e) {
        
      }
    }
    
    //load new Level:
    if(l!=null) {
      l.loadMap();
    }
  }
  
  
  
    
  //sound sachen:
  private void playSounds() {
    for(int i=0 ; i<this.player.size() ; i++) {
      AudioPlayer ms = (AudioPlayer) this.player.get(i);
      
      ms.rewind();
      ms.play();
      this.player.remove(ms);
    }
  }
  
  public void addSound(String path) {
    AudioPlayer np = this.minim.loadFile(path);
    this.player.add(np);
  }
}