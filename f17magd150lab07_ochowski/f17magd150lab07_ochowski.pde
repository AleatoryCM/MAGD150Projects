//Bumper Cars

/* @alecOchowski
   Section 03
   Tested & fully operational as of 10/31/2017. A few things could be a little better, such as the collision detection and applied acceleration / velocity, but for a first
   year graphics programming student (never did that in AP) with no physics experience (not even one class...), I did as well as can possibly be expected; though this sketch
   is imperfect, I have implemented every improvement that I know how to.
   Bumper cars, as requested. Thanks for the idea! */
   
//Phase Variables
boolean gameActive = false;                        //Whether or not the game is currently in progress
boolean instructions = false;                      //Whether or not the game is currently on the instructions screen
boolean gameEnd = false;                           //Whether or not the game is currently on the game end screen
//Mechanics Variables
BumperCar player = new BumperCar();                //The player-controlled bumper car
BumperCar[] cars = new BumperCar[11];              //The 11 automated bumper cars
BumperCar[] master = new BumperCar[12];            //All 12 bumper cars
int score = 0;                                     //The player's current score
int highScore = 0;                                 //The player's all-time high score (in the given iteration of the program)
int endTime = 0;                                   //The time at which the game ends
//Start Button Variables
float sbH = 200;                                   //The height of the Start button
float sbW = 700;                                   //The width of the Start button
float sbX = 602;                                   //The x coordinate for the placement of the Start button
float sbY = 750;                                   //The y coordinate for the placement of the Start button
boolean startCD = false;                           //The cooldown between switching colors; enacted to avoid stammer when switching colors
float scdTimestamp;                                //The time when color switching went on cooldown; compared to millis() later
//Color Selector Variables
float cbH = 300;                                   //The height of the Color Selector
float cbW = 300;                                   //The width of the Color Selector
float cbX = 800;                                   //The x coordinate for the placement of the Color Selector
float cbY = 375;                                   //The y coordinate for the placement of the Color Selector
color savedColor;                                  //The color currently saved in the Color Selector; also its displayed color
boolean colorCD = false;                           //The cooldown between switching colors; enacted to avoid stammer when switching colors
float ccdTimestamp = 0;                            //The time when color switching went on cooldown; compared to millis() later
//Logo
float degreeRotation = 0;                          //The number of degrees that the logo is rotated. It whirls around the screen to be more eye-catching
float lScale = 1.0;                                //The current size of the logo; once again, fluctuation drawas attention

void setup(){
  size(1925, 1050);  //As large as could fit on my 17" laptop. Literally like fullscreen mode.
  background(250, 220, 170);
  for(int k = 0; k <= 10; k++){  //Fills the array up with twelve new bumper cars.
    cars[k] = new BumperCar();
  }
  for(int p = 0; p <= 10; p++){
    master[p] = cars[p];
  }
  master[11] = player;
}

void draw(){
  background(250, 220, 170);
  if(instructions){
    player.onPatrol();
    textSize(128);
    fill(85, 55, 5);
    scale(.3, .3);
    text("INSTRUCTIONS:", 25, 125);
    textSize(32);
    fill(150, 120, 70);
    text("Welcome to Bumper Blitz! In this game, you control a bumper car.", 25, 200);
    text("To change the color of your car, click the Color Selector box on the start screen until you find something you like.", 25, 260);
    text("Once you're ready to start, click the 'Start' button.", 25, 320);
    text("When the game begins, use the WASD keys to move your bumper car.", 25, 380);
    text("The object of the game is to get as many points as possible within the time limit.", 25, 440);
    text("Points are awarded based on the amount of time spent in a state of collision with other cars.,", 25, 500);
    text("Thus, more forceful collisions that push a car further will award more points.", 25, 560);
    text("The game will keep track of your score, high score (in the current iteration of the game), and the remaining time.", 25, 620);
    text("When the game ends, you will be able to return to the Start screen; try to beat your best score!", 25, 680);
    text("Press the 'Q' key again to return to the Start screen.", 25, 740);
  }
  else if(gameEnd){
    textSize(128);
    fill(150, 120, 70);
    text("Score: " + score, 675, 200);
    text("High Score: " + highScore, 530, 400);
    rect(sbX, sbY, sbW, sbH);
    textSize(86);
    fill(85, 55, 5);
    text("Return to Start", 645, 880);
    if(mousePressed){
      if(mouseX > sbX && mouseX < sbX + sbW && mouseY > sbY && mouseY < sbY + sbH){
        gameEnd = false;
        startCD = true;
        scdTimestamp = millis() + 200;
      }
    }
  }
  else{
    if(gameActive){      
      player.updateTarget();
      executeAutomatedMovement();
      displayCars();
      collisionDetector();
      textSize(32);
      fill(85, 55, 0);
      text("Score: " + score, 1650, 50);
      text("High Score: " + highScore, 1650, 100);
      text("Time Left: " + formatTime(), 1650, 150);
      if(endTime <= millis()){
        gameEnd();
      }
    }
    else{
      //Title
      textSize(256);
      fill(150, 120, 70);
      text("BUMPER BLITZ", 80, 200);
      //Start Button
      rect(sbX, sbY, sbW, sbH);
      textSize(128);
      fill(85, 55, 5);
      text("Start", 810, 890);
      if(startCD && scdTimestamp + 200 <= millis()){
        startCD = false;
      }
      if(mousePressed){
        if(mouseX > sbX && mouseX < sbX + sbW && mouseY > sbY && mouseY < sbY + sbH && !startCD){
          endTime = millis() + 120500;
          gameActive = true;
          score = 0;
        }
      }
      //Color Selector
      fill(savedColor);
      rect(cbX, cbY, cbW, cbH, 10);
      textSize(64);
      fill(150, 120, 70);
      text("Color Selector", 735, 350);
      if(colorCD && ccdTimestamp + 200 <= millis()){
        colorCD = false;
      }
      if(mousePressed){
        if(mouseX > cbX && mouseX < cbX + cbW && mouseY > cbY && mouseY < cbY + cbH && !colorCD){
          if((int)random(0, 10) == 5){
            savedColor = color((int) random(0, 255));
          }
          else{
            savedColor = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
          }
          ccdTimestamp = millis();
          colorCD = true;
          player.setColor(savedColor);
        }
      }
      //Instructions Text
      textSize(32);
      fill(150, 120, 70);
      text("(For Instructions, Press 'Q')", 743, 1000);
      //Logo     
      degreeRotation += 1;
      rotate(radians(degreeRotation));  
      ellipse(width/2 + 570, height/2 - 45, 200, 200);
      textSize(128);
      fill(85, 55, 5);
      text("BB", width/2 + 500, height /2);
    }
  }
}

void mousePressed(){

}

void keyPressed(){
  if(gameActive){
    player.move();
  }
  else if(key == 'Q' || key == 'q'){
    instructions = !instructions;
  } 
}

//Displays all of the bumper cars.
void displayCars(){
  player.display();
  for(BumperCar bc : cars){
    bc.display();
  }
}
  
//Tells all non-player bumper cars to move randomly.
void executeAutomatedMovement(){
  for(BumperCar bc : cars){
    bc.automatedMovement();
  }
}

//Takes the millisecond timer and turns it into something more helpful to the player.
int formatTime(){
  return((endTime - millis()) / 1000);
}

//Goes through the protocol to end the game.
void gameEnd(){
  gameActive = false;
  gameEnd = true;
  if(score > highScore){
    highScore = score;
  }
}

//Detects any and all collisions between bumper cars.
void collisionDetector(){
  for(int i = 0; i <= 11; i++){
    for(int j = 0; j <= 11; j++){
      if((dist(master[i].getX(), master[i].getY(), master[j].getX(), master[j].getY()) < 150) && (i != j) && !master[i].collisionCD && !master[j].collisionCD){
        master[i].collisionFallout();
        master[j].collisionFallout();
        if(i == 11 || j == 11){
          score += 1;
          player.overrided = true;
          player.overrideTimer = millis() + 100;
        }
      }
    }
  }
}
