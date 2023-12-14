// block that spawns a winged enemy instead of a block

class BlockWingedEnemy extends Block {
  
  boolean spawnEnemy;
  
 BlockWingedEnemy(PVector pos, int wdth, int hght) {
   
  super(pos,wdth,hght); 
   
  spawnEnemy = true;
   
 }
 
 void update(Character c) {
   
   if (spawnEnemy) lv.currLevel.enemies.add(new WingedEnemy(new PVector(pos.x,pos.y + 10)));
   spawnEnemy = false;
   
 }
 
 boolean isOn(Character c) {
   return false;
 }
 
 boolean isOn(Player c) {
   return false;
 }
 
 boolean bump(Character c) {
   return false;
 }
 
 boolean bump(Player c) {
   return false;
 }
 
 void drawMe(Character c){ 
 }
  
}
