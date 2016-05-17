
// Ein 2D-Punkt oder eine 2D-Richtung
class Vec2
{
  float x = 0; // x-Koordinate
  float y = 0; // y-Koordinate
  
  // Standardkonstruktur; setzt beide Koords. auf 0
  Vec2()
  {
    x = 0;
    y = 0;
  }
  
  // Setzt Koords. auf die Parameter
  Vec2(float xx, float yy)
  {
    x = xx;
    y = yy;
  }
  
  // Kopiert den Vektor ohne das der gleiche Speicher verwendet wird
  Vec2(Vec2 other)
  {
    x = other.x;
    y = other.y;
  }
  
  // Berechnet die Laenge des Vektors
  float length()
  {
    return sqrt(x * x + y * y);
  }
  
  // Berechnet die Länge des Vektors ohne das teure Wurzelziehen
  // Zum Vergleichen der Länge zweier Vektoren reicht das
  float lengthSq()
  {
    return x * x + y * y;
  }
  
  // Normalisiert den Vektor -> verändert die eigenen Attribute
  void normalize()
  {
    float l = this.length();
    x = x / l;
    y = y / l;
  }
  
  //scalarprodukt
  float scalarMult(Vec2 v) {
    return this.x*v.x+this.y*v.y;
  }
  
  boolean isZero() {
    return x == 0 && y == 0;
  }
  
  //gibt den Winkel zu der x-achse zurueck:
  float heading() {
    //man muss nen PVector nehmen, weil man die richtung nicht bestimmen kann
    PVector pv = new PVector(this.x, this.y);
    
    return pv.heading();
  }
  
  // Die nächsten Methoden führen arithmetische Rechnungen aus
  // Mal und geteilt geht mit Skalaren sowie Vektoren
  // Keine der Methoden verändert die eigenen Attribute, sondern sie erzeugen alle neue Vektoren
  Vec2 add(Vec2 other)
  {
    return new Vec2(x + other.x, y + other.y);
  }
  Vec2 sub(Vec2 other)
  {
    return new Vec2(x - other.x, y - other.y);
  }
  Vec2 mult(float f)
  {
    return new Vec2(x * f, y * f);
  }
  Vec2 mult(Vec2 other)
  {
    return new Vec2(x * other.x, y * other.y);
  }
  Vec2 div(float f)
  {
    return new Vec2(x / f, y / f);
  }
  Vec2 div(Vec2 other)
  {
    return new Vec2(x / other.x, y / other.y);
  }
  Vec2 neg()
  {
    return new Vec2(-x, -y);
  }
  
  
  void addEqual(Vec2 other)
  {
    x += other.x;
    y += other.y;
  }
  void subEqual(Vec2 other)
  {
    x -= other.x;
    y -= other.y;
  }
  void multEqual(float f)
  {
    x *= f;
    y *= f;
  }
  void multEqual(Vec2 other)
  {
    x *= other.x;
    y *= other.y;
  }
  void divEqual(float f)
  {
    x /= f;
    y /= f;
  }
  void divEqual(Vec2 other)
  {
    x /= other.x;
    y /= other.y;
  }
  
  
  //copy:
  Vec2 copy() {
    return new Vec2(x, y);
  }
}