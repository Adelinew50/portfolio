// Adeline Wright | 17 Sep 2025 | SpaceGame
Spaceship curlyfries;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<PowerUp> powups = new ArrayList<PowerUp>();
Timer rockTimer, puTimer;
int score, rocksMissed, level;
boolean play;
PImage bg1;
SoundFile lsound;
import processing.sound.*;


void setup() {
  size(500, 500);
  background(20);
  level = 1;
  curlyfries = new Spaceship();
  puTimer = new Timer(5000);
  puTimer.start();
  rockTimer = new Timer(2000);
  rockTimer.start();
  score = 0;
  bg1 = loadImage("SpaceBackground2.png");
  bg1.resize(500, 500);
  rocksMissed = 0;
  play = false;
  lsound = new SoundFile(this, "lsound.wav");
}

void startScreen () {
  background(20);
  image(bg1, 0, 0);
  fill(255);
  text("SpaceGame", width/2, 210);
  textSize(30);
  text("Adeline Wright", 50, 210);
  textSize(30);
  if (mousePressed) {
    play=true;
  }
}

void gameOver() {
  //image(go1,0,0);
  background(0);
  fill(50, 100, 200);
  text("Game Over!", width/2, height/2);
  text("You got a score of: " + score, width/5, height/5);
  noLoop();
}


void draw() {
  if (!play) {
    startScreen();
  }
 else if (curlyfries.health <= 0 || rocksMissed >= 10) {
 gameOver();
 }
  else {
     
//Main Game
    background(22);

    // Leveling up every 500 points
    if (score >= level * 500) {
      level++;

      // Make the game harder:
      int newRockTime = max(500, 2000 - level * 200); // Lower limit to prevent 0
      rockTimer = new Timer(newRockTime);
    }

    //Distribution of PowerUps on a Timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }
    //Display and Move Powerups
    for (int i = 0; i<powups.size(); i++) {
      PowerUp pu = powups.get(i);
      pu.display();
      pu.move();
      //check bottom

      if (pu.intersect(curlyfries)) {
        //remove
        powups.remove(pu);
        if (pu.type=='H') {
          curlyfries.health+=100;
          //Turret Increases
        } else if (pu.type=='T') {
          curlyfries.turretCount+=1;
          if (curlyfries.turretCount>5) {
            curlyfries.turretCount = 5;
          }
          //Ammo
        } else if (pu.type == 'A') {
          curlyfries.laserCount+=100;
        }
      }
      //check spaceship collision
      if (pu.intersect(curlyfries)) {
        if (pu.type == 't') {
          curlyfries.turretCount++;
          //Game over
          if (curlyfries.health<1) {
            gameOver();
          }
        }
      }
    }
    //Check Levels
    //if(level==1){
    // Decrease rockTimer
    //}

    //Distribute Stars
    stars.add(new Star());

    // Display and Remove Stars
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
        i--;
      }
      println("Stars;"  + stars.size());
    }

    //Distribution of Rocks on a Timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }
    //Display of all the rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();

      if (curlyfries.intersect(rock)) {
        rocks.remove(rock);
        score+=rock.diam;
      }

      if (rock.reachedBottom()) {
        rocksMissed = rocksMissed +1;
        rocks.remove(rock);
        i--;
      }
      println("Rocks;"  + rocks.size());
    }

    //Display and move Lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j ++) {
        Rock r = rocks.get(j);
        if (laser.intersect (r)) {
          lasers.remove(laser);
          r.diam -= 50;
          if (r.diam<5) {
            rocks.remove(r);
          }
          score+= r.diam;
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
      println("Lasers;" + lasers.size());
    }
    curlyfries.display();
    curlyfries.move(mouseX, mouseY);
    infoPanel();
  }
}
void mousePressed() {
  if (curlyfries.fire()) {
    lasers.add(new Laser(curlyfries.x, curlyfries.y));
    curlyfries.laserCount--;
  }
}


void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  noStroke();
  rect(width/2, height-25, width, 50);
  fill(255);
  textSize(15);
  text("Score:" + score, 20, width-30);
  textSize(15);
  text("Ammo:" + curlyfries.laserCount, 20, height-6);
  textSize(15);
  text("Health:" + curlyfries.health, 160, height-20);
  textSize(15);
  text("Rocks Missed:" + rocksMissed, width -200, width-20);
  textSize(15);
  text("Level:" + level, width -200, 60);
  textSize(15);
}
