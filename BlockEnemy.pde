// block that spawns an enemy on top of it

class BlockEnemy extends Block {
  
  boolean spawnEnemy;
  
 BlockEnemy(PVector pos, int wdth, int hght) {
   
   super(pos,wdth,hght);
   
   spawnEnemy = true;
   
 }
 
 void update(Character c) {
   
   super.update(c);
   
   if (spawnEnemy) {
     
     lv.currLevel.enemies.add(new Enemy(new PVector(pos.x , pos.y - wdth/2 - 50)));
     spawnEnemy = false;
    
     
   }
   
 }
  
}
