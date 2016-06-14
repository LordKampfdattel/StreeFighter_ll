//mega physik engine mit allem!...ALLEM!!!

World TheWorld;


void setup() {
  fullScreen();
  
  TheWorld = new World();
  
  TheWorld.addBody(new Body(new Vec2(width/2, height/2), new Vec2(50, 50), 100, false));
  TheWorld.addBody(new Body(new Vec2(width/2, height*0.75), new Vec2(width-1, 50), 10000, true));
}

void draw() {
  background(0);
  smooth();
  
  TheWorld.run();
}