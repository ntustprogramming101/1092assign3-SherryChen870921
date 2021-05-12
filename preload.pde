final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = GAME_START;

final int BOTTON_NORMAL = 0;
final int BOTTON_DOWN = 1;
final int BOTTON_LEFT = 2;
final int BOTTON_RIGHT = 3;
int bottonState = BOTTON_NORMAL;

final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final float LIFE_MAX = 5;
final float LIFE_Y = 10;
final float LIFE_X_START = 10;

final float GROUNDHOG_W = 80;
final float GROUNDHOG_H = 80;
final float GROUNDHOG_SPEED = round(80/15);

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage bg, life;

PImage soil0, soil1, soil2, soil3, soil4, soil5;
float soilY = 160;

PImage stone1, stone2;

int stoneX = 0;
float stoneY = 0;

float groundhogX = 80*4;
float groundhogY = 80;
float groundhog_count;

float screen_Y_Offset;
float screen_Y_Count;

int soils = 0;

int lifeX, lifeY;

boolean downPressed, leftPressed, rightPressed = false;


// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() { //480
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life = loadImage("img/life.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  
  groundhogX = 80*4;
  groundhogY =80;
  groundhog_count = 0;
  
  screen_Y_Count = 0;
  screen_Y_Offset = 0; 
  
  bottonState = BOTTON_NORMAL;
  
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(width - 50, 50, 120, 120);
    
    
// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int x=0; x<width; x+=80){
      for(float y=soilY; y<soilY+320; y+=80){
        image(soil0, x, y);
      }
      for(float y=soilY+320; y<soilY+(2*320); y+=80){
        image(soil1, x, y);
      }
      for(float y=soilY+(2*320); y<soilY+(3*320); y+=80){
        image(soil2, x, y);
      }
      for(float y=soilY+(3*320); y<soilY+(4*320); y+=80){
        image(soil3, x, y);
      }
      for(float y=soilY+(4*320); y<soilY+(5*320); y+=80){
        image(soil4, x, y);
      }
      for(float y=soilY+(5*320); y<soilY+(6*320); y+=80){
        image(soil5, x, y);
      }
    }
    
      
    //Stone 1
    for(int i=0; i<8; i++){
        stoneX = i*80;
        stoneY = soilY+i*80;
        image(stone1, stoneX, stoneY);
    }
    
    //Stone 2
    for(int i=0; i<8; i++){
      if(i==2 || i==6){
      stoneX = i*80;
        for(int j=0; j<8; j++){
          if(j==0 || j==3 || j==4 || j==7){
            stoneY = soilY+(2*320)+j*80;
            image(stone1, -80+stoneX, stoneY);
            image(stone1, stoneX, stoneY);
          }
        }
      }
    }
    
    for(int i=0; i<8; i++){
      if(i==0 || i==3 || i==4 || i==7){
      stoneX = i*80;
        for(int j=0; j<8; j++){
          if(j==2 || j==6){
            stoneY = soilY+(2*320)+j*80;
            image(stone1, stoneX, stoneY-80);
            image(stone1, stoneX, stoneY);
          }
        }
      }
    }
    
    //Stone 3
    for(int i=0; i<8; i++){
      stoneX = -480+(i*80);
      stoneY = soilY+(6*320)-80-i*80;
      image(stone1, stoneX, stoneY);
      image(stone1, stoneX+80, stoneY);
      image(stone1, stoneX+240, stoneY);
      image(stone1, stoneX+320, stoneY);
      image(stone1, stoneX+480, stoneY);
      image(stone1, stoneX+560, stoneY);
      image(stone1, stoneX+720, stoneY);
      image(stone1, stoneX+800, stoneY);
      image(stone1, stoneX+960, stoneY);
      image(stone1, stoneX+1040, stoneY);
      image(stone2, stoneX+80, stoneY);
      image(stone2, stoneX+320, stoneY);
      image(stone2, stoneX+560, stoneY);
      image(stone2, stoneX+800, stoneY);
      image(stone2, stoneX+1040, stoneY);
      
    }
    
   // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, soilY - 15, width, 15);

    
    // Life
    for(int i = 0; i < playerHealth ; i++){
      image(life, LIFE_X_START + i * 70, LIFE_Y);
    }
    
    
    // Groundhog Move
    if(bottonState == BOTTON_NORMAL){
      
      groundhog_count = 0;
      image(groundhogIdle, groundhogX, groundhogY);
      
    }else{
      
      if(groundhog_count < 80){
        
        groundhog_count += GROUNDHOG_SPEED;
        
        if(bottonState == BOTTON_DOWN){
            
          if(screen_Y_Offset > 1600){
            groundhogY += GROUNDHOG_SPEED;
            // Border Range
            if(groundhogY + GROUNDHOG_H > height){
              groundhogY = height - GROUNDHOG_H;
            }
          }
          
          image(groundhogDown, groundhogX, groundhogY);
          
          }else if(bottonState == BOTTON_LEFT){
            
            groundhogX -= GROUNDHOG_SPEED;
            // Border Range
            if(groundhogX < 0){
                groundhogX = 0;
              }
            image(groundhogLeft, groundhogX, groundhogY);
            
          }else if(bottonState == BOTTON_RIGHT){
            
            groundhogX += GROUNDHOG_SPEED;
            // Border Range
            if(groundhogX + GROUNDHOG_W > width){
              groundhogX = width - GROUNDHOG_W;
            }
            image(groundhogRight, groundhogX, groundhogY);
          }  
          
        }else{
          
          if(downPressed || leftPressed || rightPressed){
            
            downPressed = false;
            leftPressed = false;
            rightPressed = false;
            
            image(groundhogIdle, groundhogX, groundhogY);
            
          }else{
            
            groundhog_count = 0;
            image(groundhogIdle, groundhogX, groundhogY);
            bottonState = BOTTON_NORMAL;
            
          }
        }
    }
     
    break;

    case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
        // Initialize Game
        playerHealth = 2;
      }
    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
    // Moving 
    if(key == CODED){
      if(bottonState == BOTTON_NORMAL
      && gameState == GAME_RUN){  
        switch(keyCode){
          case DOWN:
            bottonState = BOTTON_DOWN;
            downPressed = true;
            
            if(screen_Y_Offset < 1600 + 80*2){
              screen_Y_Offset += 80;
            }
            
            break;
          case LEFT:
            bottonState = BOTTON_LEFT;
            leftPressed = true;
            break;
          case RIGHT:
            bottonState = BOTTON_RIGHT;
            rightPressed = true;
            break;   
        }
      }    
    }     
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
  if(key == CODED){
      switch(keyCode){
        case DOWN:
          downPressed = false;
          break;
        case LEFT:
          leftPressed = false;
          break;
        case RIGHT:
          rightPressed = false;
          break; 
      }
  }
}
