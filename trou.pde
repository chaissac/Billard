class Trou {
  PVector position;
  float rayon = RAYON*1.15;
  
  public Trou(float x, float y) {
    position = new PVector(x, y);
  }
  public void draw() {
    noStroke();
    fill(#202020);
    ellipse(position.x, position.y, rayon*2, rayon*2);
  }
}