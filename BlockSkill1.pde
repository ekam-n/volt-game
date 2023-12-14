// this block was meant to unlock skill1 for player, but I changed it so skill1 is unlocked from start

class BlockSkill1 extends Block {
  
 BlockSkill1(PVector pos, int wdth, int hght) {
   
   super(pos,wdth,hght);
   
 }
 
 void update(Character c) {
   
  super.update(c);
  
  if (isOn(p1)) p1.skill1Unlock = true;
   
 }
  
}
