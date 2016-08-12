                        //Sequence editor
                        
Scene TheScene;


void setup() {
  fullScreen();
  
  TheScene = new Scene();
}

void draw() {
  background(#A5A5A5);
  TheScene.run();
}