//SoulSmasher

import ddf.minim.*;

Game TheGame;


void setup() {
  fullScreen();
  
  TheGame = new Game();
}

void draw() {
  TheGame.run();
}