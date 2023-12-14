
class WingedEnemy extends Enemy {

  int hoverTimer;

  WingedEnemy(PVector pos) {

    super(pos);

    vel = new PVector(0, 0.5);
    hoverTimer = (int)random(0, 60);

    PImage idleSheet = loadImage("winged enemy Idle 48x48.png");
    for (int i = 0; i < idle.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(idleSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      idle[i] = tile;
      idle[i].resize(idle[i].width*2, idle[i].height*2);
    }
    
    
    PImage punchSheet = loadImage("winged enemy punch 64x64.png");
    for (int i = 0; i < punch.length; i++) {

      PImage tile = createImage(64, 64, ARGB);
      tile.copy(punchSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
      punch[i] = tile;
      punch[i].resize(punch[i].width*2, punch[i].height*2);
    }
    
    PImage hurtSheet = loadImage("winged enemy Hurt 48x48.png");
    hurt = createImage(48,48,ARGB);
    hurt.copy(hurtSheet,0,0,48,48,0,0,48,48);
    hurt.resize(hurt.width*2,hurt.height*2);
  }

  void update() {

    if (health <= 0) isAlive = false;

    drawMe();
    move();

    Player p = closerPlayer();

    //float dist  = dist(pos.x - p1.pos.x - width*translationCounter, pos.y, p.pos.x, p.pos.y);

    if ( pos.x - p1.pos.x - width*translationCounter < p.pos.x  ) {

      facingRight = true;
      fire();
    } else if (pos.x - p1.pos.x - width*translationCounter > p.pos.x ) {

      facingRight = false;
      fire();
    }

    checkProjectiles();

    //println("update");
    //fire();
  }

  void move() {

    if (hoverTimer == -1) hoverTimer = 60;

    else if (hoverTimer > 0) hoverTimer--;

    else if  (hoverTimer == 0) {

      hoverTimer--;
      vel.set(vel.x, vel.y*-1);
    }

    pos.add(vel);
  }

  void drawMe() {

    pushMatrix();
    translate(pos.x- p1.pos.x - width*translationCounter, pos.y-5);

    if (!facingRight) scale(-1, 1);


    if (hurtTimer > 0) hurtAnimation();

    else if (fireTimer >= 0) {

      if ( fireTimer > 30 ) {



        if (displayIndex <= idle.length - 2) {

          if (frameCount % 6 == 0) displayIndex++;
        } else displayIndex = 0;

        image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);
      } else {

        if (punchDisplayIndex <= punch.length - 2) {

          if (frameCount % 6 == 0) punchDisplayIndex++;
        } else punchDisplayIndex = 0;

        image(punch[punchDisplayIndex], -punch[punchDisplayIndex].width/2, -punch[punchDisplayIndex].height/2);
      }
    } else {



      if (displayIndex <= idle.length - 2) {

        if (frameCount % 6 == 0) displayIndex++;
      } else displayIndex = 0;

      image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);
    }

    popMatrix();
  }

  void fire() {

    if (fireTimer == -1 ) {
      
      fireTimer = 150;
      punchDisplayIndex = 0;
    }

    else if (fireTimer > 0 ) fireTimer--;

    else {

      //println("fire");

      if (facingRight) projectiles.add( new WingedEnemyProjectile( new PVector(pos.x + wdth/2 - p1.pos.x-width*translationCounter, pos.y - hght/2)) );

      else projectiles.add( new WingedEnemyProjectile( new PVector(pos.x - wdth/2 - p1.pos.x-width*translationCounter, pos.y - hght/2) ) );

      fireTimer--;
    }
  }
}
