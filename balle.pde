class Balle {

  PVector position, vitesse ;
  color couleur ;
  boolean out ;
  float VLIMITE = 0.01;
  float FROTTEMENT = 0.994;

  float rayon = 8;

  public Balle(float x, float y, color c) {
    position = new PVector(x, y);
    vitesse = new PVector(0, 0);
    couleur=c;
    out = false;
  }

  public void draw() {
    if (!out) {
      noStroke();
      fill(couleur);
      ellipse(position.x, position.y, rayon*2, rayon*2);
    }
  }

  public void tape(PVector f) {
    vitesse = f.mult(0.1);
  }
  public float step() {
    if (out) return 0;
    position.add(vitesse);
    vitesse.mult(FROTTEMENT);
    rebond();
    if (vitesse.magSq()<VLIMITE) vitesse.set(0, 0);
    draw();
    return vitesse.magSq();
  }

  void rebond() {
    if (!out) {
      if (position.x-rayon<10) {
        position.x=rayon+10;
        vitesse.x=-vitesse.x*FROTTEMENT;
      }
      if (position.x+rayon>width-10) {
        position.x=width-rayon-10;
        vitesse.x=-vitesse.x*FROTTEMENT;
      }    
      if (position.y-rayon<10) {
        position.y=rayon+10;
        vitesse.y=-vitesse.y*FROTTEMENT;
      }
      if (position.y+rayon>height-10) {
        position.y=height-rayon-10;
        vitesse.y=-vitesse.y*FROTTEMENT;
      }

    }
  }
  void collision(Balle b) {
    if (!out && !b.out) {
      float d = PVector.dist(position, b.position);
      if ( d < rayon*2 ) {
        PVector sum = PVector.mult(PVector.add(vitesse, b.vitesse), 0.5);
        float coef =0.1*((b.position.x-position.x)*(vitesse.x-sum.x) + (b.position.y-position.y)*(vitesse.y-sum.y))*FROTTEMENT/d;

        PVector force = PVector.mult(PVector.sub(position, b.position), coef);
        vitesse.add(force);
        b.vitesse.sub(force);
        //  b.position.add(PVector.mult(PVector.sub(b.position, position), (rayon)/d));
        b.position.add(PVector.mult(PVector.sub(b.position, position), 1/d));
      }
    }
  }
}