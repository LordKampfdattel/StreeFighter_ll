public enum FileType {
  Dirt,
  Water,
  Wall
}

//--------------------------------------------------------------------------------------------------------------

class File extends GameObject {
  private PImage img;
  private FileType type;
  
  public File(Vec2 pos, FileType type) {
    super(pos);
  }
  
  
  public void update() {
    
  }
  
  public void render() {
    if(this.img!=null) {
      translate(super.pos.x, super.pos.y);
      image(this.img, -this.img.width/2, -this.img.height/2);
      resetMatrix();
    }
  }
  
  
  public FileType getType() {
    return this.type;
  }
}

//--------------------------------------------------------------------------------------------------------------

class Dirt extends File {
  
  
  public Dirt(Vec2 pos) {
    super(pos, FileType.Dirt);
    
    super.img=loadImage("Files/Dirt.png");
  }
  
  
  public void update() {
    
  }
  
  public void render() {
    super.render();
  }
}

//--------------------------------------------------------------------------------------------------------------

class Water extends File {
  
  
  public Water(Vec2 pos) {
    super(pos, FileType.Water);
    
    super.img=loadImage("Files/Water.png");
  }
  
  
  public void update() {
    
  }
  
  public void render() {
    super.render();
  }
}

//--------------------------------------------------------------------------------------------------------------

class Wall extends File {
  
  
  public Wall(Vec2 pos) {
    super(pos, FileType.Wall);
    
    super.img=loadImage("Files/Wall.png");
  }
  
  
  public void update() {
    
  }
  
  public void render() {
    super.render();
  }
}