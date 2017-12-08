//Kite Hunter

/* @alecOchowski
   Section 03
   Tested & fully operational as of 10/24/2017 */
   
boolean gameActive = false;    //Whether or not the game is currently in progress
boolean instructions = false;  //Whether or not the game is currently on the instructions screen
int score = 0;                 //The player's current score
int highScore = 0;             //The player's all-time high score (in the given iteration of the program)
int escapees = 0;              //The number of escaped kites. If this hits 10, the game ends
int waypoint = 0;              //Used to reconcile time ellapsed & speed for multiple rounds
Storm player;                  //The storm controlled by the player
Kite kite1;                    //The first kite
Kite kite2;                    //The second kite
Kite kite3;                    //The third kite
float sbX = 500;               //The x coordinate for the placement of the Start button
float sbY  = 350;              //The y coordinate for the placement of the Start button
float sbH = 300;               //The height of the Start button
float sbW = 500;               //The width of the Start button

void setup(){
  size(1500, 1000);
  //Create player object
  player = new Storm();
  //Create kites
  kite1 = new Kite();
  kite2 = new Kite();
  kite3 = new Kite();
}

void draw(){
  if(gameActive){
    if(escapees >= 10){
      endGame();
    }
    //Sky
    background(0, 20, 90);
    //Grass
    strokeWeight(1);
    fill(0, 50, 0);
    rect(0, 900, 1500, 100);
    //Storm
    player.form();
  }
  else if(instructions){
    background(0, 150, 220);
    kite1.struck();
    kite2.struck();
    kite3.struck();
    textSize(24);
    text("Welcome to KITE HUNTER!", 50, 100);
    text("Move your storm cloud with the A & D keys.", 50, 200);
    text("Use the S key or the mouse to initiate a lightning strike directly below your storm cloud.", 50, 300);
    text("It is your goal to strike as many rogue kites as you can; they are worth 10 points apiece!", 50, 400);
    text("If 10 kites escape your wrath, the game ends.", 50, 500);
    text("Be careful! As time goes on, the storm increases in intensity, and the kites will begin to move faster!", 50, 600);
    text("Click the S key to exit this screen.", 50, 700);
  }
  else{
    //Sky
    background(0, 150, 220);
    //Grass
    strokeWeight(1);
    fill(0, 180, 0);
    rect(0, 900, 1500, 100);
    //Sun
    fill(200, 200, 0);
    ellipse(1400, 100, 200, 200);
    //Title & Information
    textSize(230);
    fill(0);
    text("KITE HUNTER", 10, 300);
    textSize(32);
    text("Press the 'W' Key for Instructions", 500, 750);
    //Start Button
    fill(0);
    rect(sbX, sbY, sbW, sbH);
    fill(200, 200, 0);
    textSize(128);
    text("START", 550, 550);
    if(mousePressed){
      if(mouseX > sbX && mouseX < sbX + sbW && mouseY > sbY && mouseY < sbY + sbH){
        waypoint = millis();
        gameActive = true;
      }
    }
    if(keyPressed && (key == 'w' || key == 'W')){
      instructions = true;
    }
  }
  //Kites
  manageKites();
  //Stats Display
  displayStats();
}

void mousePressed(){
  if(gameActive){
    player.strike();
  }
}

void keyPressed(){
  if(gameActive){
    player.move();
  } 
  else if(instructions && (key == 's' || key == 'S')){
    instructions = false;
    kite1.reveal();
    kite2.reveal();
    kite3.reveal();
  }
}

//A method for displaying the player's statistics.
void displayStats(){
  textSize(32);
  fill(250);
  text("Score: " + score, 1200, 30);
  text("High Score: " + highScore, 1200, 70);
  text("Escapees: " + escapees, 1200, 110);
}

//A method for managing all active kites at once.
void manageKites(){
  if(gameActive){
    kite1.move();
    kite2.move();
    kite3.move();
  }
  kite1.form();
  kite2.form();
  kite3.form(); 
}

//This method contains the procedure for returning the game to its start screen once the game has ended.
void endGame(){
  player.home();
  gameActive = false;
  kite1.reveal();
  kite2.reveal();
  kite3.reveal();
  if(score > highScore){
    highScore = score;
  }
  score = 0;
  escapees = 0;
}
