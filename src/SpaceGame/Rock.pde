class Rock {
  // Member Variables
  int x, y, diam, speed;

  PImage rock1;
  
  Rock() {
    x=int (random(width));
    y=-100;
    diam=int(random(75, 100));
    speed =int(random(1, 3));
    if (random(10)>6.6) {
      rock1=loadImage("rock.png");
    } else if (random(10)>5.0) {
      rock1=loadImage("rock2.png");
    } else {
      rock1=loadImage("rock2.png");
    }
  }
  // Member Methods
  void display() {
    imageMode(CENTER);
    rock1.resize(diam, diam);
    image(rock1, x, y);
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
}
