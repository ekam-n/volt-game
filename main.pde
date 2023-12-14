import ddf.minim.*;
import controlP5.*;

Minim minim;
ControlP5 controlP5;

// different sound effects
AudioPlayer music;
AudioPlayer jump;
AudioPlayer slash;
AudioPlayer special;
AudioPlayer hit;

final String MUSIC = "Goblins_Dance_(Battle).wav";
final String JUMP = "jump.wav";
final String SLASH = "slash.wav";
final String SPECIAL = "18_Thunder_02.wav";
final String HIT = "Hit damage 1.wav";

// different buttons
Button play;
Button howTo;
Button back;
Button retry;
Button cont;
Button creds;

Player1 p1;

static final int STATE_START = 0; // game state when on start menu.
static final int STATE_HOWTO = 1; // game state when showing how to play
static final int STATE_BACKSTORY = 2; // game state when showing backstory
static final int STATE_LEVEL1 = 3; // game state when player is playing level 1
static final int STATE_LEVEL2 = 4; // game state when player is playing level 2
static final int STATE_LEVEL3 = 5; // game state when player is playing level 3
static final int STATE_DEAD =7; // game state when player dies
static final int STATE_END = 6; // game state when game over
static final int STATE_CREDITS = 8; // game state when showing credits

int translationCounter;

int gameState;

// these are just here to hold each levels properties
Level1 level1;
Level2 level2;
Level3 level3;

// this is the level variable we will use
Level lv;

void setup() {

  size(1400, 800);

  minim = new Minim(this);
  controlP5 = new ControlP5(this);

  music = minim.loadFile(MUSIC);
  music.setGain(10);
  jump = minim.loadFile(JUMP);
  jump.setGain(-20);
  slash = minim.loadFile(SLASH);
  special = minim.loadFile(SPECIAL);
  hit = minim.loadFile(HIT);
  hit.setGain(-20);

  music.loop();

  PFont font = loadFont("PublicPixel-48.vlw");
  textFont(font);

  // setting up all the buttons
  play = controlP5.addButton("Play", 0, width/2-460, height/2, 350, 100);
  play.getCaptionLabel().setFont(font);
  play.getCaptionLabel().setSize(30);
  play.getCaptionLabel().setColor(0);
  play.setColorForeground(color(0, 255, 220));
  play.setColorBackground(color(255, 255, 0));
  //play.hide();

  cont = controlP5.addButton("Continue", 0, width/2+155, height/2 + 150, 350, 100);
  cont.getCaptionLabel().setFont(font);
  cont.getCaptionLabel().setSize(30);
  cont.getCaptionLabel().setColor(0);
  cont.setColorForeground(color(0, 255, 220));
  cont.setColorBackground(color(255, 255, 0));
  cont.hide();

  creds = controlP5.addButton("Credits", 0, width/2+35, height/2 + 150, 350, 100);
  creds.getCaptionLabel().setFont(font);
  creds.getCaptionLabel().setSize(30);
  creds.getCaptionLabel().setColor(0);
  creds.setColorForeground(color(0, 255, 220));
  creds.setColorBackground(color(255, 255, 0));
  creds.hide();

  howTo = controlP5.addButton("How To", 0, width/2+100, height/2, 350, 100);
  howTo.getCaptionLabel().setFont(font);
  howTo.getCaptionLabel().setSize(30);
  howTo.getCaptionLabel().setColor(0);
  howTo.setColorForeground(color(0, 255, 220));
  howTo.setColorBackground(color(255, 255, 0));
  //howTo.hide();

  back = controlP5.addButton("Back", 0, width/2-500, height/2 +180, 350, 100);
  back.getCaptionLabel().setFont(font);
  back.getCaptionLabel().setSize(30);
  back.getCaptionLabel().setColor(0);
  back.setColorForeground(color(0, 255, 220));
  back.setColorBackground(color(255, 255, 0));
  back.hide();

  retry = controlP5.addButton("Retry", 0, width/2-500, height/2 +180, 350, 100);
  retry.getCaptionLabel().setFont(font);
  retry.getCaptionLabel().setSize(30);
  retry.getCaptionLabel().setColor(0);
  retry.setColorForeground(color(0, 255, 220));
  retry.setColorBackground(color(255, 255, 0));
  retry.hide();

  p1 = new Player1(new PVector( 20, 700  ) );

  level1 = new Level1();
  level2 = new Level2();
  level3 = new Level3();

  //gameState = STATE_LEVEL3;
  translationCounter = 0;

  lv = new Level();
}

void draw() {

  background(0);

  switch(gameState) {

  case STATE_START:
    startScreen();
    break;

  case STATE_HOWTO:
    howToScreen();
    break;

  case STATE_BACKSTORY:
    backstoryScreen();
    break;

  case STATE_LEVEL1:
    lv.chooseLevel(1);
    lv.currLevelNum = 1;
    lv.currLevel.update();
    drawHUD();
    p1.update();
    break;

  case STATE_LEVEL2:
    lv.chooseLevel(2);
    lv.currLevelNum = 2;
    lv.currLevel.update();
    drawHUD();
    p1.update();
    break;

  case STATE_LEVEL3:
    lv.chooseLevel(3);
    lv.currLevel.update();
    drawHUD();
    p1.update();
    break;

  case STATE_DEAD:
    deathScreen();
    break;

  case STATE_END:
    endScreen();
    creds.show();
    break;

  case STATE_CREDITS:
    creditsScreen();
    creds.hide();
    break;
  }
}

// draw start screen
void startScreen() {

  textSize(100);
  fill(255, 255, 0);
  text("VOLT LEGACY", width/2 - 525, height/2-100 );
}

// draw howTo screen
void howToScreen() {

  pushMatrix();
  translate(0, 50);

  noFill();
  stroke(255, 255, 0);
  strokeWeight(5);
  rect(width/2 - 500, height/2 - 300, 1000, 380);
  textSize(30);
  fill(255, 255, 0);
  text("USE A & D TO MOVE LEFT AND RIGHT", width/2-480, height/2-250);
  text("USE W TO JUMP", width/2-480, height/2-200);
  text("USE S TO CROUCH", width/2-480, height/2-150);
  text("USE B FOR SWORD ATTACK", width/2-480, height/2-100);
  text("USE M FOR LIGHTNING ATTACK", width/2-480, height/2-50);
  text("BEAT ALL 3 LEVELS AND YOU WIN!", width/2-480, height/2-0);
  text("HAVE FUN!", width/2-480, height/2+50);
  popMatrix();
}

void backstoryScreen() {

  pushMatrix();
  translate(0, 50);

  noFill();
  stroke(255, 255, 0);
  strokeWeight(5);
  rect(width/2 - 500, height/2 - 300, 1000, 380);
  textSize(20);
  fill(255, 255, 0);
  text("YOU FIND YOURSELF IN A FOREIGN LAND...", width/2-480, height/2-250);
  text("SURROUNDED BY EVIL MONSTERS!", width/2-480, height/2-200);
  text("BUT YOU'RE NOT HELPLESS...", width/2-480, height/2-150);
  text("YOU HAVE THE POWER OF LIGHTNING!", width/2-480, height/2-100);
  text("USE YOUR WIT AND SKILL TO FIGHT YOUR WAY OUT!", width/2-480, height/2-50);
  text("BUT IT WONT BE EASY, THE ENEMIES ARE FIERCE!", width/2-480, height/2-0);
  text("GOOD LUCK!", width/2-480, height/2+50);
  popMatrix();
}

// draw death screen
void deathScreen() {

  fill(140, 10, 25);
  textSize(100);
  text("YOU DIED!", width/2 - 440, height/2);
}

void endScreen() {

  fill(255, 255, 0);
  textSize(100);
  text("YOU WON!", width/2 - 380, height/2);
}

void creditsScreen() {

  pushMatrix();
  translate(0, 50);

  noFill();
  stroke(255, 255, 0);
  strokeWeight(5);
  rect(width/2 - 500, height/2 - 300, 1000, 240);
  textSize(40);
  fill(255, 255, 0);
  text("CREDIT TO", width/2-500, height/2-350);

  textSize(20);
  text("ZEGGYGAMES ON ITCH.IO FOR BASE CHARACTER MODEL", width/2-480, height/2-250);
  text("LEOHPAZ ON ITCH.IO FOR SOUND EFFECTS", width/2-480, height/2-200);
  text("JDWASABI ON ITCH.IO FOR SOUND EFFECTS", width/2-480, height/2-150);
  text("LEOHPAZ ON ITCH.IO FOR BACKGROUND MUSIC", width/2-480, height/2-100);
  
  textSize(50);
  text("THANKS FOR PLAYING!", width/2 - 470, height / 2 + 200);

  popMatrix();
}

// check button events
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() =="Play") {
    gameState = STATE_BACKSTORY;
    controlP5.getController("Play").hide();
    controlP5.getController("How To").hide();
    controlP5.getController("Continue").show();
  }

  if (theEvent.getController().getName() =="Continue") {
    gameState = STATE_LEVEL1;
    controlP5.getController("Continue").hide();
  }

  if (theEvent.getController().getName() == "How To") {
    gameState = STATE_HOWTO;
    controlP5.getController("Play").hide();
    controlP5.getController("How To").hide();
    controlP5.getController("Back").show();
  }

  if (theEvent.getController().getName() == "Credits") {
    gameState = STATE_CREDITS;
    controlP5.getController("Credits").hide();
  }

  if (theEvent.getController().getName() == "Back") {
    gameState = STATE_START;
    controlP5.getController("Play").show();
    controlP5.getController("How To").show();
    controlP5.getController("Back").hide();
  }

  if (theEvent.getController().getName() == "Retry") {

    // check which level we're in, reset that level
    switch(lv.currLevelNum) {

    case 1:
      level1 = new Level1(); // global variable level1
      gameState = STATE_LEVEL1;
      break;

    case 2:
      level2 = new Level2(); //global variable level2
      gameState = STATE_LEVEL2;
      //println("reset");
      break;

    case 3:
      level3 = new Level3();
      gameState = STATE_LEVEL3;
      break;
    }

    lv.chooseLevel(lv.currLevelNum);
    p1.health = 10;
    p1.isAlive = true;
    p1.pos.x = 20;
    p1.pos.y = 700;
    p1.vel.set(0, 0);
    p1.hurtTimer = -1;
    p1.basicAttackTimer = -1;
    p1.punchDisplayIndex = 0;
    p1.skill1Timer = -1;
    p1.attkDisplayIndex = 0;
    p1.facingRight = true;
    translationCounter = 0;
    retry.hide();
  }
}

// draw HUD
void drawHUD() {

  fill(255);
  textSize(30);
  text("Level "+lv.currLevelNum+"\nHealth "+p1.health, 25, 50);
}
