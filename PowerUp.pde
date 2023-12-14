class PowerUp { //
  
  boolean isAlive;
  float wdth;
  float hght;
  PVector pos;
  int boostTimer;
  int boostFlag;

  PowerUp(PVector pos, float wdth, float hght) {

    this.pos = pos;
    isAlive = true;
    this.wdth = wdth;
    this.hght = hght;
    boostFlag = -1;
    boostTimer = -1;
    
  }

  void update() {
    
    if (hit()) boostFlag = 0;

    if ( boostFlag == 0 ) boost();
    if (isAlive )drawMe();
    else if ( !isAlive && boostTimer == -1) removeMe();
    //println(boostTimer);
    
  }
  
  void boost() {
    
  }
  
  void drawMe() {
    
    
  }
  
  void removeMe() {
    
    lv.currLevel.boosts.remove(this);
    //println("remove");
  }
  
  boolean hit() {
    
    if ( abs(p1.pos.x - (pos.x - p1.pos.x - width*translationCounter)) < wdth/2 + p1.wdth/2 
        && abs(p1.pos.y - pos.y) < p1.hght/2 + hght/2) return true;
    
    else return false;
  
  }
  
}
