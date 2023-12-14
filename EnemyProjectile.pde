class EnemyProjectile extends Projectile {

  EnemyProjectile(PVector pos, PVector vel) {

    super(pos, vel);
    wdth = 7;
    hght = 7;
  }

  void update() {

    super.update();

    if (hit(p1)) {
      
      hit.play(0);
      isAlive = false;

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

  void checkBlocks() {

    for (int i = 0; i < lv.currLevel.blocks.size(); i++ ) {

      Block b = lv.currLevel.blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter)) {

        if (vel.x > 0) {


          if ( (pos.x + wdth/2> b.pos.x - p1.pos.x - width*translationCounter - b.wdth/2  && pos.x + wdth/2 < b.pos.x - p1.pos.x - width*translationCounter + b.wdth/2)
            && (pos.y > b.pos.y - b.hght/2 && pos.y < b.pos.y + b.hght/2)) isAlive = false;
        } else {

          if ( (pos.x - wdth/2> b.pos.x - p1.pos.x - width*translationCounter - b.wdth/2 && pos.x - wdth/2 < b.pos.x - p1.pos.x - width*translationCounter + b.wdth/2 )
            && (pos.y > b.pos.y - b.hght/2 && pos.y < b.pos.y + b.hght/2)) isAlive = false;
        }
      }
    }
  }

  void drawMe() {



    stroke(170,100,40);
    strokeWeight(1);
    fill(170,100,40);

    ellipse(pos.x, pos.y, wdth, hght);
  }
}
