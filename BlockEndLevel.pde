// block that ends the level and sends you to the next one

class BlockEndLevel extends Block {
  
 BlockEndLevel(PVector pos, int wdth, int hght) {
   
  super(pos,wdth,hght); 
   
 }
 
 void update(Character c) {
   
   super.update(c);
   
   if (isOn(p1)) {
     
    gameState++;
    
    p1.pos.x = 20;
    p1.pos.y = 700;
    p1.health = 10;
    
    translationCounter = 0;
     
   }
   
 }
  
}
