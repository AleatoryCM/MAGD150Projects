//ShapeCast

/* @alecOchowski
   Section 03
   Tested & fully operational as of 10/17/2017 */
   
int bR = 0;             //The R value for channel backgrounds
int bG = 0;             //The G value for channel backgrounds
int bB = 0;             //The B value for channel backgrounds
float rectA = 900;      //X coordinate for the rectangular button
float rectB = 905;      //Y coordinate for the rectangular button
float rectH = 190;      //Height of the rectangular button
float rectW = 40;       //Width of the rectangular button
float ellA = 175;       //X coordinate for the first circular button
float ellB = 925;       //Y coordinate for the first circular button
float ellD = 40;        //Diameter of the first circular button
float ell2A = 220;      //X coordinate for the second circular button
float ell2B = 925;      //Y coordinate for the second circular button
float ell2D = 40;       //Diameter of the second circular button
int channel = 1;        //The current channel displayed on the television
boolean tvOn = false;   //Whether or not the television is turned on
float powerCD = 0;      //Used as a timer to ensure that each press of the power button only adjusts the tvOn boolean once
float channelCD = 0;    //Used as a timer to ensure that each press of the up and down buttons only adjusts the channel int once

void setup(){
  size(1200, 1000);
  background(190, 180, 170);
}

void draw(){
  //TV Base Structure
  fill(70, 60, 50);
  rect(100, 50, 1000, 900);
  if(tvOn){  
    chooseFill();
  }
  else{
    fill(50);
  }
  rect(150, 100, 900, 800);
  //Buttons
  fill(120, 110, 100);
  rect(rectA, rectB, rectH, rectW);
  ellipse(ellA, ellB, ellD, ellD);
  ellipse(ell2A, ell2B, ell2D, ell2D);
  //Text For Buttons
  fill(0);
  textSize(12);
  text("Up", 167, 930);
  text("Down", 204, 930);
  textSize(32);
  text("Power", 952, 935);
  //Button Press Detection
  if(mousePressed){
    if(mouseX > rectA && mouseX < rectA + rectH && mouseY > rectB && mouseY < rectB + rectW){
      powerButtonPressed();
    }
    else if(sqrt(sq(ellA - mouseX) + sq(ellB - mouseY)) < ellD / 2){
      channelUpPressed();
    }
     else if(sqrt(sq(ell2A - mouseX) + sq(ell2B - mouseY)) < ell2D / 2){
      channelDownPressed();
    }
  }
  //Screen Display
  if(tvOn){
    textSize(64);
    text(channel, 150, 155);
    drawLogo();
  }
}

//Turns the TV on or off in response to the power button being pressed
void powerButtonPressed(){
  if(powerCD <= millis()){
    if(!tvOn){
      tvOn = true;
    }
    else{
      tvOn = false;
    }
    powerCD = millis() + 200.0;
  }
}

//Changes to the next highest channel, if there is one
void channelUpPressed(){
  if(channelCD <= millis() && tvOn){
    if(channel < 4){
      channel++;
    }
    channelCD = millis() + 200.0;
  }
}

//Changes to the next lowest channel, if there is one
void channelDownPressed(){
  if(channelCD <= millis() && tvOn){
    if(channel > 1){
      channel--;
    }
    channelCD = millis() + 200.0;
  }
}

//Deploys the correct screen color based on the channel
void chooseFill(){
  switch(channel){
    case(1):{
      fill(100, 0, 0);
      break;
    }
    case(2):{
      fill(150, 0, 150);
      break;
    }
    case(3):{
      fill(20, 160, 210);
      break;
    }
    case(4):{
      fill(0, 40, 0);
      break;
    }
  }
}

//Draws the correct channel logo based on the channel
void drawLogo(){
  switch(channel){
    case(1):{
      fill(0, 100, 0);
      triangle(1000, 250, 600, 850, 200, 250);
      fill(180, 0, 0);
      text("TriNews", 470, 350);
      break;
    }
    case(2):{
      fill(50, 0, 50);
      ellipse(600, 500, 600, 600);
      fill(250);
      text("The", 540, 400);
      text("Sphere", 498, 500);
      text("Report", 500, 600);
      break;
    }
    case(3):{
      fill(200, 100, 50);
      beginShape();
      vertex(400, 150);
      vertex(1000, 150);
      vertex(800, 850);
      vertex(200, 850);
      vertex(400, 150);
      endShape();
      fill(20, 160, 210);
      text("Parallelogram", 395, 450);
      text("Post", 530, 550);
      break;
    }
    case(4):{
      fill(0, 140, 0);
      beginShape();
      vertex(600, 200);
      vertex(900, 500);
      vertex(750, 800);
      vertex(450, 800);
      vertex(300, 500);
      vertex(600, 200);
      endShape();
      fill(0, 40, 0);
      text("Pentagon", 453, 500);
      text("Prime", 513, 600);
      break;
    }
  }
}
