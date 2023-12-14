class Character {

  PVector pos, vel;
  int maxHealth, health, wdth, hght;
  boolean isAlive;
  boolean facingRight;
  boolean attacking; // checks if character is attacking
  boolean jumping;
  Block block;
  int basicAttackTimer;


  Character ( PVector pos, PVector vel ) {

    this.pos = pos;
    this.vel = vel;
    isAlive = true;
    facingRight = true;
    attacking = false;
    jumping = true;
    block = null;
  }

  void update() {


    if (isAlive) move();
    handleWalls();
    drawMe();
    checkProjectiles();

    if ( facingRight ) {

      if ( vel.x < 0 ) facingRight = false;
    }

    if ( !facingRight ) {

      if ( vel.x > 0 ) facingRight = true;
    }

    if (health <= 0) isAlive = false;
  }

  void move() {

    pos.add(vel);
    
    if (block != null) {
      
      if (!block.isOn(this) ) jumping = true;
      
    }
    
    if (jumping) vel.y += 2;
    
  }

  void accelerate(PVector force) {

    vel.add(force);
  }
  
  void jump(PVector upForce) {
    
    vel.add(upForce);
    jumping = true;
    
  }
  
  void landOn(Block b) {
    
   jumping = false;
   block = b;
   pos.y = (b.pos.y) - b.hght/2 - hght/2;
   vel.y = 0;
    
  }
  void fall() {
   
   if (vel.y < 0 ) vel.y *= -1;
    
  }

  void basicAttack() {
  }

  void drawMe() {
  }

  void basicAttackAnimation() {
  }

  void checkProjectiles() {
  }

  boolean hitCharacter(Character other) {

    return abs( (pos.x-p1.pos.x-width*translationCounter) - other.pos.x ) < wdth/2 + other.wdth/2
      && abs( pos.y - other.pos.y ) < hght/2 + other.hght/2;
  }


  void handleWalls() {
  }
}
