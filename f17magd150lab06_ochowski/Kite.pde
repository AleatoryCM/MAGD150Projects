class Kite{
  
  int centerX, centerY;
  boolean isVisible;
  
  //The constructor for the Kite class.
  Kite(){
    centerX = (int) random(0, 1300);
    centerY = (int) random(200, 800);
    isVisible = true;
  }
  
  //This is a simple return method to allow other parts of the program to access the horizontal position of each kite.
  int getX(){
    return centerX;
  }
  
  //This is a simple return method to allow other parts of the program to access the vertical position of each kite.
  int getY(){
    return centerY;
  }
  
  //A simple method that turns the kite invisible once it has been struck by lightning, to indicate the fact that it has been incinerated.
  void struck(){
    isVisible = false;
  }
  
  //A simple method to prematurely reveal invisible kites in the case that the game ends.
  void reveal(){
    isVisible = true;
  }
  
  //This method is used to display the kite objects.
  void form(){
    if(isVisible){
      if(gameActive){
        fill(65, 0, 0);
        stroke(65, 0, 0);
      }
      else{
        fill(195, 0, 0);
        stroke(65, 0, 0);
      }
      line(centerX - 55, centerY + 45, centerX - 135, centerY + 125);
      stroke(0);
      beginShape();
      vertex(centerX - 55, centerY + 45);
      vertex(centerX - 30, centerY - 20);
      vertex(centerX + 55, centerY - 45);
      vertex(centerX + 30, centerY + 20);
      endShape();
    }
  }
  
  //This method controls the movement of the kites.
  void move(){
    if(centerX < width){
      if((int) random(1, 10) == 10){
        centerX = centerX + 13 + ((millis() - waypoint) / 10000);
      }
      else{
        centerX = centerX + 3 + ((millis() - waypoint) / 10000);
      }
    }
    else{
      if(isVisible){
        escapees+=1;
      }
      isVisible = true;
      centerX = 0;
      centerY = (int) random(200, 800);
    }
  }
}