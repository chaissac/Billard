
Balle[] bille ;
Trou[] trou ;

int nb = 10;
boolean bouge;

void keyPressed() {
  init();
}
void mouseReleased() {
  if (!bouge) {
    PVector force = new PVector(bille[0].position.x-mouseX, bille[0].position.y-mouseY).limit(100);
    bille[0].tape(force);
  }
}
void setup() {
  size(370, 520);
  frameRate(240);
  trou = new Trou[6];
  trou[0]= new Trou(18,18);
  trou[1]= new Trou(18,height/2);
  trou[2]= new Trou(18,height-18);
  trou[3]= new Trou(width-18,18);
  trou[4]= new Trou(width-18,height/2);
  trou[5]= new Trou(width-18,height-18);
 
  init();
}
void init() {
  bille = new Balle[nb];
  for(int i=0;i<nb;i++) 
    bille[i] = new Balle(random(width-40)+20,random(height-40)+20, color(random(255), random(255), random(255)));
    bille[0].couleur=#FFFFFF;
    collision();
  bouge=false;
}
void draw() {
  background(#404040);
  fill(#008000);
  stroke(255);
  rect(10,10,width-20,height-20);
  for (int t=0;t<6;t++) trou[t].draw();
  bouge = false;
  for(int i=0;i<nb;i++) if (bille[i].step()!=0) bouge=true;
  out();
  if (!bouge) {
    if (mousePressed) {
      stroke(255);
      PVector force = new PVector(bille[0].position.x-mouseX, bille[0].position.y-mouseY).limit(100);
      line(bille[0].position.x,bille[0].position.y,bille[0].position.x-force.x,bille[0].position.y-force.y);
    }
  } else collision();
}
void collision() { 
  for(int i=0;i<nb-1;i++) 
      for(int j=i+1;j<nb;j++)
        bille[i].collision(bille[j]);
}
void out() {
    for(int i=1;i<nb;i++) 
      if (!bille[i].out)
        for (int t=0;t<6;t++) if (bille[i].position.dist(trou[t].position)<trou[t].rayon) bille[i].out=true;
}