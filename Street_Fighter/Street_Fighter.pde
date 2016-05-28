//Street_Fighter

Game TheGame;
TestCharacter c = new TestCharacter(new Vec2(width/2, height/2));

void setup() {
  fullScreen();
  
  loadImage("data/SpriteSheets/TestCharacter/StandingAnimation.png");
  
  TheGame = new Game();
}

void draw() {
  background(0);
  
  c.update();
  c.render();
  
  TheGame.run();
  
  rectMode(CENTER);
}