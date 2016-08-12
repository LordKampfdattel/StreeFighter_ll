//--------------------------------------------------------------------------------------------------------------------------------------------

public enum MenuState {
  noMenu,
  StartMenu,
  MainMenu,
  NewSceneMenu,
  LoadSceneMenu;
}

//--------------------------------------------------------------------------------------------------------------------------------------------

class Scene {
  private String sceneName;
  
  private ArrayList<SceneObject> objects;
  
  private int time=0;
  private int maxTime=10;
  
  //menus:
  private Menu StartMenu;
  private Menu MainMenu;
  private Menu NewSceneMenu;
  private Menu LoadSceneMenu;
  
  private MenuState menuState=MenuState.StartMenu;
  
  //keys:
  private boolean keyPressedLastFrame=false;
  
  
  
  public Scene() {
    this.objects = new ArrayList<SceneObject>();
    this.objects.add(new SceneObject(new Vec2(width/2, height/2), "Test"));
    
    //managed das MenuDesign:
    this.createMenus();
  }
  
  
  private void createMenus() {
    this.StartMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "Start Menu", color(#C1C1CB));
    this.MainMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "Main Menu", color(#C1C1CB));
    this.NewSceneMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "New Scene Menu", color(#C1C1CB));
    this.LoadSceneMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "Load Scene Menu", color(#C1C1CB));
    
    //setup: StartMenu
    this.StartMenu.addPart(new OutputTextBox(new Vec2(width/4, height/4), new Vec2(200, 50), "new Scene", false));
    this.StartMenu.getOutputTextBox("new Scene").write("new Scene");
    
    this.StartMenu.addPart(new OutputTextBox(new Vec2(width*0.75, height/4), new Vec2(200, 50), "load Scene", false));
    this.StartMenu.getOutputTextBox("load Scene").write("load Scene");
    
    this.StartMenu.addPart(new Button(new Vec2(width/4-60, height/4+30), new Vec2(50, 50), "newSceneButton", color(#4EF2BD)));
    this.StartMenu.addPart(new Button(new Vec2(width*0.75-60, height/4+30), new Vec2(50, 50), "loadSceneButton", color(#4EF2BD)));
    
    //setup: MainMenu
    this.MainMenu.addPart(new TimeLine(new Vec2(width/2-150, 50), new Vec2(width-400, 50), "TimeLine", 100));
    
    //setup: NewSceneMenu
    this.NewSceneMenu.addPart(new OutputTextBox(new Vec2(250, 200), new Vec2(200, 50), "Name", false));
    this.NewSceneMenu.getOutputTextBox("Name").write("Name");
    
    this.NewSceneMenu.addPart(new OutputTextBox(new Vec2(250, 350), new Vec2(200, 50), "Length", false));
    this.NewSceneMenu.getOutputTextBox("Length").write("Length");
    
    this.NewSceneMenu.addPart(new InputTextBox(new Vec2(350, 220), new Vec2(400, 25), "NameTextBox", true));
    
    this.NewSceneMenu.addPart(new InputTextBox(new Vec2(350, 370), new Vec2(400, 25), "LengthTextBox", true));
    
    this.NewSceneMenu.addPart(new Button(new Vec2(width-15, 15), new Vec2(30, 30), "ExitButton", color(255, 0, 0)));
    
    this.NewSceneMenu.addPart(new Button(new Vec2(180, 470), new Vec2(50, 50), "CreateSceneButton", color(#5BF24E)));
    
    //setup: LoadSceneMenu
    this.LoadSceneMenu.addPart(new OutputTextBox(new Vec2(width/2, height/2-20), new Vec2(200, 50), "Name", false));
    this.LoadSceneMenu.getOutputTextBox("Name").write("Scene Name");
    
    this.LoadSceneMenu.addPart(new Button(new Vec2(width-15, 15), new Vec2(30, 30), "ExitButton", color(255, 0, 0)));
    
    this.LoadSceneMenu.addPart(new InputTextBox(new Vec2(width/2, height/2), new Vec2(400, 25), "loadSceneTextBox", true));
    
    this.LoadSceneMenu.addPart(new Button(new Vec2(width/2+225, height/2), new Vec2(25, 25), "loadSceneButton", color(#5BF24E)));
  }
  
  
  public void run() {
    this.update();
    this.render();
  }
  
  
  private void update() {
    this.updateTime();
    
    this.manageInput();
    
    this.updateObjects();
    
    //Menus:
    this.updateMenus();
  }
  
  private void render() {
    this.renderObjects();
    
    this.renderMenus();
  }
  
  
  //updatet nur die SceneObjects
  private void updateObjects() {
    for(int i=0 ; i<this.objects.size() ; i++) {
      SceneObject mo = (SceneObject) this.objects.get(i);
      
      mo.update();
    }
  }
  
  //rendert die SceneObjects
 private void renderObjects() {
    for(int i=0 ; i<this.objects.size() ; i++) {
      SceneObject mo = (SceneObject) this.objects.get(i);
      
      mo.render();
    }
  }
  
  
  //updatet die Zeit:
  private void updateTime() {
    this.time++;
  }
  
  
  
  //manageInput:
  private void manageInput() {
    //StartMenu:
    if(this.menuState==MenuState.StartMenu) {
      if(StartMenu.getButton("newSceneButton").isActive()) {
        this.menuState=MenuState.NewSceneMenu;
      }
      if(StartMenu.getButton("loadSceneButton").isActive()) {
        this.menuState=MenuState.LoadSceneMenu;
      }
    }
    
    
    if(mousePressed) {
      //------------------------------------------------------------------------------------------
      //NewSceneMenu:
      if(this.menuState==MenuState.NewSceneMenu) {
        NewSceneMenu.getInputTextBox("NameTextBox").setReworkAble(false);
        NewSceneMenu.getInputTextBox("LengthTextBox").setReworkAble(false);
        
        if(NewSceneMenu.getInputTextBox("NameTextBox").mouseCollides()) {
          NewSceneMenu.getInputTextBox("NameTextBox").setReworkAble(true);
        }
        
        if(NewSceneMenu.getInputTextBox("LengthTextBox").mouseCollides()) {
          NewSceneMenu.getInputTextBox("LengthTextBox").setReworkAble(true);
        }
        
        
        if(NewSceneMenu.getButton("CreateSceneButton").isActive()) {
          if(NewSceneMenu.getInputTextBox("NameTextBox").hasContent()) {
            this.sceneName=NewSceneMenu.getInputTextBox("NameTextBox").getContent();
            
            try {
              this.maxTime = Integer.parseInt(NewSceneMenu.getInputTextBox("LengthTextBox").getContent());
              this.MainMenu.getTimeLine("TimeLine").setMaxTime(this.maxTime);
              this.menuState=MenuState.noMenu;
            }catch(Exception e) {
              
            }
          }
        }
        
        if(NewSceneMenu.getButton("ExitButton").isActive()) {
          this.menuState=MenuState.StartMenu;
          this.createMenus();
        }
      }
    }
      
    //------------------------------------------------------------------------------------------
    //noMenu:
    if(this.menuState==MenuState.noMenu) {
      if(keyPressed) {// && key=='m' && !this.keyPressedLastFrame) {
        if(key=='m') {
          if(!this.keyPressedLastFrame) {
            this.menuState=MenuState.MainMenu;
          }
        }
      }
    }
    //------------------------------------------------------------------------------------------
      
    //loadSceneMenu:
    if(this.menuState==MenuState.LoadSceneMenu) {
      if(this.LoadSceneMenu.getButton("ExitButton").isActive()) {
        this.menuState=MenuState.StartMenu;
        this.createMenus();
      }
    }
    
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    //update Keys: (muss am ende stehen)
    if(keyPressed) {
      if(this.keyPressedLastFrame) {
        
      }else {
        this.keyPressedLastFrame=true;
      }
    }else {
      this.keyPressedLastFrame=false;
    }
  }
  
  
  
  //updatet die Menus:
  private void updateMenus() {
    if(this.menuState==MenuState.StartMenu) {
      this.StartMenu.update();
    }
    
    if(this.menuState==MenuState.MainMenu) {
      this.MainMenu.update();
    }
    
    if(this.menuState==MenuState.NewSceneMenu) {
      this.NewSceneMenu.update();
    }
    
    if(this.menuState==MenuState.LoadSceneMenu) {
      this.LoadSceneMenu.update();
    }
  }
  
  //rendert die Menus:
  private void renderMenus() {
    if(this.menuState==MenuState.StartMenu) {
      this.StartMenu.render();
    }
    
    if(this.menuState==MenuState.MainMenu) {
      this.MainMenu.render();
    }
    
    if(this.menuState==MenuState.NewSceneMenu) {
      this.MainMenu.render();
      this.NewSceneMenu.render();
    }
    
    if(this.menuState==MenuState.LoadSceneMenu) {
      this.MainMenu.render();
      this.LoadSceneMenu.render();
    }
  }
  
  
  //getter und setter...
  public String getSceneName() {
    return this.sceneName;
  }
  
  public ArrayList<SceneObject> getObjects() {
    return this.objects;
  }
  
  public void addObject(SceneObject o) {
    this.objects.add(o);
  }
  
  public void removeObject(SceneObject o) {
    for(int i=0 ; i<this.objects.size() ; i++) {
      SceneObject mo = (SceneObject) this.objects.get(i);
      
      if(mo==o) {
        this.objects.remove(mo);
      }
    }
  }
  
  public int getTime() {
    return this.time;
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------