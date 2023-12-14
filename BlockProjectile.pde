// block that shoots projectiles

class BlockProjectile extends Block {
  
  boolean facingRight;
  
  int fireTimer;
  
  BlockProjectile(PVector pos, int wdth, int hght, boolean facingRight) {
    
   super(pos, wdth, hght); 
  
   this.facingRight = facingRight;
   fireTimer = -1;
    
  }
  
  void update(Character c) {
    
   super.update(c);
   
   fire();
    
  }
  
  void fire() {
  if (fireTimer == -1) {
    fireTimer = 60;
  } else if (fireTimer > 0) {
    
    fireTimer--;
    
  }
  
  else if (fireTimer == 0 ) {
    // Firing logic
    
    if (facingRight) {
      lv.currLevel.projectiles.add(new ProjectileBlock(new PVector(pos.x + wdth/2 - p1.pos.x - width*(translationCounter), pos.y - hght/8 ), new PVector(10, 0)));
    } else {
      lv.currLevel.projectiles.add(new ProjectileBlock(new PVector(pos.x - wdth/2 - p1.pos.x - width*(translationCounter) , pos.y - hght/8), new PVector(-10, 0)));
    }
    // Set a cooldown before allowing the next fire
    fireTimer = 60;
  }
}

  
  void drawMe(Character c) {
    
   pushMatrix();
   translate(pos.x - c.pos.x - width*translationCounter, pos.y);
   
   stroke(170,100,40);
   strokeWeight(3);
   fill(0);
   rect(-wdth/2, -hght/2, wdth, hght);
   
   popMatrix(); 
    
  }
  
}
