// block that is a "switch" that player can only go through when all enemies before it are defeated

class BlockWallSwitch extends Block {
  
  boolean switchOn;
  boolean switchAvailable;
  
 BlockWallSwitch(PVector pos, int wdth, int hght) {
   
   super(pos,wdth,hght);
   
   switchOn = false;
   switchAvailable = true;
   
 }
 
 void update(Character c) {
   
  super.update(c);
  
  switchAvailable = true;
  
  checkSwitch();
  
  if (switchAvailable && dist(p1.pos.x,p1.pos.y, pos.x - wdth/2 - p1.pos.x - width*translationCounter, pos.y) < 40) lv.currLevel.blocks.remove(this); 
 }
 
 void drawMe(Character c) {
   
   if (!switchOn) {
   
   pushMatrix();
   translate(pos.x - c.pos.x - width*translationCounter, pos.y);
   
   stroke(255);
   strokeWeight(1);
   fill(0);
   rect(-wdth/2, -hght/2, wdth/4, hght);
   
   stroke(255,255,0);
   rect(-wdth/2 - wdth/8,-hght/4, wdth/8, hght/2);
   
   popMatrix();
   
   }
   
 }
 
 void checkSwitch() {
   
  for (int i = 0; i < lv.currLevel.enemies.size(); i++ ) {
    
   Enemy e = lv.currLevel.enemies.get(i);
   
   if (e.pos.x - p1.pos.x - width*translationCounter > 0 && e.pos.x - p1.pos.x - width*translationCounter < width 
        && e.pos.x < pos.x) {
     
     switchAvailable = false;
     
   }
    
  }
   
 }
  
}
