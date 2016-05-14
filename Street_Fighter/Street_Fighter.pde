//Street_Fighter

Game TheGame;

void setup() {
  fullScreen();
  
  TheGame = new Game();
}

void draw() {
  background(0);
  
  TheGame.run();
  
  rectMode(CENTER);
}