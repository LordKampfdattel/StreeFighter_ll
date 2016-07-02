Menu testMenu;

void setup() {
  fullScreen();
  
  testMenu = new Menu(new Vec2(0, 0), new Vec2(width, height), "Test", color(#8903A5));
  testMenu.addPart(new ScrollingMenu(new Vec2(width/2, height/2), new Vec2(500, 500), "TestScrollingMenu"));
  testMenu.getScrollingMenu("TestScrollingMenu").addPart(new Icon(new Vec2(width/2, height/2), new Vec2(80, 80), "SlimeIcon", loadImage("TestEnemy.png")));
  testMenu.getScrollingMenu("TestScrollingMenu").addPart(new Button(new Vec2(width/2, height/2), new Vec2(80, 80), "Button", color(255, 50, 0)));
  testMenu.getScrollingMenu("TestScrollingMenu").addPart(new Button(new Vec2(width/2, height/2), new Vec2(80, 80), "Button2", color(55, 250, 0)));
  testMenu.getScrollingMenu("TestScrollingMenu").addPart(new Button(new Vec2(width/2, height/2), new Vec2(80, 80), "Button3", color(0, 50, 250)));
}

void draw() {
  background(0);
  
  testMenu.update();
  testMenu.render();
  
  if(testMenu.getScrollingMenu("TestScrollingMenu").getIcon("SlimeIcon").isActive()) {
    exit();
  }
}