class Volt extends PowerUp {

  Volt(PVector pos) {

    super(pos, 30, 45);
  }

  void boost() {

    PImage[] idle = p1.idle;
    PImage[] run = p1.run;
    PImage[] jump = p1.jump;
    PImage[] Pcrouch = p1.Pcrouch;
    PImage[] attk = p1.attk;
    PImage[] punch = p1.punch;

    int tileWdth = p1.tileWdth;
    int tileHght = p1.tileHght;

    if (boostFlag == -1) ;

    else {

      if (boostTimer == -1 && isAlive) {

        isAlive = false;
        boostTimer = 600;
        p1.health = 1000;
        p1.strength = 2;
        p1.drawBoosted = true;


        PImage idleSheet = loadImage("player idle boosted.png");
        for (int i = 0; i < idle.length; i++) {

          PImage tile = createImage(tileWdth, tileHght, ARGB);
          tile.copy(idleSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
          idle[i] = tile;
          idle[i].resize(idle[i].width*2, idle[i].height*2);
        }

        PImage runSheet = loadImage("run cycle boosted 48x48.png");
        for (int i = 0; i < run.length; i++) {

          PImage tile = createImage(tileWdth, tileHght, ARGB);
          tile.copy(runSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
          run[i] = tile;
          run[i].resize(run[i].width*2, run[i].height*2);
        }

        PImage jumpSheet = loadImage("player jump boosted 48x48.png");
        for (int i = 0; i < jump.length; i++) {

          PImage tile = createImage(tileWdth, tileHght, ARGB);
          tile.copy(jumpSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
          jump[i] = tile;
          jump[i].resize(jump[i].width*2, jump[i].height*2);
        }

        PImage crouchSheet = loadImage("Player Crouch-Idle boosted 48x48.png");
        for (int i = 0; i < Pcrouch.length; i++) {

          PImage tile = createImage(tileWdth, tileHght, ARGB);
          tile.copy(crouchSheet, i*tileWdth, 0, tileWdth, tileHght, 0, 0, tileWdth, tileHght);
          Pcrouch[i] = tile;
          Pcrouch[i].resize(Pcrouch[i].width*2, Pcrouch[i].height*2);
        }

        PImage attkSheet = loadImage("player sword atk boosted 64x64.png");
        for (int i = 0; i < attk.length; i++) {

          PImage tile = createImage(64, 64, ARGB);
          tile.copy(attkSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
          attk[i] = tile;
          attk[i].resize(attk[i].width*2, attk[i].height*2);
        }

        PImage punchSheet = loadImage("Player Punch boosted 64x64.png");
        for (int i = 0; i < punch.length; i++) {

          PImage tile = createImage(64, 64, ARGB);
          tile.copy(punchSheet, i*64, 0, 64, 64, 0, 0, 64, 64);
          punch[i] = tile;
          punch[i].resize(punch[i].width*2, punch[i].height*2);
        }
      } else if (boostTimer > 0 ) boostTimer--;

      else if (boostTimer == 0) {

        boostFlag = -1;
        p1.health = 10;
        p1.strength = 1;
        p1.drawBoosted = false;
        boostTimer--;

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
      }
    }
  }

  void drawMe() {

    pushMatrix();

    translate(pos.x- p1.pos.x - width*translationCounter, pos.y);

    fill(255, 255, 0);
    strokeWeight(1);
    stroke(255, 255, 0);

    triangle( 0, -22.5, -15, -2.5, -5, -2.5 );
    rect(-15, -2.5, 30, 5);
    triangle( 0, 22.5, 15, 2.5, 5, 2.5 );

    popMatrix();
  }
}
