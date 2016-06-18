
Game TheGame;


void setup() {
  fullScreen();
  
  TheGame = new Game();
  
  TheGame.addGameObject(new Wall(new Vec2(width/2, height/2), new Vec2(70, 70)));
  TheGame.addGameObject(new Player(new Vec2(width/4, height/2)));
}

void draw() {
  background(#7E3434);
  
  TheGame.run();
}