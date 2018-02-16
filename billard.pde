Tapis tapis ;

float VLIMITE = 0.005;
float FROTTEMENT = 0.997;
float RAYON = 8;
PImage boule ;
PFont police ;
final int largeur = 300 ; 

void setup() {
  size(10,10,P2D);
  frame.setSize(int(largeur+100),int(largeur*1.5+100));
  frameRate(200);
  police = createFont("Arial Bold",32);
  boule = loadImage("bille.png");
  tapis = new Tapis(int(largeur), int(largeur*1.5), 10);
}
void draw() {
  tapis.draw();
  fill(200);
  stroke(255);
  textAlign(CENTER);
  textFont(police,32);
  text("B I L L A R D",width/2,32);

}
void keyPressed() {
  tapis.init();
}
void mouseReleased() {
  if (!tapis.bouge) {
    PVector force = new PVector(tapis.bille[0].position.x-mouseX, tapis.bille[0].position.y-mouseY).limit(100);
    tapis.joue(force);
  }
}