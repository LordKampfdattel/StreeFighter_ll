class Game {
  ArrayList<GameObject> objectColl;
  
  
  public Game() {
    this.objectColl = new ArrayList<GameObject>();
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
    for(int i=0 ; i<this.objectColl.size() ; i++) {
      GameObject mo = (GameObject) this.objectColl.get(i);
      
      mo.render();
    }
  }
}