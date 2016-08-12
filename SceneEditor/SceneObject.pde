class SceneObject {
  //damit man die scene resetten kann
  private Vec2 startPos;
  private Vec2 pos;
  private String name;
  
  private ArrayList<Status> status;
  
  
  public SceneObject(Vec2 pos, String name) {
    this.pos = new Vec2();
    this.pos = pos;
    this.startPos = new Vec2();
    this.startPos = pos;
    this.name=name;
    
    this.status = new ArrayList<Status>();
  }
  
  //---------------------------------------------------------------------------------------------------
  
  private class Status {
    private Vec2 v;
    private Vec2 lineOfSight;
    private Animation animation;
    private int startingTime;
    private int endingTime;
    
    public Status(Vec2 v, Vec2 lineOfSight, Animation animation, int startingTime, int endingTime) {
      this.v = new Vec2();
      this.v=v;
      this.lineOfSight = new Vec2();
      this.lineOfSight = lineOfSight;
      this.animation = animation;
      this.startingTime = startingTime;
      this.endingTime = endingTime;
    }
    
    //getter:
    public Vec2 getV() { return this.v; }
    public Vec2 getLineOfSight() { return this.lineOfSight; }
    public Animation getAnimation() { return this.animation; }
    public int getStartingTime() { return this.startingTime; }
    public int getEndingTime() { return this.endingTime; }
  }
  
  //---------------------------------------------------------------------------------------------------
  
  
  public void update() {
    if(this.getV(TheScene.getTime())!=null) {
      this.pos = this.pos.add(this.getV(TheScene.getTime()));
    }
    
    if(this.getAnimation(TheScene.getTime())!=null) {
      this.getAnimation(TheScene.getTime()).update();
    }
  }
  
  public void render() {
    if(this.getAnimation(TheScene.getTime())!=null) {
      translate(this.pos.x, this.pos.y);
      rotate(this.getV(TheScene.getTime()).heading());
      this.getAnimation(TheScene.getTime()).drawImage();
      resetMatrix();
      
      if(dist(mouseX, mouseY, this.pos.x, this.pos.y)<50) {
        fill(255);
        text(this.name, this.pos.x-textWidth(this.name), this.pos.y);
      }
    }
  }
  
  
  //manageStatus
  public void reset() {
    this.pos=this.startPos;
    this.status = new ArrayList<Status>();
  }
  
  public void addStatus(Vec2 v, Vec2 lineOfSight, Animation animation, int startingTime, int endingTime) {
    this.status.add(new Status(v, lineOfSight, animation, startingTime, endingTime));
  }
  
  public void removeLastStatus() {
    if(this.status.size()>0) {
      this.status.remove((Status) this.status.get(this.status.size()-1));
    }
  }
  
  public void updateTo(int time) {
    this.reset();
    
    for(int i=0 ; i<time ; i++) {
      this.update();
    }
  }
  
  
  
  //getter und setter:
  public Vec2 getPos() {
    return this.pos;
  }
  
  public Vec2 getV(int time) {
    for(int i=0 ; i<this.status.size() ; i++) {
      Status ms = (Status) this.status.get(i);
      
      if(time >= ms.getStartingTime() && time <= ms.getEndingTime()) {
        return ms.getV();
      }
    }
    return null;
  }
  
  public Vec2 getLineOfSight(int time) {
    for(int i=0 ; i<this.status.size() ; i++) {
      Status ms = (Status) this.status.get(i);
      
      if(time >= ms.getStartingTime() && time <= ms.getEndingTime()) {
        return ms.getLineOfSight();
      }
    }
    return null;
  }
  
  public Animation getAnimation(int time) {
    for(int i=0 ; i<this.status.size() ; i++) {
      Status ms = (Status) this.status.get(i);
      
      if(time >= ms.getStartingTime() && time <= ms.getEndingTime()) {
        return ms.getAnimation();
      }
    }
    return null;
  }
}