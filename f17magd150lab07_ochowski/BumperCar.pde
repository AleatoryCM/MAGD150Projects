class BumperCar{
  
  PVector position;        //The central position of the bumper car.
  PVector direction;       //The direction in which the bumper car is "pointing".
  PVector velocity;        //The velocity of the bumper car.
  int cDirection;          //A second, numeric representation of the car's current direction.
  int controlModifier;     //The modifier used to control the offset for the control coordiantes of the body curve.
  int posModifier;         //The modifier used to control the offset for the positional coordiantes of the body curve.
  int speedLimit;          //The maximum pace at which the bumper car can move.
  color carColor;          //The primary color of this bumper car. All bumper cars have a secondary color of black.
  boolean overrided;       //Whether or not player control of the bumper car has been overrided by a recent collision. Only used by the player car.
  int overrideTimer;       //The amount of time until the player can control their car once more.
  boolean collisionCD;     //Whether or not a collision has already been detected for this car in the method in which this variable is used.
  int transVar;            //The translation of the patrolling player car.
  
  //Constructs a new bumper car object.
  BumperCar(){
    position = new PVector((int)random(0, width), (int)random(0, height));
    velocity = new PVector(0, 0);
    getNewDirection();
    controlModifier = 150;
    posModifier = 80;
    speedLimit = 5;
    overrided = false;
    collisionCD = false;
    if((int)random(0, 10) == 5){
      carColor = color((int) random(0, 255));
    }
    else{
      carColor = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
    }
  }
  
  //Draws the bumper car.
  void display(){
    PVector controlPoint = new PVector(position.x, position.y + 100);                    //This vector is a derivative of the position vector used specifically to place the control coordinates of the body curve.
    PVector polePoint = new PVector(position.x + posModifier - 2, position.y - 120);     //This vector is a derivative of the position vector used specifically to place the pole and hook.
    //Windshield
    stroke(0);
    strokeWeight(1);
    fill(0, 50, 200, 40);
    arc(position.x - 44, position.y, 70, 70, PI, PI + HALF_PI);
    //Body
    fill(carColor);
    curve(controlPoint.x - controlModifier, controlPoint.y, position.x - posModifier, position.y, position.x + posModifier, position.y, controlPoint.x + controlModifier, controlPoint.y);
    rectMode(CORNER);
    fill(0);
    rect(position.x - posModifier, position.y, 160, 12);
    fill(carColor);
    rect(position.x - posModifier, position.y + 12, 160, 12);
    //Pole & Hook
    strokeWeight(3);
    line(polePoint.x, polePoint.y + 120, polePoint.x, polePoint.y);
    noFill();
    curve(position.x, polePoint.y - 36, polePoint.x, polePoint.y, polePoint.x + 34, polePoint.y, position.x - 14, polePoint.y - 36);
  }
  
  //Returns the x value of the bumper car's position.
  float getX(){
    return position.x;
  }
  
  //Returns the y value of the bumper car's position.
  float getY(){
    return position.y;
  }
  
  //Sets the color of the bumper car to the selected color on the Start screen. Only called by the player's bumper car.
  void setColor(color newColor){
    carColor = color(newColor);
  }

  //Moves the bumper car according to WASD key presses. Only called by the player's bumper car.
  void move(){
    if(!overrided){ 
      switch(key){
        case('W'):{
          cDirection = 7;
          direction = position.add(0, -5);
          finalMove();
          break;
        } 
        case('A'):{
          cDirection = 6;
          direction = position.add(-5, 0);
          finalMove();
          break;
        }
        case('D'):{
          cDirection = 3;
          direction = position.add(5, 0);
          finalMove();
          break;
        }
        case('S'):{
          cDirection = 2;
          direction = position.add(0, 5);
          finalMove();
          break;
        }
        case('w'):{
          cDirection = 7;
          direction = position.add(0, -5);
          finalMove();
          break;
        } 
        case('a'):{
          cDirection = 6;
          direction = position.add(-5, 0);
          finalMove();
          break;
        }
        case('d'):{
          cDirection = 3;
          direction = position.add(5, 0);
          finalMove();
          break;
        }
        case('s'):{
          cDirection = 2;
          direction = position.add(0, 5);
          finalMove();
          break;
        }
      }
    }
    else{
      if(millis() >= overrideTimer){
        overrided = false;
      }
      updateTarget();
    }
  }
 
  //"Randomly" moves the bumper car (I tried my best). Only called by CPU bumper cars.
  void automatedMovement(){
    if((int)random(0, 100) == 0){  //Every now and then, the car changes direction of movement randomly.
      getNewDirection();
    }
    else{
      updateTarget();
    }
  } 
  
  //Picks a new direction for a bumper car.
  void getNewDirection(){
    cDirection = (int)random(1,9);
    updateTarget();
  }
  
  //Adjusts the bumper car's heading so it sails smoothly.
  void updateTarget(){
    if(collisionCD == true){
      collisionCD = false;
    }
    switch(cDirection){  //CPU cars get the same 8 direction choices as player cars.
      case(1):{
        direction = position.add(5, 5);
        break;
      }
      case(2):{
        direction = position.add(0, 5);
        break;
      }
      case(3):{
        direction = position.add(5, 0);
        break;
      }
      case(4):{
        direction = position.add(-5, 5);
        break;
      }
      case(5):{
        direction = position.add(5, -5);
        break;
      }
      case(6):{
        direction = position.add(-5, 0);
        break;
      }
      case(7):{
        direction = position.add(0, -5);
        break;
      }
      case(8):{
        direction = position.add(-5, -5);
        break;
      }
    }
    finalMove();
  }
    
  //After a heck of a lot of methods, actually *moves* the bumper car according to the player-inputed OR automated direction specified.
  void finalMove(){
    //Some inspiration from the NOC_1_10 example code in the next few lines.
    PVector preVelocity = PVector.sub(direction, position);
    preVelocity.setMag(.1);
    velocity.add(preVelocity);
    velocity.limit(speedLimit);
    position.add(velocity);
    if(position.x <= 0){
      position.x = 0;
      getNewDirection();
    }
    else if(position.x >= width){
      position.x = width;
      getNewDirection();
    }
    else if(position.y <= 0){
      position.y = 0;
      getNewDirection();
    }
    else if(position.y >= height){
      position.y = height;
      getNewDirection();
    }
  }
  
  //A method that reverses the direction of a bumper car that has just collided.
  void collisionFallout(){
    collisionCD = true;
    switch(cDirection){
      case(1):{
        cDirection = 8;
        break;
      }
      case(2):{
        cDirection = 7;
        break;
      }
       case(3):{
        cDirection = 6;
        break;
      }
       case(4):{
        cDirection = 5;
        break;
      }
       case(5):{
        cDirection = 4;
        break;
      }
       case(6):{
        cDirection = 3;
        break;
      }
       case(7):{
        cDirection = 2;
        break;
      }
       case(8):{
        cDirection = 1;
        break;
      }
    }
    updateTarget();
  }
  
  //Player car patrols on the Instructions screen.
  void onPatrol(){
    position.x = 0;
    position.y = 0;
    transVar++;
    scale(3, 3);
    translate(transVar, transVar);
    if(transVar > 800){
      transVar = 0;
    }
    display();
    translate(-transVar, -transVar);
  }
}