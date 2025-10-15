class Spaceship {
  // Member Variables
  int x, y, w, health, laserCount, turretCount;
  //PImage ship;

  // Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    health = 100;
    laserCount = 100;
    turretCount = 1;
    //ship = loadImages("file name.png");
  }

  // Member Methods
  void display() {
    //image(ship,x,y);
    rectMode(CENTER);
    fill(50, 120, 200);
    stroke(255);
    strokeWeight(3);
    ellipse(x, y, 30, 80);  // vertical body
    triangle(x, y-20, x-40, y, x+40, y);

    fill(0, 255, 0);
    triangle(x, y + 40, x - 10, y + 60, x + 10, y + 60);

    fill(255, 100, 0);
    noStroke();
    triangle(x, y + 40, x - 10, y + 60, x + 10, y + 60);

    //Windows
    fill(255);
    ellipse(x, y - 20, 10, 10);

    fill(255);
    ellipse(x, y - 1, 10, 10);

    fill(255);
    ellipse(x, y + 20, 10, 10);
  }

  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  boolean fire() {
    if(laserCount>0) {
    return true;
    }else{
      return false;
    }
  }

  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
  
  
}
