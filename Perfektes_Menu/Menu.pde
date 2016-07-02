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
    text(this.headingLine, this.pos.x+this.size.x/2-this.headingLine.length()/2, 10);
    
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
    }
    
    return null;
  }
  
  public Switch getSwitch(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Switch ms = (Switch) this.parts.get(i);
        
        if(ms.getName() == name) {
          return ms;
        }
      }catch(Exception e) {
        
      }
    }
    
    return null;
  }
  
  public Icon getIcon(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Icon mi = (Icon) this.parts.get(i);
        
        if(mi.getName() == name) {
          return mi;
        }
      }catch(Exception e) {
        
      }
    }
    
    return null;
  }
  
  public InputTextBox getInputTextBox(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        InputTextBox mi = (InputTextBox) this.parts.get(i);
        
        if(mi.getName() == name) {
          return mi;
        }
      }catch(Exception e) {
        
      }
    }
    
    return null;
  }
  
  public OutputTextBox getOutputTextBox(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        OutputTextBox mo = (OutputTextBox) this.parts.get(i);
        
        if(mo.getName() == name) {
          return mo;
        }
      }catch(Exception e) {
        
      }
    }
    
    return null;
  }
  
  public ScrollingMenu getScrollingMenu(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        ScrollingMenu mm = (ScrollingMenu) this.parts.get(i);
        
        if(mm.getName() == name) {
          return mm;
        }
      }catch(Exception e) {
        
      }
    }
    
    return null;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public enum MenuPartType {
  Switch,
  Button,
  InputTextBox,
  OutputTextBox,
  ScrollingMenu
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



public class Icon extends MenuPart {
  private PImage img;
  private boolean active=false;
  private boolean mousePressedLastFrame=false;
  
  public Icon(Vec2 pos, Vec2 size, String name, PImage img) {
    super(pos, size, name);
    
    this.img = img;
    this.img.width=(int)super.getSize().x;
    this.img.height=(img.height*(int)super.getSize().x)/img.width;
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
    translate(super.pos.x, super.pos.y);
    image(this.img, -this.img.width/2, -this.img.height/2);
    resetMatrix();
  }
  
  
  public boolean isActive() {
    return this.active;
  }
}



//-----------------------------------------------------------------------------------------------------------------------------------------------------



public class TextBox extends MenuPart {
  private boolean background;
  private ArrayList<TextLine> lines;
  private int rows;
  
  public TextBox(Vec2 pos, Vec2 size, String name, boolean background, MenuPartType type) {
    super(pos, size, name);
    
    this.background=background;
    super.type=type;
    
    
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
    private float lineLength;      //in pixels
    
    public TextLine(float lineLength) {
      this.lineLength=lineLength*2;
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
    
    public void reset() {
      this.content="";
    }
    
    public boolean isFull() {
      if(textWidth(this.content)>=this.lineLength) {
        return true;
      }
      return false;
    }
    
    public float spaceLeft() {
      return this.lineLength-textWidth(this.content);
    }
    
    public boolean enoughSpaceFor(char c) {
      if(textWidth(this.content+c)<=this.spaceLeft()) {
        return true;
      }
      return false;
    }
    
    public boolean enoughSpaceFor(String s) {
      if(textWidth(this.content+s)<=this.spaceLeft()) {
        return true;
      }
      return false;
    }
  }
  
  //-----------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  
  public void write(String s) {
    boolean written=false;
    
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(i);
      
      if(!ml.isFull() &&  ml.enoughSpaceFor(s) && !written) {
        ml.addText(s);
        written=true;
      }
    }
  }
  
  public void write(char c) {
    boolean written=false;
    
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(i);
      
      if(!ml.isFull() &&  ml.enoughSpaceFor(c) && !written) {
        ml.addText(c);
        written=true;
      }
    }
  }
  
  public void reset() {
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(i);
      
      ml.reset();
    }
  }
  
  public void backSpace() {
    boolean allreadyBackSpaced=false;
    for(int i=0 ; i<this.lines.size() ; i++) {
      TextLine ml = (TextLine) this.lines.get(this.lines.size()-1-i);
      
      if(ml.giveContent()!=null && !allreadyBackSpaced) {
        ml.delete();
        allreadyBackSpaced=true;
      }
    }
  }
  
  
  
  
  public void update() {
    
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
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class InputTextBox extends TextBox {
  private boolean reworkAble=true;
  private boolean mousePressedLastFrame=false;
  
  public InputTextBox(Vec2 pos, Vec2 size, String name, boolean background) {
    super(pos, size, name, background, MenuPartType.InputTextBox);
  }
  
  
  
  public void update() {
    super.update();
    
    if(this.reworkAble) {
      this.write();
    }
  }
  
  public void render() {
    super.render();
  }
  
  
  private void write() {
    if(!this.mousePressedLastFrame && keyPressed) {
      super.write(key);
    }
    
    if(keyPressed) {
      this.mousePressedLastFrame=true;
    }else {
      this.mousePressedLastFrame=false;
    }
  }
  
  
  public void setReworkAble(boolean b) {
    this.reworkAble=b;
  }
  
  public boolean isReworkAble() {
    return this.reworkAble;
  }
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class OutputTextBox extends TextBox {
  public OutputTextBox(Vec2 pos, Vec2 size, String name, boolean background) {
    super(pos, size, name, background, MenuPartType.InputTextBox);
  }
  
  public void wirte(String s) {
    if(textWidth(s)>super.getSize().x) {
      int z=1;
      while(textWidth(s.substring(0, s.length()-z))>super.getSize().x) {
        z++;
      }
      
      super.write(s.substring(0, s.length()-z));
      this.write(s.substring(s.length()-z, s.length()));
    }else {
      super.write(s);
    }
  }
  
  
  public void write(String userName, String s) {
    String ss=userName+": "+s;
    
    if(textWidth(ss)>super.getSize().x) {
      int z=1;
      while(textWidth(ss.substring(0, ss.length()-z))>super.getSize().x) {
        z++;
      }
      
      super.write(s.substring(0, s.length()-z));
      this.write(s.substring(s.length()-z, s.length()));
    }else {
      super.write(ss);
    }
  }
  
  
  public void writeln(String s) {
    if(textWidth(s)>super.getSize().x) {
      int z=1;
      while(textWidth(s.substring(0, s.length()-z))>super.getSize().x) {
        z++;
      }
      
      super.write(s.substring(0, s.length()-z));
      this.writeln(s.substring(s.length()-z, s.length()));
    }else {
      String leer="";
      while(textWidth(s+leer)<super.getSize().x) {
        leer+=" ";
      }
      super.write(s+leer);
    }
  }
  
  public void writeln(String name, String s) {
    String ss=name+": "+s;
    
    if(textWidth(ss)>super.getSize().x) {
      int z=1;
      while(textWidth(ss.substring(0, ss.length()-z))>super.getSize().x) {
        z++;
      }
      
      super.write(ss.substring(0, ss.length()-z));
      this.writeln(ss.substring(s.length()-z, ss.length()));
    }else {
      String leer="";
      while(textWidth(s+leer)<super.getSize().x) {
        leer+=" ";
      }
      super.write(ss+leer);
    }
  }
  
  
  public void reset() {
    super.reset();
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------


public class ScrollingMenu extends MenuPart {
  private ArrayList<MenuPart> parts;
  private int curPart=0;
  private Button bUp, bDown;
  
  public ScrollingMenu(Vec2 pos, Vec2 size, String name) {
    super(pos, size, name);
    
    this.parts = new ArrayList<MenuPart>();
    
    bUp = new Button(new Vec2(super.pos.x, super.pos.y-super.size.y/2+25), new Vec2(50, 50), "UpButton", color(#3B63FC));
    bDown = new Button(new Vec2(super.pos.x, super.pos.y+super.size.y/2-25), new Vec2(50, 50), "DownButton", color(#3B63FC));
  }
  
  
  public void update() {
    this.updateButtons();
    
    if(this.parts.size()>0) {
      MenuPart mp = (MenuPart) this.parts.get(curPart);
      mp.update();
    }
  }
  
  public void render() {
    fill(255);
    noStroke();
    rect(super.pos.x-super.size.x/2, super.pos.y-super.size.y/2, super.size.x, super.size.y);
    
    if(this.parts.size()>0) {
      MenuPart mp = (MenuPart) this.parts.get(curPart);
      mp.render();
    }
    
    this.bUp.render();
    this.bDown.render();
  }
  
  
  
  private void updateButtons() {
    this.bUp.update();
    this.bDown.update();
    
    if(this.bUp.isActive()) {
      this.curPart--;
    }    
    if(this.bDown.isActive()) {
      this.curPart++;
    }
    
    if(this.curPart<0) {
      this.curPart=this.parts.size()-1;
    }
    if(this.curPart>this.parts.size()-1) {
      this.curPart=0;
    }
  }
  
  
  
  public void addPart(MenuPart np) {
    this.parts.add(np);
  }
  
  public void removePart(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      MenuPart mp = (MenuPart) this.parts.get(i);
      
      if(mp.getName() == name) {
        this.parts.remove(mp);
      }
    }
  }
  
  
  
  
  
  
  public Button getButton(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Button mb = (Button) this.parts.get(i);
      
        if(mb.getName() == name) {
          return mb;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
  
  public Switch getSwitch(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Switch ms = (Switch) this.parts.get(i);
      
        if(ms.getName() == name) {
          return ms;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
  
  public Icon getIcon(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        Icon mi = (Icon) this.parts.get(i);
      
        if(mi.getName() == name) {
          return mi;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
  
  public InputTextBox getInputTextBox(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        InputTextBox mi = (InputTextBox) this.parts.get(i);
      
        if(mi.getName() == name) {
          return mi;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
  
  public OutputTextBox getOutputTextBox(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        OutputTextBox mo = (OutputTextBox) this.parts.get(i);
      
        if(mo.getName() == name) {
          return mo;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
  
  public ScrollingMenu getScrollingMenu(String name) {
    for(int i=0 ; i<this.parts.size() ; i++) {
      try {
        ScrollingMenu ms = (ScrollingMenu) this.parts.get(i);
      
        if(ms.getName() == name) {
          return ms;
        }
      } catch(Exception e) {
        
      }
    }
    return null;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------------