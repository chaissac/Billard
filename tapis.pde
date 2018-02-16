class Tapis {

  Balle[] bille ;
  Trou[] trou ;
  boolean bouge;
  int x, y, dx, dy, nb;
  color[] couleurs = {#D00000,#E0C000,#0000D0,#00D0D0};
  public Tapis(int _x, int _y, int _nb) {
    x=_x;
    y=_y;
    nb=_nb+1;
    dx = (width-x)/2;
    dy = (height-y)/2;
    trou = new Trou[6];
    trou[0]= new Trou(dx+RAYON/2, dy+RAYON/2);
    trou[1]= new Trou(dx+RAYON/2, dy+y/2);
    trou[2]= new Trou(dx+RAYON/2, dy+y-RAYON/2);
    trou[3]= new Trou(dx+x-RAYON/2, dy+RAYON/2);
    trou[4]= new Trou(dx+x-RAYON/2, dy+y/2);
    trou[5]= new Trou(dx+x-RAYON/2, dy+y-RAYON/2);
    init();
  }
  void init() {
    bille = new Balle[nb];
    float px, py, tmp;
    tmp=1;
    px=0;
    py=0;
    for (int i=1; i<nb; i++) {
      bille[i] = new Balle(x/2+dx+px*RAYON*2, dy+0.4*x-py*RAYON*2, couleurs[i%couleurs.length]);
      tmp--;
      px++;
      if (tmp==0) {
        py++;
        tmp=py+1;
        px=-py/2;
      }
    }
    bille[0] = new Balle(dx+x/2, dy+y*.75, #FFFFFF);
    collision();
    bouge=false;
  }
  void blanche() {
    if (bille[0].out) {
      bille[0] = new Balle(dx+x/2, dy+y*.75, #FFFFFF);
      collision();
      draw();
    }
  }
  void draw() {
    background(#404040);
    stroke(255);
    fill(#A08000);
    rect(dx-RAYON*1.5, dy-RAYON*1.5, x+RAYON*3, y+RAYON*3);   
    fill(#008000);
    rect(dx, dy, x, y);
    for (int t=0; t<6; t++) trou[t].draw();
    bouge = false;
    for (int i=0; i<nb; i++) {
      float o = step(bille[i]) ;
      if (o>0) bouge=true;
      if (o<0) {
        tint(bille[i].couleur);
      } else tint(#101010);
      stroke(255);
      if (i>0) image(boule,dx+RAYON*2.5*i-RAYON,dy+y+RAYON*2,RAYON*2,RAYON*2);
    }
    out();
    if (!bouge) {
      blanche();
      if (mousePressed) {
        stroke(255);
        PVector force = new PVector(bille[0].position.x-mouseX, bille[0].position.y-mouseY).limit(100);
        line(bille[0].position.x, bille[0].position.y, bille[0].position.x-force.x, bille[0].position.y-force.y);
      }
    } else collision();
  }
  public void joue(PVector f) {
    bille[0].vitesse = f.mult(0.2);
  }
  void collision() { 
    for (int i=0; i<nb-1; i++) 
      for (int j=i+1; j<nb; j++)
        bille[i].collision(bille[j]);
  }
  void out() {
    for (int i=0; i<nb; i++) 
      if (!bille[i].out) 
        for (int t=0; t<6; t++) 
          if (bille[i].position.dist(trou[t].position)<trou[t].rayon)
            bille[i].out=true;
  }
  public float step(Balle b) {
    if (b.out) {
      return -1;
    }
    b.position.add(b.vitesse);
    b.vitesse.mult(FROTTEMENT);
    rebond(b);
    if (b.vitesse.magSq()<VLIMITE) b.vitesse.set(0, 0);
    b.draw();
    return b.vitesse.magSq();
  }
  void rebond(Balle b) {
    if (!b.out) {
      if (b.position.x-b.rayon<dx) {
        b.position.x=b.rayon+dx;
        b.vitesse.x=-b.vitesse.x*FROTTEMENT;
      }
      if (b.position.x+b.rayon>x+dx) {
        b.position.x=x+dx-b.rayon;
        b.vitesse.x=-b.vitesse.x*FROTTEMENT;
      }    
      if (b.position.y-b.rayon<dy) {
        b.position.y=dy+b.rayon;
        b.vitesse.y=-b.vitesse.y*FROTTEMENT;
      }
      if (b.position.y+b.rayon>y+dy) {
        b.position.y=y+dy-b.rayon;
        b.vitesse.y=-b.vitesse.y*FROTTEMENT;
      }
    }
  }
}