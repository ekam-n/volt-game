// block that gives the player a jump boost

class BlockJump extends Block {
  
  
 BlockJump(PVector pos, int wdth, int hght) {
   
  super(pos, wdth, hght); 
   
 }
 
 void update(Character c) {
   
  super.update(c); 
  
  if (isOn(p1) && bump(p1) ) p1.jump( new PVector(0,-155) );
  
  
   
 }
 
 void drawMe(Character c) {
   
   pushMatrix();
   translate(pos.x - c.pos.x - width*translationCounter, pos.y);
   
   stroke(0,170,255);
   strokeWeight(1);
   fill(0);
   rect(-wdth/2, -hght/2, wdth, hght);
   
   popMatrix();
   
 }
  
}
