class Projectile {

  PVector pos, vel;
  int wdth, hght;
  boolean isAlive;

  Projectile(PVector pos, PVector vel) {

    this.pos = pos;
    this.vel = vel;
    isAlive = true;
  }

  void update() {

    if ( isAlive ) {

      move();
      drawMe();
      checkWalls();
      checkBlocks();
    }
    
  }

  void move() {

    pos.add(vel);
    //println("move");
  }

  void checkWalls() {

    if ( pos.x < -wdth/2 || pos.x > width + wdth/2) isAlive = false;

    if ( pos.y < -hght/2 || pos.y > height + hght/2 ) isAlive = false;
  }
  
  void checkBlocks() {
    
  }

  boolean hit(Character c) {

    return abs( pos.x - c.pos.x ) < wdth/2 + c.wdth/2
      && abs( pos.y - c.pos.y ) < hght/2 + c.hght/2;
  }


  void drawMe() {
  }
}
