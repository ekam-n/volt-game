// the reason player and player1 are separate classes is because there used to be a player2 class

class Player extends Character {

  boolean left, right; // checks if character moving left or right
  boolean skill1Unlock, skill2Unlock;
  boolean crouch;
  int skill1Timer, skill2Timer;
  int skill1Cooldown, skill2Cooldown;
  float damp;
  float strength; //multiplier for player strength
  boolean drawBoosted;
  int hurtTimer;

  ArrayList<Player1Projectile> projectiles;

  Player(PVector pos) {

    super(pos, new PVector() );
    left = false;
    right = false;
    attacking = true;
    skill1Unlock = false;
    skill2Unlock = false;
    crouch = false;
    basicAttackTimer = -1;
    skill1Timer = -1;
    skill2Timer = -1;
    skill1Cooldown = -1;
    skill2Cooldown = -1;
    damp = 0.8;
    maxHealth = 10;
    health = 10;
    hght = 50;
    wdth = 20;
    strength = 1;
    drawBoosted = false;
    hurtTimer = -1;

    projectiles = new ArrayList<Player1Projectile>();
  }

  void update() {

    super.update();

    if ( basicAttackTimer > -1 || skill1Timer > -1 || skill2Timer > -1 ) {

      attacking = true;
    } else attacking = false;

    for ( int i = 0; i < projectiles.size(); i++ ) {

      projectiles.get(i).update();
      if (!projectiles.get(i).isAlive) projectiles.remove(i);
    }
    

  }

  void move() {

    pos.add(vel);

    if (block != null) {

      if (!block.isOn(p1) ) jumping = true;
    }

    if (jumping) vel.y += 2;

    vel.mult(damp);

    if (left) this.accelerate(leftForce);
    if (right) this.accelerate(rightForce);



    crouch();
  }

  void handleWalls() {

    if ( pos.x > width + wdth/2 ) {

      translationCounter += 2;
      pos.x = wdth/2;

      for (int i = projectiles.size() -1; i >= 0; i--) {

    
        projectiles.remove(i);
      }
    } else if ( pos.x < - wdth/2 && translationCounter > 0 ) {

      translationCounter -= 2;
      pos.x = width - wdth/2;

      for (int i = projectiles.size() -1; i >= 0; i--) {


        projectiles.remove(i);
      }
    } else if ( pos.x < wdth/2 && translationCounter == 0 ) {

      vel.x = 0;
      pos.x = wdth/2;
    }

    if (  pos.y > height + hght/2 ) health = 0;
  }

  void crouch() {

    if ( crouch ) {

      hght = 25;
    } else {

      hght = 50;
    }
  }

// sword attack
  void basicAttack() {

    if (facingRight) {


      for ( int i = 0; i < lv.currLevel.enemies.size(); i++ ) {

        Enemy e = lv.currLevel.enemies.get(i);

        if ( ((e.pos.x -e.wdth/2 - p1.pos.x - width*translationCounter) - (pos.x + wdth/2)  < 25) && ( abs(e.pos.y - pos.y) < hght+hght/2 ) && ( e.pos.x- p1.pos.x - width*translationCounter >= pos.x ) ) {

          e.health -= 1*strength;
          e.basicAttackTimer = -1;
          e.stabDisplayIndex = 0;
          e.fireTimer = -1;
          e.punchDisplayIndex = 0;
          e.hurtTimer = 12;
 
        }
      }
    } else {


      for ( int i = 0; i < lv.currLevel.enemies.size(); i++ ) {

        Enemy e = lv.currLevel.enemies.get(i);

        if ( ((pos.x-wdth/2) - (e.pos.x + e.wdth/2- p1.pos.x - width*translationCounter)  < 25) && ( abs(e.pos.y - pos.y) < hght+hght/2 ) && ( e.pos.x - p1.pos.x - width*translationCounter<= pos.x ) ) {
          
          e.health -= 1*strength;
          e.basicAttackTimer = -1;
          e.stabDisplayIndex = 0; 
          e.fireTimer = -1;
          e.punchDisplayIndex = 0;
          e.hurtTimer = 12;
        }
      }
    }
  }

  void skill1() {
  }

  void skill2() {
  }

  void drawMe() {
    
    // if player is hurt, draw hurt
    if (hurtTimer > 0) {
      
      hurtAnimation();
      
    }

    // if player simply standing, draw stand animation
    else if ( !attacking && (vel.x < 0.1 && vel.x > -0.1) && !jumping && !crouch ) standAnimation();

    // if player basic attacks, draw basic attack
    else if ( basicAttackTimer >= 0 ) basicAttackAnimation();

    // if player skill1 attacks, draw skill1
    else if ( skill1Timer >= 0 ) skill1Animation();

    // if player skill2 attacks, draw skill2
    else if ( skill2Timer >= 0 ) skill2Animation();

    // if player jumps, draw jump
    else if ( jumping && (vel.y > 3|| vel.y< 0) ) jumpAnimation();

    // if player crouches, draw couch
    else if ( crouch ) crouchAnimation();

    // when player is moving
    else moveAnimation();
  }

  void standAnimation() {
  }

  void moveAnimation() {
  }

  void basicAttackAnimation() {
  }

  void skill1Animation() {
  }

  void skill2Animation() {
  }

  void jumpAnimation() {
  }

  void crouchAnimation() {
  }
  
  void hurtAnimation() {
  }
}
