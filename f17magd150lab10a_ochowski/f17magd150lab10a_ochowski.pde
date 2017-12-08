//City Sketch

/* @alecOchowski
   Section 03
   Tested & fully operational as of 11/28/2017 */
   
/* Note that the below code is an adapted version of the first sketch I submitted for this class. I copied and pasted that
   sketch here, then redid the background and added color in some areas to a). Showcase the new abilities that I learned in
   this class, and b). Add more visual appeal and flair. Neither the original nor the rest of lab 10 have been submitted to
   GitHub.*/

void setup (){
  size(1200, 1000);
  background(255);
}

void draw (){  //Buildings draw from left to right
  //Background Gradient
  float yellow = 0;   //The color of the vertical line that will be drawn to help create the gradient.
  //int loc = The x location of the vertical line that will be drawn to help create the gradient.
  for(int loc = 0; loc < width; loc++){
    stroke(yellow * .3, yellow * .3, 0);
    line(loc, 0, loc, height);
    if(loc < (width / 2 - 75)){
      yellow++;
    }
    else{
      yellow--;
    }
  }
  //Building 1 (Skyscraper)
  //Superstructure
  strokeWeight(0);
  fill(0);
  rect(0, 1200, 200, -1000);
  //Windows
  stroke(255, 255, 0);
  strokeWeight(2);
  int horizPosition = 10;  //Controls where the windows are drawn horizontally
  for(int j = 0; j < 4; j++){
    int lowerBound = 1190;  //The lower bound of each window
    int upperBound = 1140;  //The upper bound of each window
    for(int i = 0; i < 13; i++){
      line(horizPosition, lowerBound, horizPosition, upperBound);
      lowerBound-=75;
      upperBound-=75;
    }
    horizPosition+=55;
  }
  //Spire
  stroke(55);
  line(100, 200, 100, 100);
  strokeWeight(30);
  point(100, 100);
  
  //Building 2 (Clock Tower)
  //Superstructure
  fill(215);
  strokeWeight(1);
  stroke(140);
  rect(200, 500, 200, 1000);
  triangle(400, 500, 200, 500, 300, 250);
  //Clock Face
  ellipseMode(RADIUS);
  ellipse(300, 425, 60, 60);
  line(360, 425, 330, 425);
  line(240, 425, 270, 425);
  line(300, 485, 300, 455);
  line(300, 365, 300, 395);
  stroke(10);
  strokeWeight(3);
  line(300, 425, 300, 385);
  strokeWeight(5);
  line(300, 425, 300, 405);
  //Texture
  stroke(120);
  strokeWeight(5);
  horizPosition = 207;
  int vertPosition = 1190;  //The vertical coordinate of each texture point
  for(int k = 0; k < 10; k++){
    vertPosition = 1190;
    for(int m = 0; m < 35; m++){
      point(horizPosition, vertPosition);
     vertPosition-=20;
    }
    horizPosition+=20;
  }
  
  //Building 3 (Bridge)-- PART I
  //Superstructure
  fill(95);
  noStroke();
  rectMode(CENTER);
  rect(700, 900, 600, 325);
  //Arch
  fill(120, 120, 0);
  stroke(85);
  strokeWeight(1);
  arc(700, 1100, 250, 300, PI, 2*PI, OPEN);
  
  //Building 4 (Apartment Complex)
  //Superstructure
  fill(235);
  stroke(100);
  rectMode(CORNERS);
  rect(700, 400, 1000, 737);
  arc(700, 1100, 250, 300, PI+HALF_PI, 2.5*PI, OPEN);
  line(700, 800, 700, 1200);
  //Roof
  triangle(650, 400, 1000, 400, 1000, 100);
  
  //Building 3 (Bridge)-- PART II
  //Railing
  noFill();
  stroke(0);
  rectMode(CENTER);
  rect(700, 725, 600, 25);
  
  //Building 5 (Contemporary Museum Thing)
  //Superstructure
  fill(40);
  rectMode(CORNER);
  rect(1000, 1200, 1200, -1190, 12);
  //Architectural Flair (Windows)
  ellipseMode(CENTER);
  fill(200, 200, 0);
  horizPosition = 1100;
  vertPosition = 80;
  for(int n = 0; n < 6; n++){
    ellipse(horizPosition, vertPosition, 160, 120);
    vertPosition+=180;
  }
  
  //Moon
  fill(255, 255, 0);
  arc(540, 75, 180, 180, QUARTER_PI, PI+QUARTER_PI, PIE);
  
  //Save for usage as texture
  save("city.png");
}
