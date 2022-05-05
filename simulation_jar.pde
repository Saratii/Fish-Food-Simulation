PImage fishyL;
PImage fishyR;
PImage donut;
PImage currentFishyPicture;
int[] donutX;
int[] donutY;
boolean[] eaten;
Fishy[] bucketOFishy;
int numFishy = 10;
int numDonuts = 20;
boolean started = false;
int hungwyness = 1;
int speed = 1;
int fishWidth = 100;
int fishHeight = 75;
//float angle = 240;

void reset(){
  buildDonut();
  buildFishy();
}

void setup(){
  size(800, 800);
  buildDonut();
  fishyL = loadImage("DAFISH.png");
  fishyR = loadImage("DAAFISH.png");
  currentFishyPicture = fishyR;
  donut = loadImage("donut.png");
  buildFishy();
}
void draw(){
  background(0);
  fill(255, 0 , 0);
  menu();
  if(started){
    fill(255, 0 , 0);
    drawDonuts();
    drawFishy();
    feedFishy();
    
    for(int i = 0; i<numFishy; i++){
      bucketOFishy[i].moveFishy();
    }
  }
}

void buildDonut(){
  donutX = new int[numDonuts];
  donutY = new int[numDonuts];
  eaten = new boolean[numDonuts];
  for(int i = 0; i<numDonuts; i++){
    donutX[i] = int(random(200, 800-70));
    donutY[i] = int(random(10, 800-60));
    eaten[i] = false;
  }
}

void drawDonuts(){
  for(int i = 0; i<numDonuts; i++){
    if(!eaten[i]){
      image(donut, donutX[i], donutY[i], 60, 50);
    }
  }
}
void buildFishy(){
  bucketOFishy = new Fishy[numFishy];
  for(int i = 0; i<numFishy; i++){
    bucketOFishy[i] = new Fishy(50, int(random(0, 800)), speed, 1, hungwyness);
  }
}
void drawFishy(){
  for(Fishy glupglup: bucketOFishy){
    //float angle = (float) atan2(glupglup.fishyY - glupglup.oldFishyY, glupglup.fishyX - glupglup.oldFishyX);
    //imageMode(CENTER);
    //translate(glupglup.fishyX, glupglup.fishyY);
    //rotate(radians(angle));
    if(glupglup.fishyHunger == 0){
      tint(0, 255, 255);
      image(currentFishyPicture, (int)glupglup.fishyX, (int)glupglup.fishyY, fishWidth, fishHeight);
    } else {
      noTint();
      image(currentFishyPicture, (int)glupglup.fishyX, (int)glupglup.fishyY, fishWidth, fishHeight);
    }
    noTint();
  }
}

void feedFishy(){
  boolean fishyAteDonut = false;
  for(Fishy glupglup: bucketOFishy){
    fishyAteDonut |= glupglup.eatDonut(); 
  }
  if(fishyAteDonut){
    for(Fishy glupglup: bucketOFishy){
      glupglup.findyDonut(); 
    }
  }
}

class Fishy{
  float fishyX;
  float fishyY; 
  float oldFishyX;
  float oldFishyY;
  int fishySpeed;
  int fishyColor;
  int fishyHunger;
  int closestDonut;
  
  Fishy(int x, int y, int speed, int coloor, int hunger){
    fishyX = x;
    fishyY = y;
    oldFishyX = x;
    oldFishyY = y;
    fishySpeed = speed;
    fishyColor = coloor;
    fishyHunger = hunger;
    findyDonut();
  }
void moveFishy(){
    if(fishyHunger>0){
      if(!eaten[closestDonut]){
        float vecX = donutX[closestDonut] + 30 - (fishyX + 50);
        float vecY = donutY[closestDonut] + 25 - (fishyY + 37.5);
        float distance = (float) Math.sqrt(vecX * vecX + vecY * vecY);
        if (distance < 1) {
            oldFishyX = fishyX;
            oldFishyY = fishyY;
            fishyX = donutX[closestDonut]+30-50;
            fishyY = donutY[closestDonut]+25 - 37.5;
            return;        
        }
        float vecLength = (float) Math.sqrt(vecX * vecX + vecY * vecY);
        vecLength *= speed;
        oldFishyX = fishyX;
        oldFishyY = fishyY;
        fishyX = fishyX + (vecX / vecLength);
        fishyY = fishyY + (vecY / vecLength);
      }
    }
  } 
void findyDonut(){
    int closest = 0;
    int closestDistance = 10000;
     for(int i = 0; i<numDonuts; i++){
       if(eaten[i]){
         continue;
       }
       int thisDonutDistance = int(sqrt(sq(fishyX+100-donutX[i]-30) + sq(fishyY+55-donutY[i]-30))); 
       if(thisDonutDistance<closestDistance){
         closestDistance = thisDonutDistance;
         closest = i;
       } 
     }
     closestDonut = closest;
  }
  boolean eatDonut(){
    for(int i = 0; i<numDonuts; i++){
      if(eaten[i]){
        continue;
      }
      int distance = int(sqrt(sq(fishyX+50-donutX[i]-30) + sq(fishyY+37.5-donutY[i]-25))); 
      if(distance<25){
        eaten[i] = true;
        fishyHunger -=1;
        return eaten[i];
      }
    } 
    return false;
  }
}

void menu(){
  fill(0, 255, 255);
  rect(700, 10, 100, 30);
  textSize(30);
  fill(255, 0, 255);
  text("Start", 703, 35);
}

void mouseClicked(){
  println(mouseX, " ", mouseY);
  if((700<=mouseX)&&(mouseX<=800)&&(10<=mouseY)&&(mouseY<=40)){
    reset();
    started = true;
    
  }
}


















  
  
  
  
  
  
