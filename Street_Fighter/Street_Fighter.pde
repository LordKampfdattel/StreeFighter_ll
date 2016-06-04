//Street_Fighter

Game TheGame;
TestCharacter c;

void setup() {
  fullScreen();
  
  //load("data");
  sketchPath("Street_Fighter/data");
  
  TheGame = new Game();
  
  c = new TestCharacter(new Vec2(width/2, height/2));
}

void draw() {
  background(0);
  
  TheGame.run();
  
    
  c.update();
  c.render();
  
  rectMode(CENTER);
}