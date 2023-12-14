class HealthBoost extends PowerUp { //

  HealthBoost(PVector pos) {

    super(pos,45,45);
    
  }
  
  void boost() {
    
    if ( boostFlag == -1 ) ;
    
    else if ( boostFlag == 0 ) {
      
     p1.health += 2; 
     boostFlag = -1;
     isAlive = false;
      
    }
    
  }
  
  void drawMe() {

    pushMatrix();

    translate(pos.x - p1.pos.x - width*translationCounter, pos.y);

    fill(160, 10, 10);
    stroke(160, 10, 10);
    strokeWeight(1);

    quad(-22.5, -12.5, -16.5, -22.5, -6, -22.5, 0, -12.5);
    quad(22.5, -12.5, 16.5, -22.5, 6, -22.5, 0, -12.5);

    triangle(-22.5, -12.5, 22.5, -12.5, 0, 22.5);

    popMatrix();
  }
}
