final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int groundhoglife = 2;
int soilX;
int soilY;
int stoneX;
int stoneY;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float groundhogX = 320;
float groundhogY = 80;
float groundhog_W = 80;
float groundhog_H = 80;
float groundhogSpeed = 80;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,life,soil0,soil1,groundhogIdle,stone1;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
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
  life = loadImage("img/life.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  stone1 = loadImage("img/stone1.png");
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

    //groundhog move
    if(downPressed){
        if(groundhogY >= 400){
          groundhogY = 400;
        }else{
          groundhogY += 80;
          downPressed = false;
        }
      }
      
      if(leftPressed){
        if(groundhogX <= 0){
          groundhogX = 0;
        }else{
          groundhogX -= 80;
          leftPressed = false;
        }
      }
      
      if(rightPressed){
        if(groundhogX >= 560){
          groundhogX = 560;
        }else{
          groundhogX += 80;
          rightPressed = false;
        }
      }

		// Background
		image(bg, 0, 0);


    //life
    for(int i=0;i<groundhoglife;i++){
      image(life,10+i*70,10);
    }
    
		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);


	// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int x=0; x<8; x++){
      for(int y=0; y<4; y++){
        image(soil0,x*80,160+y*80);
      }
    }
   
    //groundhog down + soil up 1
      if(groundhogY > 80 ){
        for(int x=0; x<8; x++){
        
        //grass up  
        fill(124, 204, 25);
        noStroke();
        rect(0, 80 - GRASS_HEIGHT, width, GRASS_HEIGHT);  
        
        // soil up  
        image(soil0,x*80,80);
        image(soil1,x*80,400);
    }
  }
  
    //groundhog down + soil up 2
    if(groundhogY>160){
        for(int x=0; x<8; x++){
        for(int y=0; y<4; y++){
          
          // soil up 
          image(soil0,x*80,0);
          image(soil1,x*80,320+y*80);
          }
        }
    }
    
    //groundhog down + soil up 3
    if(groundhogY>240){
        for(int x=0; x<8; x++){
        for(int y=0; y<4; y++){
          
          // soil up 
          image(soil0,x*80,0);
          image(soil1,x*80,240+y*80);
          }
        }
    }
    
    //groundhog down + soil up 4
    if(groundhogY>320){
        for(int x=0; x<8; x++){
        for(int y=0; y<4; y++){
          
          // soil up 
          image(soil0,x*80,0);
          image(soil1,x*80,160+y*80);
          }
        }
    }
    
    //stone1
    if(groundhogY <= 80){
    image(stone1,0,160);
    image(stone1,80,240);
    image(stone1,160,320);
    image(stone1,240,400);
    }
    
    //stone1-down1
    if(groundhogY == 160){
    image(stone1,0,80);
    image(stone1,80,160);
    image(stone1,160,240);
    image(stone1,240,320);
    image(stone1,320,400);
    }
    
     //stone1-down2
    if(groundhogY == 240){
    image(stone1,0,0);
    image(stone1,80,80);
    image(stone1,160,160);
    image(stone1,240,240);
    image(stone1,320,320);
    image(stone1,400,400);
    }
    
    //stone1-down3
    if(groundhogY == 320){
    image(stone1,80,0);
    image(stone1,160,80);
    image(stone1,240,160);
    image(stone1,320,240);
    image(stone1,400,320);
    image(stone1,480,400);
    }
    
    //stone1-down4
    if(groundhogY == 400){
    image(stone1,160,0);
    image(stone1,240,80);
    image(stone1,320,160);
    image(stone1,400,240);
    image(stone1,480,320);
    image(stone1,560,400);
    }
    
    //groundhogIdle 
    image(groundhogIdle,groundhogX,groundhogY,groundhog_W,groundhog_H);


    //groundhog X,Y position
    if(groundhogX > width-80){
    groundhogX = width-80;
    }
    if(groundhogX <0){
    groundhogX=0;
    }
    if(groundhogY >height-80){
    groundhogY=height-80;
    }
    if(groundhogY <80){
    groundhogY = 80;
    }



		// Player

		// Health UI

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
				// Remember to initialize the game here!
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
	// Add your moving input code here
  //groundhog move
 if (key == CODED)
  {
    switch(keyCode)
    {
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed= true;
        break;
    
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
   if (key == CODED)
  {
    switch(keyCode)
    {
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed= false;
        break;
    }
  }
}
