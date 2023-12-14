class Player1Projectile extends Projectile {

  Player1Projectile(PVector pos, PVector vel) {

    super(pos, vel);
    wdth = 15;
    hght = 15;
  }

  void checkBlocks() {

    for (int i = 0; i < lv.currLevel.blocks.size(); i++ ) {

      Block b = lv.currLevel.blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter)) {

        if (p1.facingRight) {


          if ( (pos.x + wdth/2> b.pos.x - p1.pos.x - width*translationCounter - b.wdth/2 - 10 && pos.x + wdth/2 < b.pos.x - p1.pos.x - width*translationCounter + b.wdth/2)
            && (pos.y > b.pos.y - b.hght/2 && pos.y < b.pos.y + b.hght/2)) {

            //b.switchOn = true;
            isAlive = false;
            //println(b.switchOn);
          }
        } else {

          if ( (pos.x - wdth/2> b.pos.x - p1.pos.x - width*translationCounter - b.wdth/2 && pos.x - wdth/2 < b.pos.x - p1.pos.x - width*translationCounter + b.wdth/2 + 10)
            && (pos.y > b.pos.y - b.hght/2 && pos.y < b.pos.y + b.hght/2)) {

            //b.switchOn = true;
            isAlive = false;
          }
        }
      }
    }
  }

  boolean hit(Character c) {

    return abs( pos.x - (c.pos.x - p1.pos.x - width*translationCounter) ) < wdth/2 + c.wdth/2
      && abs( pos.y - c.pos.y ) < hght/2 + c.hght/2;
  }

  void checkWalls() {

    if ( pos.x < -wdth/2 || pos.x > width + wdth/2 ) isAlive = false;

    if ( pos.y < -hght/2 || pos.y > height + hght/2 ) isAlive = false;
  }

  void drawMe() {

    if (!p1.drawBoosted) {

      stroke(255, 255, 0);
      strokeWeight(1);
      fill(255, 255, 0);

      ellipse(pos.x, pos.y, wdth, hght);
    } else {

      stroke(255, 255, 0);
      strokeWeight(1);
      fill(255, 255, 0);

      ellipse(pos.x, pos.y, wdth, hght);
    }
  }
}
