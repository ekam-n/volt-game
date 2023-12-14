class Level2 extends Level {
  
 Level2() {
   
  super();
  
  // 0 for empty space, 1 for solid block, 2 for floating bottom, 3 for floating top, 4 block that shoots projectiles right, 5 for block that shoots projectiles left,
  // 6 for breakable floor, 7 for enemy tile, 8 for wall switch, 9 for health block, 10 for skill1 unlock, 11 for jump-block, 12 for end-level, 13 for boulders to the right
  // 14 for boulders to the left, 15 for winged enemy, 16 for Volt powerup
  
  map =  new int[][]{
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,13,0,0,0,0,0,0,0,0,14,1,1,1},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,0,0,0,0,0,0,0,0,0,8,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,15,0,0,8,16,0,0,0,0,0,0,0,0,0,8},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,2,3,3,3,3,3,3,3,3,3,3,3,3,1,3,3,3,3,3,3,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,3,1,1,0,0,15,15,15,15,0,0,1,1,12,1},
    {0,0,0,0,0,0,0,0,0,0,0,2,3,3,3,3,2,0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,15,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,3,0,3,0,0,1,1,7,0,0,0,0,0,0,7,1,1,1,1},
    {0,0,0,0,0,0,0,0,0,2,3,0,0,0,0,0,0,3,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,15,1,1,1,7,0,0,0,0,7,1,1,1,1,1},
    {0,0,0,0,0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,3,3,3,3,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,15,0,3,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {0,0,0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,15,0,0,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,3,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {0,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,2,2,2,2,2,0,8,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,7,7,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    
  };
  
  for (int i = 0; i < map.length; i++ ) {

      for (int j = 0; j < map[i].length; j++ ) {

        switch( map[i][j] ) {

        case TILE_SOLID:
          blocks.add(new Block( new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;

        case TILE_FLOATING_BOTTOM:
          blocks.add(new Block(new PVector(j*TILE_SIZE, i*(TILE_SIZE) + TILE_SIZE/4 ), TILE_SIZE, TILE_SIZE/2));
          //cheeseNum++;
          break;
          
        case TILE_FLOATING_TOP:
          blocks.add(new Block(new PVector(j*TILE_SIZE, i*(TILE_SIZE) - TILE_SIZE/4 ), TILE_SIZE, TILE_SIZE/2));
          //cheeseNum++;
          break;
          
          case TILE_PROJECTILE_RIGHT:
          blocks.add(new BlockProjectile(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE, true));
          break;
          
          case TILE_PROJECTILE_LEFT:
          blocks.add(new BlockProjectile(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE, false));
          break;
          
          case TILE_BREAKABLE:
          blocks.add(new BlockBreakable(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_ENEMY:
          blocks.add(new BlockEnemy(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_WALL_SWITCH:
          blocks.add(new BlockWallSwitch(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_HEALTH:
          blocks.add(new BlockHealth(new PVector(j*TILE_SIZE, i*TILE_SIZE ), 0, 0));
          break;
          
          case TILE_SKILL1:
          blocks.add(new BlockSkill1(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_JUMP:
          blocks.add(new BlockJump(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_END_LEVEL:
          blocks.add(new BlockEndLevel(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE));
          break;
          
          case TILE_BOULDER_RIGHT:
          blocks.add(new BlockBoulder(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE, true));
          break;
          
          case TILE_BOULDER_LEFT:
          blocks.add(new BlockBoulder(new PVector(j*TILE_SIZE, i*TILE_SIZE ), TILE_SIZE, TILE_SIZE, false));
          break;
          
          case TILE_WINGED_ENEMY:
          blocks.add(new BlockWingedEnemy(new PVector(j*TILE_SIZE, i*TILE_SIZE ), 0, 0));
          break;
          
          case TILE_VOLT:
          blocks.add(new BlockVolt(new PVector(j*TILE_SIZE, i*TILE_SIZE ), 0, 0));
          break;

        default: // empty space
          ;// do nothing
        }
      }
    }
    

   
   currLevelNum = 2;

 }
  
}
