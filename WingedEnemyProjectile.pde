class WingedEnemyProjectile extends EnemyProjectile {
  
  WingedEnemyProjectile(PVector pos) {
    
   super(pos,new PVector()); 
   
   
   float angle = atan( (pos.y - (p1.pos.y-p1.hght/2)) / ((pos.x) - (p1.pos.x)) );

    if ( pos.x > p1.pos.x && pos.y < (p1.pos.y-p1.hght/2) ) angle -= PI;

    else if ( pos.y > (p1.pos.y-p1.hght/2) && pos.x > p1.pos.x ) angle += PI;

    PVector pos_ = PVector.fromAngle(angle);
    
    vel.set(pos_.mult(10));

    //projectiles.add( new Boss_Projectile( new PVector(pos.x, pos.y), pos_.mult(10) ) );
    
  }
  
}
