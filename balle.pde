class Balle {

  PVector position, vitesse ;
  color couleur ;
  boolean out ;


  float rayon = RAYON;

  public Balle(float x, float y, color c) {
    position = new PVector(x, y);
    vitesse = new PVector(0, 0);
    couleur=c;
    out = false;
  }
  public boolean draw() {
    if (!out) {
      tint(couleur);
      image(boule,position.x-rayon,position.y-rayon,rayon*2,rayon*2);
    } 
    return out;
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