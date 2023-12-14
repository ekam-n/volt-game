class Player1 extends Player {

  PImage[] idle = new PImage[10];
  PImage[] run = new PImage[8];
  PImage[] jump = new PImage[3];
  PImage[] Pcrouch = new PImage[10];
  PImage[] attk = new PImage[6];
  PImage[] punch = new PImage[8];
  PImage hurt;
  int tileHght = 48;
  int tileWdth = 48;
  int displayIndex;
  int attkDisplayIndex;
  int punchDisplayIndex;

  Player1(PVector pos) {

    super(pos);

    displayIndex = 0;
    attkDisplayIndex = 0;
    punchDisplayIndex = 0;

    PImage idleSheet = loadImage("player idle.png");
    for (int i = 0; i < idle.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(idleSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      idle[i] = tile;
      idle[i].resize(idle[i].width*2, idle[i].height*2);
    }

    PImage runSheet = loadImage("run cycle 48x48.png");
    for (int i = 0; i < run.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(runSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      run[i] = tile;
      run[i].resize(run[i].width*2, run[i].height*2);
    }

    PImage jumpSheet = loadImage("player jump 48x48.png");
    for (int i = 0; i < jump.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(jumpSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      jump[i] = tile;
      jump[i].resize(jump[i].width*2, jump[i].height*2);
    }

    PImage crouchSheet = loadImage("Player Crouch-Idle 48x48.png");
    for (int i = 0; i < Pcrouch.length; i++) {

      PImage tile = createImage(tileWdth, tileHght, ARGB);
      tile.copy(crouchSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
      Pcrouch[i] = tile;
      Pcrouch[i].resize(Pcrouch[i].width*2, Pcrouch[i].height*2);
    }

    PImage attkSheet = loadImage("player sword atk 64x64.png");
    for (int i = 0; i < attk.length; i++) {

      PImage tile = createImage(64, 64, ARGB);
      tile.copy(attkSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
      attk[i] = tile;
      attk[i].resize(attk[i].width*2, attk[i].height*2);
    }

    PImage punchSheet = loadImage("Player Punch 64x64.png");
    for (int i = 0; i < punch.length; i++) {

      PImage tile = createImage(64, 64, ARGB);
      tile.copy(punchSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
      punch[i] = tile;
      punch[i].resize(punch[i].width*2, punch[i].height*2);
    }

    PImage hurtSheet = loadImage("Player Hurt 48x48.png");
    hurt = createImage(48, 48, ARGB);
    hurt.copy(hurtSheet, 0, 0, 48, 48, 0, 0, 48, 48);
    hurt.resize(hurt.width*2, hurt.height*2);
  }


  void skill1() {

    if (facingRight) projectiles.add( new Player1Projectile( new PVector(pos.x + wdth/2, pos.y - 5 ), new PVector(15, 0) ) );

    else projectiles.add( new Player1Projectile( new PVector(pos.x - wdth/2, pos.y - 20 ), new PVector(-15, 0) ) );
  }

  void checkProjectiles() {

    for (int i = 0; i < projectiles.size(); i++ ) {

      Player1Projectile p = projectiles.get(i);


      for (int j = 0; j < lv.currLevel.enemies.size(); j++ ) {

        Enemy e = lv.currLevel.enemies.get(j);


        if (p.hit(e)) {

          p.isAlive = false;
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


  void standAnimation() {

    pushMatrix();

    translate(pos.x, pos.y-5);

    if ( !facingRight ) scale(-1, 1);

    if (displayIndex <= idle.length - 2) {

      if (frameCount % 6 == 0) displayIndex++;
    } else displayIndex = 0;

    image(idle[displayIndex], -idle[displayIndex].width/2, -idle[displayIndex].height/2);

    popMatrix();
  }

  void moveAnimation() {

    pushMatrix();

    translate(pos.x, pos.y-5);

    if ( !facingRight ) scale(-1, 1);

    if (displayIndex <= run.length - 2) {

      if (frameCount % 6 == 0) displayIndex++;
    } else displayIndex = 0;

    image(run[displayIndex], -run[displayIndex].width/2, -run[displayIndex].height/2);

    popMatrix();
  }

  void basicAttackAnimation() {

    pushMatrix();
    translate(pos.x, pos.y-5);

    if (!facingRight) scale(-1, 1);

    if (attkDisplayIndex <= attk.length - 2) {

      if (frameCount % 6 == 0) attkDisplayIndex++;
    } else attkDisplayIndex = 0;

    image(attk[attkDisplayIndex], -attk[attkDisplayIndex].width/2, -attk[attkDisplayIndex].height/2);

    if (basicAttackTimer >0) basicAttackTimer--;

    else {

      basicAttack();
      basicAttackTimer--;
      attkDisplayIndex = 0;
    }

    popMatrix();
  }

  void skill1Animation() {


    pushMatrix();
    translate(pos.x, pos.y-5);

    if (!facingRight) scale(-1, 1);

    if (punchDisplayIndex <= punch.length - 2) {

      if (frameCount % 6 == 0) punchDisplayIndex++;
    } else punchDisplayIndex = 0;

    image(punch[punchDisplayIndex], -punch[punchDisplayIndex].width/2, -punch[punchDisplayIndex].height/2);

    if (skill1Timer > 0) {

      if (skill1Timer == 5 ) skill1();


      skill1Timer--;
    } else {
      skill1Timer--;
      punchDisplayIndex = 0;
    }

    popMatrix();
  }

  void skill2Animation() {

    pushMatrix();
    translate(pos.x, pos.y);
    if (!facingRight) scale(-1, 1);

    popMatrix();
  }

  void jumpAnimation() {

    pushMatrix();

    translate(pos.x, pos.y);

    if ( !facingRight ) scale(-1, 1);


    if (vel.y > 3) image(jump[2], -jump[2].width/2, -jump[2].height/2);

    else if (vel.y < -3) image(jump[0], -jump[0].width/2, -jump[0].height/2);

    else image(jump[1], -jump[1].width/2, -jump[1].height/2);

    popMatrix();
  }

  void crouchAnimation() {


    pushMatrix();

    translate(pos.x, pos.y-5);

    if ( !facingRight ) scale(-1, 1);


    if (displayIndex <= Pcrouch.length - 2) {

      if (frameCount % 6 == 0) displayIndex++;
    } else displayIndex = 0;

    image(Pcrouch[displayIndex], -Pcrouch[displayIndex].width/2, -Pcrouch[displayIndex].height/2);

    popMatrix();
  }

  void hurtAnimation() {

    pushMatrix();
    translate(pos.x, pos.y-5);
    if (!facingRight) scale(-1, 1);

    image(hurt, -hurt.width/2, -hurt.height/2);


    popMatrix();
    hurtTimer--;
  }
}
