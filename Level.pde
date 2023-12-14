//superclass for all levels

class Level {

  Level currLevel;
  int currLevelNum;

  //Constants to represent numbers for different types of block
  static final int TILE_EMPTY = 0;  //empty space
  static final int TILE_SOLID = 1;  //solid block
  static final int TILE_FLOATING_BOTTOM = 2; //floating block
  static final int TILE_FLOATING_TOP = 3; //floating block
  static final int TILE_PROJECTILE_RIGHT = 4; //block that shoots projectiles right
  static final int TILE_PROJECTILE_LEFT = 5; //block that shoots projectiles left
  static final int TILE_BREAKABLE = 6; // block that breaks when you stand on it
  static final int TILE_ENEMY = 7; // block that spawns an enemy above itself
  static final int TILE_WALL_SWITCH = 8; // wall block that activates with a switch after no more enemies in screen
  static final int TILE_HEALTH = 9; // block that spawns health boost above it
  static final int TILE_SKILL1 = 10; // block that unlocks skill1 for player
  static final int TILE_JUMP = 11; // block that gives jump boost for player
  static final int TILE_END_LEVEL = 12; // block that ends the level
  static final int TILE_BOULDER_RIGHT = 13; // block that spawns boulders to the right
  static final int TILE_BOULDER_LEFT = 14; // block that spawns boulders to the left
  static final int TILE_WINGED_ENEMY = 15; //  block that spawns a winged enemy instead of a block
  static final int TILE_VOLT = 16; // block that spawns a volt powerup instead of a block
  static final int TILE_WALKTHROUGH = 17; //block that character can walk through, but not enemies



  //Constants holding the sizes for different types of block
  static final int TILE_SIZE = 100;

  ArrayList<Block> blocks;
  ArrayList<Enemy> enemies;
  ArrayList<EnemyProjectile> projectiles;
  ArrayList<PowerUp> boosts;
  ArrayList<Boulder> boulders;


  int[][] map;

  Level() {

    blocks = new ArrayList<Block>();
    enemies = new ArrayList<Enemy>();
    projectiles = new ArrayList<EnemyProjectile>();
    boosts = new ArrayList<PowerUp>();
    boulders = new ArrayList<Boulder>();

  }

  // picks level
  void chooseLevel(int levelNum) {

    switch(levelNum) {

    case 1:
      currLevelNum = 1;
      currLevel = level1;
      break;

    case 2:
      currLevelNum = 2;
      currLevel = level2;
      break;

    case 3:
      currLevelNum = 3;
      currLevel = level3;
      break;

    default:
      ; // do nothing
    }
  }

  void update() {

    if (currLevelNum > 0) p1.skill1Unlock = true;

    if (p1.health <= 0) {
      
       p1.isAlive = false;
       retry.show();
       gameState = STATE_DEAD;


    }

    drawMe();

    checkPlayer();

    checkEnemies();


    for (int i = 0; i < enemies.size(); i++ ) {

      Enemy e = enemies.get(i);

      if ( (e.pos.x - p1.pos.x - e.wdth/2 < width*(translationCounter+1) + 300 && e.pos.x - p1.pos.x - e.wdth/2 > width*translationCounter - 300 ) ||
        (e.pos.x - p1.pos.x + e.wdth/2 < width*(translationCounter+1) + 300 && e.pos.x - p1.pos.x + e.wdth/2 > width*translationCounter - 300)) {

        if (e.isAlive) e.update();

        else {


          int j = 0;

          if ( j == i ) j++;

          // go though all the enemies except itself
          while ( j < lv.currLevel.enemies.size() ) {

            lv.currLevel.enemies.get(j).fireTimer = -1;
            lv.currLevel.enemies.get(j).punchDisplayIndex = 0;
            
            j++;
            if (j == i) j++;
            
          }

          enemies.remove(i);
        }
      }
    }

    for (int i = 0; i < boulders.size(); i++ ) {

      Boulder b = boulders.get(i);

      if (b.isAlive) {

        b.update();
      } else {

        boulders.remove(i);
      }
    }

    for (int i = 0; i < projectiles.size(); i++ ) {


      EnemyProjectile p = projectiles.get(i);

      if (p.isAlive) p.update();

      else projectiles.remove(i);

    }
  }

  // check collisions between player and blocks, player and boosts
  void checkPlayer() {

    for ( int i = 0; i < blocks.size(); i++) {

      Block b = blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter)) {

        if (b.bump(p1)) {

          if (p1.vel.y > 0 && p1.pos.y < (b.pos.y) - b.hght/2) {

            p1.landOn(b);
            //println("land");
          } else if ( p1.vel.y < 0 && p1.pos.y > b.pos.y + b.hght/2) p1.fall();

          else {

            p1.vel.x = 0;

            if ( p1.pos.x < b.pos.x - b.wdth/2 - p1.pos.x - width*translationCounter)  p1.pos.x = b.pos.x - b.wdth/2 - p1.pos.x - width*translationCounter -10;

            else if (p1.pos.x > b.pos.x + b.wdth/2 - p1.pos.x - width*translationCounter) p1.pos.x = b.pos.x + b.wdth/2 - p1.pos.x - width*translationCounter +10;
          }
        }
      }
    }

    for (int i = 0; i < boosts.size(); i++ ) {

      PowerUp p = boosts.get(i);

      p.update();

    }

  }

  // check collisions between enemies and blocks
  void checkEnemies() {

    for (int i = 0; i < blocks.size(); i++ ) {

      Block b = blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1) + 300 && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter - 300 ) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) + 300 && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter - 300 )) {


        for (int j = 0; j < enemies.size(); j++) {

          Enemy e = enemies.get(j);


          if (b.bump(e)) {

            if (e.vel.y > 0 && e.pos.y < (b.pos.y) - b.hght/2) {

              e.landOn(b);

            } else if (e.vel.y == 0 && e.jumping == false) {

              if (e.facingRight) e.pos.x = b.pos.x - b.wdth/2 - e.wdth/2;
              else e.pos.x = b.pos.x + b.wdth/2 + e.wdth/2;

              e.vel.x *= -1;
            }
          }
        }
      }
    }
  }


  void drawMe() {

    for (int i = 0; i < blocks.size(); i++ ) {

      Block b = blocks.get(i);

      if ( (b.pos.x - p1.pos.x - b.wdth/2 < width*(translationCounter+1)  && b.pos.x - p1.pos.x - b.wdth/2 > width*translationCounter) ||
        (b.pos.x - p1.pos.x + b.wdth/2 < width*(translationCounter+1) && b.pos.x - p1.pos.x + b.wdth/2 > width*translationCounter)) blocks.get(i).update(p1);
    }
  }
}
