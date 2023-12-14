class Boulder extends Character {


  Boulder(PVector pos, PVector vel) {


    super(pos, vel);

    wdth = 50;
    hght = 50;
  }

  void update() {

    move();
    handleWalls();
    drawMe();

    if (hitCharacter(p1)) {


      this.isAlive = false;
      p1.health -= 4;
      hit.play(0);
      p1.hurtTimer = 12;
      p1.basicAttackTimer = -1;
      p1.skill1Timer = -1;
      p1.punchDisplayIndex = 0;
      p1.attkDisplayIndex = 0;
    }


    for (int i = 0; i < lv.currLevel.blocks.size(); i++) {

      Block b = lv.currLevel.blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter)) {

        if (b.bump(this)) {

          if (vel.y == 0) isAlive = false;

          else landOn(b);
        }
      }
    }
  }

  void handleWalls() {

    if (pos.x < -wdth/2 + p1.pos.x + width*translationCounter || pos.x > width + p1.pos.x + width*translationCounter + wdth/2) {

      isAlive = false;
    }
    if (pos.y < -hght/2 || pos.y > height + hght/2) isAlive = false;
  }

  void drawMe() {

    pushMatrix();
    translate(pos.x - p1.pos.x - width*translationCounter, pos.y);

    stroke(170, 100, 40);
    strokeWeight(1);
    fill(0);

    ellipse(0, 0, wdth, hght);

    popMatrix();
  }
}
