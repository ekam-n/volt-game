PVector rightForce = new PVector(1, 0);
PVector leftForce = new PVector(-1, 0);

boolean canJump = true;



void keyPressed() {

  //p1 movement
  if ( (key == 'a' || key == 'A') && !p1.crouch ) p1.left = true;
  if ( (key == 'd' || key == 'D') && !p1.crouch ) p1.right = true;
  if ( (key == 'w' || key == 'W') && !p1.jumping && !p1.crouch && canJump && p1.isAlive) {

    p1.jump( new PVector(0, -35) );
    canJump = false;
    jump.play(0);
    //p1.isJumping = true;
    
  }
  if ( (key == 's' || key == 'S') && !p1.jumping ) {

    p1.crouch = true;
    p1.left = false;
    p1.right = false;
    p1.vel.x = 0;
    p1.basicAttackTimer = -1;
    p1.attkDisplayIndex = 0;
    p1.punchDisplayIndex = 0;
    p1.skill1Timer = -1;
  }

  //p1 attacks
  if ( (key == 'b' || key == 'B') && p1.basicAttackTimer == -1 && !p1.crouch && p1.isAlive ) {

    p1.basicAttackTimer = 20;
    slash.play(0);
    if (!p1.jumping) {
      p1.left = false;
      p1.right = false;
    }
    //p1.attacking = true;
  }

  if ( (key == 'm' || key == 'M' ) && p1.skill1Timer == -1 && !p1.crouch && p1.skill1Unlock && p1.isAlive ) {

    p1.skill1Timer = 30;
    special.play(0);
    if (!p1.jumping) {
      p1.left = false;
      p1.right = false;
    }
    //p1.attacking = true;
  }


}

void keyReleased() {

  //p1 movement
  if ( (key == 'a' || key == 'A') ) p1.left = false;
  if ( (key == 'd' || key == 'D') ) p1.right = false;
  if ( (key == 'w' || key == 'W') ) canJump = true;
  if ( (key == 's' || key == 'S') ) p1.crouch = false;


}
