
// block that spawns boulders
class BlockBoulder extends Block {
  
  int fireTimer;
  boolean facingRight;
  

 BlockBoulder(PVector pos, int wdth, int hght, boolean facingRight) {
   
  super(pos,wdth,hght);
  
  fireTimer = 120;
  this.facingRight = facingRight;
   
 }
 
 void update(Character c) {
   
  super.update(c);
  
  fire();

   
 }
 
 
 void fire() {
   
  if (fireTimer == -1) fireTimer = 120; 
  
  else if (fireTimer > 0) fireTimer--;
  
  else if (fireTimer == 0) {
    
   // use facingRight boolean to see which way to shoot
   if (facingRight) {
     
     lv.currLevel.boulders.add( new Boulder( new PVector(pos.x + wdth/2 + 25, pos.y), new PVector(5,0)));
     fireTimer--;
   }
   
   else {
     
     lv.currLevel.boulders.add( new Boulder( new PVector(pos.x - wdth/2 - 25, pos.y), new PVector(-5,0)));
     fireTimer--;
     
   }
    
  }
   
 }
  
}
