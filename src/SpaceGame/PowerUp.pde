class PowerUp {
  // Member Variables
  int x, y, w, speed;
  char type;
  //PImage rock1;
 color c1;
  
  PowerUp() {
    x=int (random(width));
    y=-100;
    w=100;
    speed =int(random(1,5));
   
     if(random(10)>7) {
      //rock1=loadImage("ammo.png");
      type = 'a'; //This is AMMO
      c1 = color(255,0,0);
    } else if (random(10)>5) {
     //rock1=loadImage("health.png");
     type = 'h'; //This is Health
      c1 = color(0,255,0);
    } else {
     // rock1=loadImage("turret.png");
     type = 't'; //This is Turret Count
      c1 = color(0,0,255);
    }
  }
  // Member Methods
  void display() {
    fill(c1);
    ellipse(x,y,w,w);
    fill(255);
    textAlign(CENTER);
    text(type,x,y);
    //imageMode(CENTER);
    //c1.resize(w,w);
    //image(c1, x, y);
  }

  void move() {
    y = y + speed;
  }


  boolean reachedBottom() {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }
  
   boolean intersect(Spaceship s) {
    float d = dist(x, y, s.x, s.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
}
