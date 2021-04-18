PImage  bg, title, gameover, startHovered, startNormal, 
  groundhogIdle, groundhogLeft, groundhogRight, life, 
  restartHovered, restartNormal, soil, soldier, cabbage;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;

final int game_start = 0;
final int game_run = 1;
final int game_lose = 2;

final int startButton_TOP = 360;
final int startButton_BOTTOM = 420;
final int startButton_LEFT = 248;
final int startButton_RIGHT = 392;

final int restartButton_TOP = 360;
final int restartButton_BOTTOM = 420;
final int restartButton_LEFT = 248;
final int restartButton_RIGHT = 392;

int gameState = game_start;
int
  groundHeight = 80, 
  grassHeight = 15, 
  block = 80, 
  soldierX, 
  soldierY, 
  soldierSpeed = 5, 
  ghog_locX, 
  ghog_locY, 

  lifeNum = 2;

float 
  cabbageX, cabbageY;

void setup() {
  size(640, 480, P2D);
  bg = loadImage("bg.jpg");
  title = loadImage("title.jpg");
  gameover = loadImage("gameover.jpg");
  startHovered = loadImage("startHovered.png");
  startNormal = loadImage("startNormal.png");
  groundhogIdle = loadImage("groundhogIdle.png");
  groundhogLeft = loadImage("groundhogLeft.png");
  groundhogRight = loadImage("groundhogRight.png");
  life = loadImage("life.png");
  restartHovered = loadImage("restartHovered.png");
  restartNormal = loadImage("restartNormal.png");
  soil = loadImage("soil.png");
  soldier = loadImage("soldier.png");
  cabbage = loadImage("cabbage.png");

  ghog_locX = groundHeight*4;
  ghog_locY = groundHeight;

  soldierX = groundHeight*floor(random(8.99));
  soldierY = groundHeight*2 + groundHeight*floor(random(3.99));

  cabbageX = groundHeight*floor(random(3.99));
  cabbageY = groundHeight*2 + groundHeight*floor(random(3.99));
}

void draw() {
  // Switch Game State
  switch(gameState) {
  case game_start:
    image(title, 0, 0);
    if (mouseX > startButton_LEFT && mouseX < startButton_RIGHT
      && mouseY > startButton_TOP && mouseY < startButton_BOTTOM) {
      image(startHovered, 248, 360);
      if (mousePressed) {
        gameState = game_run;
      }
    } else {
      image(startNormal, 248, 360);
    }
    break;


    // Game Run
  case game_run:
    background(0);
    image(bg, 0, 0);
    fill(253, 184, 19);
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(width-50, 50, 120, 120);
    fill(124, 204, 25);
    noStroke();
    rect(0, groundHeight*2-grassHeight, width, grassHeight);
    image(soil, 0, 160);

    //soldier move around
    image(soldier, soldierX, soldierY);

    soldierX += soldierSpeed;
    if (soldierX>width) soldierX = -50;

    //cabbage
    image(cabbage, cabbageX, cabbageY);

    //life
    for (int x = 0; x < lifeNum; x++) {
      image(life, 10 + x*70, 10);
    }
    //groundHog
    image(groundhogIdle, ghog_locX, ghog_locY);

    if (
      ghog_locX < soldierX+block && 
      ghog_locX+block > soldierX &&
      ghog_locY < soldierY+block &&
      ghog_locY+block > soldierY) {
      ghog_locX = groundHeight*4;
      ghog_locY = groundHeight;
      lifeNum --;
      if (lifeNum == 0) {
        gameState = game_lose;
      }
    }

    if (
      ghog_locX < cabbageX+block && 
      ghog_locX+block > cabbageX &&
      ghog_locY < cabbageY+block &&
      ghog_locY+block > cabbageY) {
      lifeNum ++;
      cabbageX = -100;
      cabbageY = -100;
    }
    break;


    // Game Lose
  case game_lose:
    image(gameover, 0, 0);
    lifeNum = 2;
    if (mouseX > restartButton_LEFT && mouseX < restartButton_RIGHT
      && mouseY > restartButton_TOP && mouseY < restartButton_BOTTOM) {
      image(restartHovered, 248, 360);
      if (mousePressed) {
        gameState = game_run;

        cabbageX = groundHeight*floor(random(3.99));
        cabbageY = groundHeight*2 + groundHeight*floor(random(3.99));

        soldierX = groundHeight*floor(random(8.99));
        soldierY = groundHeight*2 + groundHeight*floor(random(3.99));
      }
    } else {
      image(restartNormal, 248, 360);
    }
    break;
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    upPressed = true;
    ghog_locY -= groundHeight;
    if (ghog_locY < 0) ghog_locY = 0;
    break;
  case DOWN:
    downPressed = true;
    ghog_locY += groundHeight;
    if (ghog_locY + block > height) ghog_locY = height - block;
    break;
  case RIGHT: 
    rightPressed = true;
    ghog_locX += groundHeight;
    if (ghog_locX + block > width) ghog_locX = width - block;
    break;
  case LEFT: 
    leftPressed = false;
    ghog_locX -= groundHeight;
    if (ghog_locX < 0) ghog_locX = 0;
    break;
  }
}


void keyReleased() {
  switch(keyCode) {
  case UP:
    upPressed = true;
    break;
  case DOWN:
    downPressed = true;
    break;
  case RIGHT:
    rightPressed = true;
    break;
  case LEFT: 
    leftPressed = false;
    break;
  }
}
