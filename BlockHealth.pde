// block that spawns health boost

class BlockHealth extends Block {
  
  boolean spawnHealth;
  
 BlockHealth(PVector pos, int wdth, int hght) {
   
  super(pos,wdth,hght); 
  
  spawnHealth = true;
   
 }
 
 void update(Character c) {
   
   super.update(c);
  
  if (spawnHealth) {
    
    lv.currLevel.boosts.add( new HealthBoost( new PVector(pos.x, pos.y + 20) ) );
    spawnHealth = false;
    
  }
   
 }
 
 void drawMe(Character c) {
 }
 
 boolean bump(Character c) {
   return false;
 }
 
 boolean bump(Player c) {
   return false;
 }
 
 boolean isOn(Player c) {
   return false;
 }
 
 boolean isOn(Character c) {
   return false;
 }
 
 
 

  
}
