//Oceans of Pizza

/* @alecOchowski
   Section 03
   Tested & fully operational as of 10/10/2017 */

/* Instructions: Move the boat with WASD. Click on an object to fire your tomato sauce laser at it.
   Shooting a pepperoni scores 10 points; deflecting the sausage scores 1.
   Avoid colliding with the sausage; if you do, your ship will sink! */

public int score = 0;  //Pretty self-explanatory; it's a quantification of the player's performance
public int highScore = 0;  //The highest score that the player has achieved
public int rectAurek = 500;  //The alpha coordinate for determining the size of the boat's hull and the relative positions of all other boat components
public int rectBesh = 500;  //The beta coordinate for determining the size of the boat's hull and the relative positions of all other boat components
public int rectLength = 150;  //The length of the boat
public int rectHeight = 50;  //The height of the boat
public int waveStart = 0;  //The horizontal position of the cheesey waves
public int waveHeight = 0;  //The vertical position of the cheesey waves
public float pepAX = random(0, 1000);  //The X coordinate for pepperoni A
public float pepAY = random(0, 1000);  //The Y coordinate for pepperoni A
public float pepBX = random(0, 1000);  //The X coordinate for pepperoni B
public float pepBY = random(0, 1000);  //The Y coordinate for pepperoni B
public float pepCX = random(0, 1000);  //The X coordinate for pepperoni C
public float pepCY = random(0, 1000);  //The Y coordinate for pepperoni C
public int pepAcd = 0;  //The respawn cooldown for pepperoni A
public int pepBcd = 0;  //The respawn cooldown for pepperoni B
public int pepCcd = 0;  //The respawn cooldown for pepperoni C
public int sauX = 0;  //The X coordinate for the sausage
public int sauY = 0;  //The Y coordinate for the sausage
public boolean xDir = true;  //Whether the sausage is moving left or right
public boolean yDir = true;  //Whether the sausage is moving up or down
public boolean showBoat = true; //Whether or not the boast is visible
public boolean showPepA = true; //Whether or not the first pepperoni is visible
public boolean showPepB = true; //Whether or not the second pepperoni is visible
public boolean showPepC = true; //Whether or not the third pepperoni is visible
public boolean showSausage = true; //Whether or not the sausage is visible

void setup(){
  background(195, 195, 100);
  size(1000,1000);
  score = 0;
  rectAurek = 500;
  rectBesh = 500;
  showBoat = true;
  showPepA = true;
  showPepB = true;
  showPepC = true;
}

void draw(){
  //The Cheese Sea
  background(195, 195, 100);
  int modifier = 0;
  for(int i = 0; i < 11; i++){
    noFill();
    stroke(255, 60, 10);
    strokeWeight(1);
    beginShape();
    curveVertex(waveStart + modifier, waveHeight);
    curveVertex(waveStart + 20 + modifier, waveHeight + 10);
    curveVertex(waveStart + 40 + modifier, waveHeight);
    curveVertex(waveStart + 60 + modifier, waveHeight - 10);
    curveVertex(waveStart + 80 + modifier, waveHeight);
    curveVertex(waveStart + 100 + modifier, waveHeight + 10);
    curveVertex(waveStart + 120 + modifier, waveHeight);
    curveVertex(waveStart + 140 + modifier, waveHeight - 10);
    endShape();
    waveHeight+=100;
    modifier+=40;
  }
  waveHeight = 0;
  waveStart+=10;
  if(waveStart > 1000){
    waveStart = 0;
  }
  //Pepperoni
  fill(175, 0, 0);
  stroke(0);
  strokeWeight(1);
  if(showPepA){
    ellipse(pepAX, pepAY, 200, 200);
  }
  else{
    if(pepAcd <= millis()){
      pepAX = random(0, 1000);
      pepAY = random(0, 1000);
      showPepA = true;
    }
  }
  if(showPepB){
    ellipse(pepBX, pepBY, 200, 200);
  }
  else{
    if(pepBcd <= millis()){
      pepBX = random(0, 1000);
      pepBY = random(0, 1000);
      showPepB = true;
    }
  }
  if(showPepC){
    ellipse(pepCX, pepCY, 200, 200);
  }
  else{
    if(pepCcd <= millis()){
      pepCX = random(0, 1000);
      pepCY = random(0, 1000);
      showPepC = true;
    }
  }
  //<i>The Anchovy</i> (Boat)
  if(showBoat){
    //Hull
    strokeWeight(1);
    fill(145);
    rect(rectAurek, rectBesh, rectLength, rectHeight);
    //Mast
    strokeWeight(3);
    line(rectAurek+50, rectBesh, rectAurek+50, rectBesh-105);
    //Sail
    strokeWeight(1);
    fill(200);
    triangle(rectAurek+50, rectBesh-15, rectAurek+125, rectBesh-50, rectAurek+50, rectBesh-100);
    //Sail Design
    fill(200, 200, 0);
    ellipse(rectAurek+75, rectBesh-62, 30, 30);
    fill(0);
    ellipse(rectAurek+75, rectBesh-62, 20, 20);
    line(rectAurek+70, rectBesh-35, rectAurek+95, rectBesh-35);
  }
  //Sausage
    fill(40, 40, 20);
    ellipse(sauX, sauY, 100, 100);
    if(xDir == true){
      sauX+=9;
      if(sauX >= 1000){
        xDir = false;
      }
    }
    else{
      sauX-=9;
      if(sauX <= 0){
        xDir = true;
      }
    }
    if(yDir == true){
      sauY+=7;
      if(sauY >= 1000){
        yDir = false;
      }
    }
    else{
      sauY-=7;
      if(sauY <= 0){
        yDir = true;
      }
    }
  //Check for sausage collisons
    if((sauX < rectAurek + 150 && sauX > rectAurek) && (sauY > rectBesh && sauY < rectBesh + 150)){
      gameEnd();
    }
}

void keyPressed(){
  //Ship movement... it even works when Caps Lock is on... but that's why there's (too) much code
  switch(key){
    case('W'):{
      rectBesh-=5;
      if(rectBesh < 0){
        rectBesh = 0;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('A'):{
      rectAurek-=5;
      rectAurek-=5;
      if(rectAurek < -50){
        rectAurek = -50;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('S'):{
      rectBesh+=5;
      if(rectBesh > 1000){
        rectBesh = 1000;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('D'):{
      rectAurek+=5;
      if(rectAurek > 950){
        rectAurek = 950;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('w'):{
      rectBesh-=5;
      if(rectBesh < 0){
        rectBesh = 0;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('a'):{
      rectAurek-=5;
      if(rectAurek < -50){
        rectAurek = -50;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('s'):{
      rectBesh+=5;
      if(rectBesh > 1000){
        rectBesh = 1000;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    case('d'):{
      rectAurek+=5;
      if(rectAurek > 950){
        rectAurek = 950;
        println("First Mate Margok: The current here is too strong to continue, cap'n!");
      }
      break;
    }
    default:{
      if(showBoat == false){
        setup();
      }
    }
 }
} 

void mousePressed(){
  //Tomato Sauce Cannon Beams
  if(showBoat){
    fill(80, 0, 0);
    strokeWeight(6);
    if((mouseX > pepAX - 100 && mouseX < pepAX + 100) && (mouseY > pepAY - 100 && mouseY < pepAY + 100) && showPepA){
      line(rectAurek, rectBesh, mouseX, mouseY);
      score+=10;
      println("Gunner Coratanni: Nice shot! Our score is " + score + ".");
      showPepA = false;
      pepAcd = millis() + 1500;
    }
    if((mouseX > pepBX - 100 && mouseX < pepBX + 100) && (mouseY > pepBY - 100 && mouseY < pepBY + 100) && showPepB){
      line(rectAurek, rectBesh, mouseX, mouseY);
      score+=10;
      println("Gunner Coratanni: Nice shot! Our score is " + score + ".");
      showPepB = false;
      pepBcd = millis() + 1500;
    }
    if((mouseX > pepCX - 100 && mouseX < pepCX + 100) && (mouseY > pepCY - 100 && mouseY < pepCY + 100) && showPepC){
      line(rectAurek, rectBesh, mouseX, mouseY);
      score+=10;
      println("Gunner Coratanni: Nice shot! Our score is " + score + ".");
      showPepC = false;
      pepCcd = millis() + 1500;
    }
    if((mouseX > sauX - 50 && mouseX < sauX + 50) && (mouseY > sauY - 50 && mouseY < sauY + 50)){
      line(rectAurek, rectBesh, mouseX, mouseY);
      score+=1;
      println("Helmsman Ruugar: Threat deflected. Our score is " + score + ".");
      if(xDir == true && (int)random(1,2) == 1){
        xDir = false;
      }
      else{
        xDir = true;
      }
      if(yDir == false && (int)random(1,2) == 2){
        yDir = true;
      }
      else{
        yDir = false;
      }
    }
  }
}

void gameEnd(){
  showBoat = false;
  if(score > highScore){
    highScore = score;
  }
  println("First Mate Margok: Sausage attack! We're going down!");
  println("Helmsman Ruugar: Your score was " + score + "; your high score is " + highScore + ".");
  println("Gunner Coratanni: Press any non-movement key to fix up the ship and try again!");
}
