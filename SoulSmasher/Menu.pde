class Menu {
  private ArrayList<MenuPart> parts;
  private Vec2 pos;
  private Vec2 size;
  private String headingLine;
  private color c;
  
  public Menu(Vec2 pos, Vec2 size, String headingLine, color c) {
    this.parts = new ArrayList<MenuPart>();
    
    this.pos = new Vec2();
    this.pos=pos;
    this.size = new Vec2();
    this.size=size;
    this.headingLine=headingLine;
    this.c=c;
  }
  
  
  
  public void update() {
    for(int i=0 ; i<this.parts.size() ; i++) {
      MenuPart mp = (MenuPart) this.parts.get(i);
      
      mp.update();
    }
  }
  
  public void render() {
    //background:
    noStroke();
    fill(this.c);
    rect(this.pos.x, this.pos.y, this.size.x, this.size.y);
    
    //headingLine:
    fill(0);
    textSize(20);
    text(this.headingLine, this.pos.x+this.size.x/2-textWidth(this.headingLine)/2, this.pos.y+25);
    
    for(int i=0 ; i<this.parts.size() ; i++) {
      MenuPart mp = (MenuPart) this.parts.get(i);
      
      mp.render();
    }
  }
  
  
  
  public void addPart(MenuPart np) {
    this.parts.add(np);
  }
  
  public void removePart(MenuPart mp) {
    if(this.hasPart(mp)) {
      this.parts.remove(mp);
    }
  }
  
  public boolean hasPart(MenuPart tp) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      MenuPart mp = (MenuPart) this.parts.get(i);
      
      if(tp==mp) {
        return true;
      }
    }
    
    return false;
  }
  
  public Button getButton(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Button mp = (Button) this.parts.get(i);
        
        if(mp.getName() == name) {
          return mp;
        }
      }catch(Exception e) {
        
      }
      
      //if(mp==null) {
        //return true;
      ///}
    }
    
    return null;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public enum MenuPartType {
  Switch,
  Button,
  TextBox
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


abstract class MenuPart {
  private Vec2 pos;
  private Vec2 size;
  private MenuPartType type;
  //damit man die parts unterscheiden kann(auch 2 vom selben typen)
  private String name;
  public Hitbox box;
  
  public MenuPart(Vec2 pos, Vec2 size, String name) {
    this.pos = new Vec2();
    this.pos=pos;
    this.size = new Vec2();
    this.size=size;
    this.name=name;
    
    //Hitbox:
    this.box = new Hitbox(this.pos, this.size.x, this.size.y);
  } 
  
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  private class Hitbox {
    private Vec2 pos;
    private float boxWidth;
    private float boxHeight;
  
    public Hitbox(Vec2 pos, float boxWidth, float boxHeight) {
      this.pos = pos;
      this.boxWidth = boxWidth;
      this.boxHeight = boxHeight;
    }
  
    public Hitbox(Vec2 pos, PImage img) {
      this.pos = pos;
      this.boxWidth = img.width;
      this.boxHeight = img.height;
    }
  
    public void setPosition(Vec2 pos) {
      this.pos = pos.copy();
    }
  
    public boolean collide(Hitbox h) {    //AABB
      if(abs(this.pos.x-h.getPosition().x)<this.boxWidth+h.getWidth()) {
        if(abs(this.pos.y-h.getPosition().y)<this.boxHeight+h.getHeight()) {
          return true;
        }
      }
      return false;
    }
    
    public boolean collidesWithMouse() {
      if(abs(this.pos.x-mouseX)<this.boxWidth/2) {
        if(abs(this.pos.y-mouseY)<this.boxHeight/2) {
          return true;
        }
      }
      return false;
    }
  
    public Vec2 getPosition() {
      return this.pos;
    }
  
    public float getWidth() {
      return this.boxWidth;
    }
  
    public float getHeight() {
      return this.boxHeight;
    }
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  
  public Vec2 getPosition() {
    return this.pos;
  }
  
  public void setPosition(Vec2 pos) {
    this.pos=pos;
  }
  
  public Vec2 getSize() {
    return this.size;
  }
  
  public MenuPartType getType() {
    return this.type;
  }
  
  public String getName() {
    return this.name;
  }
  
  public boolean mouseCollides() {
    return false;
  }
  
  
  abstract void update();
  abstract void render();
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class Switch extends MenuPart {
  private boolean active=false;
  private boolean mousePressedLastFrame=false;
  
  public Switch(Vec2 pos, Vec2 size, String name) {
    super(pos, size, name);
    
    super.type=MenuPartType.Switch;
  }
  
  
  public void update() {
    if(super.box.collidesWithMouse()) {
      if(mousePressed && !mousePressedLastFrame) {
        mousePressedLastFrame=true;
        this.pullSwitch();
      }
      if(!mousePressed) {
        mousePressedLastFrame=false;
      }
    }
  }
  
  public void render() {
    noStroke();
    fill(#767676);
    rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x, super.size.y);
    
    fill(255);
    if(this.active) {
      rect(super.pos.x, super.pos.y-super.size.y/2, super.size.x/2, super.size.y);
    }else {
      rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x/2, super.size.y);
    }
  }
  
  
  public void pullSwitch() {
    this.active=!this.active;
  }
  
  public boolean isActive() {
    return this.active;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class Button extends MenuPart {
  private color c;
  private boolean active=false;
  private boolean mousePressedLastFrame=false;
  
  public Button(Vec2 pos, Vec2 size, String name, color c) {
    super(pos, size, name);
    
    super.type=MenuPartType.Button;
    
    this.c=c;
  }
  
  
  public void update() {
    this.active=false;
    
    if(super.box.collidesWithMouse()) {
      if(mousePressed && !mousePressedLastFrame) {
        mousePressedLastFrame=true;
        this.active=true;
      }
      if(!mousePressed) {
        mousePressedLastFrame=false;
      }
    }
  }
  
  public void render() {
    if(this.active) {
      stroke(255);
    }else {
      stroke(50);
    }
    
    fill(this.c);
    rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x, super.size.y);
  }
  
  
  public boolean isActive() {
    return this.active;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class TextBox extends MenuPart {
  private ArrayList<TextLine> lines;
  private int rows;
  private boolean background;
  private boolean reworkAble=true;
  private boolean mousePressedLastFrame=false;
  
  public TextBox(Vec2 pos, Vec2 size, String name, boolean background) {
    super(pos, size, name);
    
    this.background=background;
    
    super.type=MenuPartType.TextBox;
    
    this.rows = round(size.y/15);
    this.lines = new ArrayList<TextLine>();
    
    for(int i=0 ; i<this.rows ; i++) {
      TextLine nl = new TextLine(size.x);
      this.lines.add(nl);
    }
  }
  
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  
  private class TextLine {
    private String content="";
    private float lineLength;
    
    public TextLine(float lineLength) {
      this.lineLength=lineLength;
    }
    
    
    public String giveContent() {
      return this.content;
    }
    
    public void addText(String text) {
      this.content+=text;
    }
    
    public void addText(char text) {
      this.content+=text;
    }
    
    public void delete() {
      if(this.content.length()>0) {
        this.content=this.content.substring(0, this.content.length()-1);
      }
    }
    
    public boolean isFull() {
      if(textWidth(this.content)>=this.lineLength) {
        return true;
      }
      return false;
    }
    
    public float spaceLeft() {
      return 15*(this.lineLength-textWidth(this.content));
    }
    
    public boolean enoughSpaceLeft(char c) {
      if(textWidth(this.content+c)<=this.spaceLeft()) {
        return true;
      }
      return false;
    }
  }
  
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  
  public void update() {
    if(this.reworkAble) {
      this.write();
    }
  }
  
  public void render() {
    if(this.background) {
      noStroke();
      fill(255);
      rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x, super.size.y);
    }
    
    textSize(15);
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(i);
      
      fill(0);
      text(ml.giveContent(), super.pos.x-super.size.x/2, super.pos.y+(i+1)*15-super.size.y/2);
    }
  }
  
  
  private void write() {
    boolean written=false;
    if(keyPressed && !this.mousePressedLastFrame) {
      for(int i=0 ; i<this.lines.size() ; i++) {
        TextLine ml = (TextLine) this.lines.get(i);
        
        if(ml.enoughSpaceLeft(key) && written==false && key!=BACKSPACE) {
          ml.addText(key);
          written=true;
        }
        
        if(!ml.isFull() && key == BACKSPACE && written==false) {
          ml.delete();
          written=true;
        }
      }
      TextLine ml = (TextLine) this.lines.get(this.lines.size()-1);
      if(keyPressed && ml.isFull() && key == BACKSPACE && !this.mousePressedLastFrame && written==false) {
        ml.delete();
        written=true;
      }
    }
    
    if(keyPressed) {
      this.mousePressedLastFrame=true;
    }else {
      this.mousePressedLastFrame=false;
    }
  }
  
  
  private void write(String text) {
    boolean written = false;
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(i);
      
      if(ml.spaceLeft()>=textWidth(text) && !written) {
        ml.addText(text);
      }
    }
  }
  
  
  public void setReworkAble(boolean b) {
    this.reworkAble=b;
  }
}