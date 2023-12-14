// block that spawns a volt powerup (double damage, and take no damage)

class BlockVolt extends Block {
  
  boolean spawnVolt;
  
  BlockVolt(PVector pos, int wdth, int hght) {
    
    super(pos, wdth, hght);
    
    spawnVolt = true;
    
  }
  
  void update(Character c) {
   
   super.update(c);
  
  if (spawnVolt) {
    
    lv.currLevel.boosts.add( new Volt( new PVector(pos.x, pos.y + 20) ) );
    spawnVolt = false;
    
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
