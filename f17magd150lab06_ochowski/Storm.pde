class Storm{
  
  int epicenterX;  //The X value for the center of the storm
  int epicenterY;  //The Y value for the center of the storm
  
  //The constructor for the Storm class.
  Storm(){
    epicenterX = 1500;
    epicenterY = 100;
  }
  
  //This method returns the storm to its starting location.
  void home(){
    epicenterX = 1500;
  }
  
  //This method "forms" (or draws) the storm.
  void form(){
    fill(20);
    noStroke();
    ellipse(epicenterX, epicenterY, 100, 100);
    ellipse(epicenterX + 30, epicenterY - 45, 100, 100);
    ellipse(epicenterX - 35, epicenterY + 40, 100, 100);
    ellipse(epicenterX + 50, epicenterY + 45, 100, 100);
    ellipse(epicenterX + 75, epicenterY, 100, 100);
    ellipse(epicenterX - 55, epicenterY - 40, 100, 100);
    ellipse(epicenterX - 80, epicenterY - 10, 100, 100);
  }
  
  //This method allows the storm to be moved with the A & S keys.
  //Recycles some code from my project #4; ***because there are only so many ways to program WASD movement***
  void move(){
    switch(key){
      case('A'):{
        epicenterX-=5;
        if(epicenterX < 0){
          epicenterX = 0;
        }
        break;
      }
      case('D'):{
        epicenterX+=5;
        if(epicenterX > width){
          epicenterX = width;
        }
        break;
      }
      case('S'):{
        strike();
      }
      case('a'):{
        epicenterX-=5;
        if(epicenterX < 0){
          epicenterX = 0;
        }
        break;
      }
      case('d'):{
        epicenterX+=5;
        if(epicenterX > width){
          epicenterX = width;
        }
        break;
      }
      case('s'):{
        strike();
      }
    }
  }
  
  //Sends a lightning strike to the target location; the chief mechanic of the game.
  void strike(){
    boolean singularity = true;    //Indicates whether or not there is only one kite in the path of the lightning strike.
    Kite target = new Kite();      //The lowest kite (i.e. the one the lightning will target)
    int kiteCount = 0;             //The number of kites hit in the lightning strike.
    Kite[] kiteArray = new Kite[3];
    kiteArray[0] = kite1;
    kiteArray[1] = kite2;
    kiteArray[2] = kite3;
    for(Kite k : kiteArray){
      if(k.getX() < epicenterX + 50 && k.getX() > epicenterX - 50 && k.isVisible){
        kiteCount+=1;
        k.struck();
        if(singularity){
          singularity = !singularity;
          target = k;
        }
        else{
          if(target.getY() < k.getY()){
            target = k;
          }
        }
      }
    }
    if(kiteCount >= 1){
      int lightningPlaceY = epicenterY;
      int lightningPlaceX = epicenterX;
      int zigzag = 1;
      stroke(200, 200, 0);
      strokeWeight(6);
      while(target.getY() > lightningPlaceY){
        switch(zigzag){
          case(1):{
            line(lightningPlaceX, lightningPlaceY, lightningPlaceX - 25, lightningPlaceY + 100);
            lightningPlaceX-=25;
            zigzag = 2;
            break;
          }
          case(2):{
            line(lightningPlaceX, lightningPlaceY, lightningPlaceX - 25, lightningPlaceY + 100);
            lightningPlaceX-=25;
            zigzag = 3;
            break;
          }
          case(3):{
            line(lightningPlaceX, lightningPlaceY, lightningPlaceX + 25, lightningPlaceY + 100);
            lightningPlaceX+=25;
            zigzag = 4;
            break;
          }
          case(4):{
            line(lightningPlaceX, lightningPlaceY, lightningPlaceX + 25, lightningPlaceY + 100);
            lightningPlaceX+=25;
            zigzag = 1;
            break;
          }
        }
        lightningPlaceY+=100;
      }
      stroke(0);
      strokeWeight(1);
      score = score + (kiteCount * 10);
    }
  }
}