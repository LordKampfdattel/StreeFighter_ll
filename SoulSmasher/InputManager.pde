class InputManager {
  private boolean mouseClicked=false;
  private boolean mousePressedLastFrame=false;
  
  private ArrayList<KeyChar> lastFramePressedKeys;
  
  
  public InputManager() {
    this.lastFramePressedKeys = new ArrayList<KeyChar>();
  }
  
  
  //---------------------------------------------------------------------------------------------------------------------
  private class KeyChar {
    private char key;
    
    public KeyChar(char key) {
      this.key=key;
    }
    
    public char getKey() {
      return this.key;
    }
  }
  //---------------------------------------------------------------------------------------------------------------------
  
  
  
  public void update() {
    this.updateClicking();
    this.updateKeys();
  }
  
  
  private void updateClicking() {
    if(mousePressed) {
      if(!this.mousePressedLastFrame) {
        this.mouseClicked=true;
      }else {
        this.mouseClicked=false;
      }
    }else {
      this.mousePressedLastFrame=false;
      this.mouseClicked=false;
    }
  }
  
  private void updateKeys() {
    if(keyPressed) {
      boolean hasKey=false;
      for(int i=0 ; i<this.lastFramePressedKeys.size() ; i++) {
        KeyChar mk = (KeyChar) this.lastFramePressedKeys.get(i);
        
        if(mk.getKey()==key) {
          hasKey=true;
        }
      }
      if(!hasKey) {
        this.lastFramePressedKeys.add(new KeyChar(key));
      }
    }else {
      this.lastFramePressedKeys = new ArrayList<KeyChar>();
    }
  }
  
  
  public boolean mousePressed() {
    return mousePressed;
  }
  
  public boolean mouseClicked() {
    return this.mouseClicked;
  }
  
  public boolean keyPressed(char k) {
    for(int i=0 ; i<this.lastFramePressedKeys.size() ; i++) {
      KeyChar mk = (KeyChar) this.lastFramePressedKeys.get(i);
      
      if(mk.getKey()==key) {
        return true;
      }
    }
    
    return false;
  }
}