class Enemy extends Character {

  ArrayList<EnemyProjectile> projectiles;
  int fireTimer;

  // all the animations
  PImage[] idle = new PImage[10];
  PImage[] punch = new PImage[8];
  PImage[] stab = new PImage[7];
  PImage[] walk = new PImage[8];
  PImage hurt;
  int tileHght = 48;
  int tileWdth = 48;
  int displayIndex;
  int stabDisplayIndex;
  int punchDisplayIndex;
  int hurtTimer;

  Enemy(PVector pos) {

    super(pos, new PVector(-2, 0) );
    hght = 50;
    wdth = 20;
    maxHealth = 4;
    health = 4;
    fireTimer = -1;
    hurtTimer = -1;

    displayIndex = 0;
    stabDisplayIndex = 0;
    punchDisplayIndex = 0;

    projectiles = new ArrayList<EnemyProjectile>();

    PImage idleSheet = loadImage("enemy Idle 48x48.png");
    for (int i = 0; i < idle.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(idleSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      idle[i] = tile;
      idle[i].resize(idle[i].width*2, idle[i].height*2);
    }

    PImage walkSheet = loadImage("enemyWalk 48x48.png");
    for (int i = 0; i < walk.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(walkSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      walk[i] = tile;
      walk[i].resize(walk[i].width*2, walk[i].height*2);
    }

    PImage punchSheet = loadImage("enemy punch 64x64.png");
    for (int i = 0; i < punch.length; i++) {

      PImage tile = createImage(64, 64, ARGB);
      tile.copy(punchSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
      punch[i] = tile;
      punch[i].resize(punch[i].width*2, punch[i].height*2);
    }

    PImage stabSheet = loadImage("enemy Sword Stab 96x48.png");
    for (int i = 0; i < stab.length; i++) {

      PImage tile = createImage(96, tileHght, ARGB);
      tile.copy(stabSheet, i*96, 0, 96, tileHght, 0, 0, 96, tileHght);
      stab[i] = tile;
      stab[i].resize(stab[i].width*2, stab[i].height*2);
    }

    PImage hurtSheet = loadImage("enemy Hurt 48x48.png");
    hurt = createImage(48, 48, ARGB);
    hurt.copy(hurtSheet, 0, 0, 48, 48, 0, 0, 48, 48);
    hurt.resize(hurt.width*2, hurt.height*2);
  }

  void update() {

    super.update();

    checkProjectiles();

    //find closer player (this is from when the game was two players)
    Player p = closerPlayer();

    float dist  = dist(pos.x - p1.pos.x - width*translationCounter, pos.y, p.pos.x, p.pos.y);

    if ( pos.x - p1.pos.x - width*translationCounter < p.pos.x  && (dist < 300) && abs(p1.pos.y - pos.y) < 50 ) facingRight = true;

    else if (pos.x - p1.pos.x - width*translationCounter > p.pos.x  && dist < 300 && abs(p1.pos.y - pos.y) < 50) facingRight = false;

    if ( dist(pos.x- p1.pos.x - width*translationCounter, pos.y, p.pos.x, p.pos.y) < 40 && !attacking ) basicAttackTimer = 60;

    if (basicAttackTimer == -1 ) attacking = false;

    else if ( dist(pos.x- p1.pos.x - width*translationCounter, pos.y, p.pos.x, p.pos.y) > 40 && attacking ) {

      basicAttackTimer = -1;
      attacking = false;
      stabDisplayIndex = 0;
    }
  }

  void move() {

    pushMatrix();
    translate(-p1.pos.x - width*translationCounter, 0);

    float dist  = dist(pos.x - p1.pos.x - width*translationCounter, pos.y, p1.pos.x, p1.pos.y);

    super.move();

    // if within 40 px of p, stop.
    if ( dist < 40 ) vel.x = 0;

    // else if p to the right
    else if ( facingRight &&  dist < 300 && abs(p1.pos.y - pos.y) < 50 ) {

      // by default, move forward
      vel.x = 2;

      int currIndex = lv.currLevel.enemies.indexOf(this);

      int i = 0;

      if ( i == currIndex ) i++;

      // go though all the enemies except itself
      while ( i < lv.currLevel.enemies.size() ) {

        Enemy e = lv.currLevel.enemies.get(i);

        // if within 40 of any enemy in front of itself, stop
        if ( (dist(pos.x, pos.y, e.pos.x, e.pos.y)) < 80 && (pos.x < e.pos.x) ) {

          vel.x = 0;
          fire();
        }

        i++;
        if ( i == currIndex ) i++;
      }

      // if p to the left
    } else if (!facingRight && dist < 300 && abs(p1.pos.y - pos.y) < 50 ) {

      vel.x = -2;

      int currIndex = lv.currLevel.enemies.indexOf(this);

      int i = 0;

      if ( i == currIndex ) i++;

      // go though all the enemies except itself
      while ( i < lv.currLevel.enemies.size() ) {

        Enemy e = lv.currLevel.enemies.get(i);

        // if within 40 of any enemy in front of itself, stop
        if ( (dist(pos.x, pos.y, e.pos.x, e.pos.y)) < 80 && (pos.x > e.pos.x) ) {

          vel.x = 0;
          fire();
        }

        // otherwise, keep moving
        i++;
        if ( i == currIndex ) i++;
      }
    } else {

      fireTimer = -1;
      punchDisplayIndex = 0;
    }
    popMatrix();
  }

  void checkProjectiles() {

    for (int i = 0; i < projectiles.size(); i++ ) {

      EnemyProjectile p = projectiles.get(i);

      if (!p.isAlive) projectiles.remove(i);

      p.update();

      if (p.hit(p1) && p.isAlive) {

        println("Hi");
        p.isAlive = false;

        if (!p1.drawBoosted) {
          p1.health--;
          p1.basicAttackTimer = -1;
          p1.skill1Timer = -1;
          p1.hurtTimer = 12;
          p1.punchDisplayIndex = 0;
          p1.attkDisplayIndex = 0;
        }
      }
    }
  }

  void fire() {

    if (fireTimer == -1 ) {

      fireTimer = 60;
      punchDisplayIndex = 0;
    }

    else {


      if (fireTimer == 10) {

        if (facingRight) projectiles.add( new EnemyProjectile( new PVector(pos.x + wdth/2 - p1.pos.x-width*translationCounter, pos.y - hght/2 +5), new PVector(5, 0) ) );

        else projectiles.add( new EnemyProjectile( new PVector(pos.x - wdth/2 - p1.pos.x-width*translationCounter, pos.y - hght/2 +5), new PVector(-5, 0) ) );
      }

      fireTimer--;
    }
  }

  void basicAttack() {

    Player p = closerPlayer();

    hit.play(0);
    p.health--;
    p.hurtTimer = 12;
    p.basicAttackTimer = -1;
    p.skill1Timer = -1;
    p1.punchDisplayIndex = 0;
    p1.attkDisplayIndex = 0;
  }

  void drawMe() {

    pushMatrix();
    translate(pos.x- p1.pos.x - width*translationCounter, pos.y-5);

    if (!facingRight) scale(-1, 1);

    if (hurtTimer > 0) hurtAnimation();

    else if (basicAttackTimer >= 0 ) basicAttackAnimation();

    else if (fireTimer >= 0) {

      if ( fireTimer > 30 ) {

        if (vel.x > 0.1 || vel.x < -0.1) {

          if (displayIndex <= walk.length - 2) {

            if (frameCount % 6 == 0) displayIndex++;
          } else displayIndex = 0;

          image(walk[displayIndex], -walk[displayIndex].width/2, -walk[displayIndex].height/2);
        } else {

          if (displayIndex <= idle.length - 2) {

            if (frameCount % 6 == 0) displayIndex++;
          } else displayIndex = 0;

          image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);
        }
      } else {

        if (punchDisplayIndex <= punch.length - 2) {

          if (frameCount % 6 == 0) punchDisplayIndex++;
        } else punchDisplayIndex = 0;

        image(punch[punchDisplayIndex], -punch[punchDisplayIndex].width/2, -punch[punchDisplayIndex].height/2);
      }
    } else {

      if (vel.x > 0.1 || vel.x < -0.1) {

        if (displayIndex <= walk.length - 2) {

          if (frameCount % 6 == 0) displayIndex++;
        } else displayIndex = 0;

        image(walk[displayIndex], -walk[displayIndex].width/2, -walk[displayIndex].height/2);
      } else {

        if (displayIndex <= idle.length - 2) {

          if (frameCount % 6 == 0) displayIndex++;
        } else displayIndex = 0;

        image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);
      }

      //popMatrix();
    }
    popMatrix();
  }

  void basicAttackAnimation() {


    if ( basicAttackTimer == -1 ); // do nothing

    else if ( basicAttackTimer > 35 ) {

      if (displayIndex <= idle.length - 2) {

        if (frameCount % 6 == 0) displayIndex++;
      } else displayIndex = 0;

      image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);

      attacking = true;
      basicAttackTimer--;
    } else if ( basicAttackTimer >= 0 ) {

      if (basicAttackTimer == 12 && !p1.drawBoosted) basicAttack();

      if (stabDisplayIndex <= stab.length - 2) {

        if (frameCount % 6 == 0) stabDisplayIndex++;
      } else stabDisplayIndex = 0;

      image(stab[stabDisplayIndex], -stab[stabDisplayIndex].width/2, -stab[stabDisplayIndex].height/2);

      basicAttackTimer--;
    }
  }

  void hurtAnimation() {

    image(hurt, -hurt.width/2, -hurt.height/2);

    hurtTimer--;
  }

  // also from when game was two players
  Player closerPlayer() {
    return p1;
  }
}
