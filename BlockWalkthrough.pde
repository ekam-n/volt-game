// block that the player can walk through

class BlockWalkthrough extends Block {
  
 BlockWalkthrough(PVector pos, int wdth, int hght) {
   
  super(pos,wdth,hght); 
   
 }
 
 boolean bump(Player c) {
   
   
   return false;
 }
  
}
