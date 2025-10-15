class Laser {
  // Member Variables
  int x, y, w, h, speed, play, frame, frameCount;
  PImage Laser;


  //Constructor
  Laser(int x, int y) {
    this.x  = x;
    this.y = y;
    w = 4;
    h = 10;
    speed = 20;
    Laser = loadImage("laser.png");
  }

  // Member Methods
  void display() {
    Laser = loadImage("laser.png");
    Laser.resize(70, 70);
    image(Laser, x, y);
  }

  void move() {
    y = y - speed;
  }


  boolean reachedTop() {
    if (y<0-10) {
      return true;
    } else {
      return false;
    }
  }


  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<10) {
      return true;
    } else {
      return false;
    }
  }
}
