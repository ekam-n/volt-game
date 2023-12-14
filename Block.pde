
// superclass for all blocks
class Block {
  
 PVector pos;
 int wdth, hght;
 boolean switchOn; // for BlockWallSwitch class
 PImage img, imgCopy;

 
 Block(PVector pos, int wdth, int hght) {
   
   this.pos = pos;
   this.wdth = wdth;
   this.hght = hght;
   switchOn = false;
   //img = loadImage("brick tile.png");
   
   //img.resize(100,100);
   
   //imgCopy = createImage(wdth,hght,ARGB);;
   //imgCopy.copy(img,0,0,wdth,hght,0,0,wdth,hght);
   

 }
 
 void update(Character c) {
   
   drawMe(c);
   
 }
 
 boolean isOn(Character c) {
   
   if ( abs((c.pos.x - p1.pos.x - width*translationCounter) - (pos.x -p1.pos.x - width*translationCounter)) < c.wdth/2 + wdth/2 ) return true;
   
   return false;
 }
 
 
 boolean isOn(Player c) {
   
   if ( abs(c.pos.x - (pos.x - c.pos.x - width*translationCounter)) < c.wdth/2 + wdth/2 ) return true;
   
   return false;
 }
 
  boolean bump(Character c) {
    
    // bump if distance between char and block is less than ( char wdth + block wdth ) AND ( char hght and block hght) 
    if ( abs((c.pos.x - p1.pos.x - width*translationCounter) - (pos.x - p1.pos.x - width*translationCounter)) < c.wdth/2 + wdth/2 && abs(c.pos.y - (pos.y)) < c.hght/2 + hght/2 ) return true;
   
    return false;
  }
  
  boolean bump(Player c) {
    
    // bump if distance between char and block is less than ( char wdth + block wdth ) AND ( char hght and block hght) 
    if ( abs(c.pos.x - (pos.x - p1.pos.x - width*translationCounter)) < c.wdth/2 + wdth/2 && abs(c.pos.y - (pos.y)) < c.hght/2 + hght/2 ) return true;
   
    return false;
  }
  
  void drawMe(Character c) {
    
   pushMatrix();
   translate(pos.x - c.pos.x - width*translationCounter, pos.y);
   
   stroke(255);
   strokeWeight(1);
   fill(0);
   rect(-wdth/2, -hght/2, wdth, hght);
   
   //image(imgCopy,-img.width/2,-img.height/2);
   
   popMatrix();
    
  }
}
