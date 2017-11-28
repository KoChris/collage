import processing.video.*;

// Conference Collage
//
// Needs to:
// 1. Take pictures and save them to disk
// 2. Dynamically draw collage with # of pictures
//
// Nice to haves
// - Restart/Safe failure (with previous pictures) func
// - Save collage as gifs
// - Picture overlay / tint
// - Video overlay

// The images to be loaded
PImage img;
PImage img2;

// Font of printed text
PFont font;

// size of the images (this will need to change to make it dynamic)
int imageX = 150;
int imageY = 150;

// The 'length' (num of pics) of the square  
int currIndex = 0;

// one for camera, one for the collage to be printed
Capture cam;
Collage collage;

// Set up method
void setup() {
  // size of window
  size(900, 900);
  
  img = loadImage("whitecat.png");
  img2 = loadImage("blackcat.png");
  
  font = createFont("Arial",30,true);
  
  // camera
  //cam = new Capture(this);
  
  collage = new Collage();
  
  // The first picture's size will be same size as window
  imageX = width;
  imageY = height;
}

// The collage that will be printed
// I made it into a seperate class bc it 'might' make
//    it easier to load back up from errors
class Collage {
 
  // not used yet
  ArrayList<PImage> pictureList;
  
  // The number of pictures in the queue
  int pictureCount;
  
  int getPictureCount(){
    return pictureCount;
  }
  
  void drawCollage() {
    
    // add pic to queue
    pictureCount++;
        
    // can only increment length by one at a time
    if(pictureCount > currIndex*currIndex){
     currIndex++;
     
     // size of picture is width/# of pics
     imageX = width/currIndex;
     imageY = height/currIndex;
    }
    
    println("pictureCount: " + pictureCount);
    println("currIndex: " + currIndex);
    
    // Variables to reset before each for loop
    int pictureQueueIndex = pictureCount;
    int numRow = currIndex;
    int numCol = currIndex;
    
    // Not that it matters but this draws colum down first
    for(int i=0; i<numRow; i++){
      for(int j=0; j<numCol; j++){
        if(pictureQueueIndex > 0){
          // if pic in q, print black cat
          image(img, i*imageX, j*imageY, imageX, imageY);
        } else {
          // if pic not in q, print white cat
          image(img2, i*imageX, j*imageY, imageX, imageY);
        }
        // remove pic from queue
        pictureQueueIndex--;
      }
    }
  }
}

// Drawing the picture count in top right
// this can be adjusted as the foreground logo/ text
void drawPictureCount(){
  textFont(font);
  textAlign(RIGHT);
  text("Picture count: " + collage.getPictureCount() ,width,100);
}

// Add a picture to queue and draw collage
void keyPressed() {
    
  if(key == 'P' || key == 'p'){
    collage.drawCollage();
  }
}

// loop function to print constantly (use for video)
void draw() {
  // take picture
  //if (cam.available()) { 
    // Reads the new frame
    //cam.read(); 
  //} 
  //image(cam, 50, 50); 
  
  // draw pictures
  drawPictureCount();
  
  // Mouse click will print the picture
  if (mousePressed) {
    image(img, mouseX, mouseY, imageX, imageY);
  }
}