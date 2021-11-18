

class TutorialManager{
  Manager manager;
  Button back;
  PImage tut;
  
  TutorialManager(Manager m){
    manager = m;

  }
  
  void setup(){
    //initialise back button
    PImage backImg = loadImage("images/back.png");
    backImg.resize(75,0);
    
    PImage backImgHov = loadImage("images/backHover.png");
    backImgHov.resize(75,0);
    
    back = new Button(new PVector(10,10), backImg, backImgHov);
    
    //load in tutorial image
    tut = loadImage("images/tutorial/tutorialImg.png");
    //make it fit the whole page
    tut.resize(width,height);
    
    
    
  }
  
  void draw(){
    background(0);
    //draw image on the screen
    image(tut,0,0);
    //draw back button
    back.draw(); 
  }
  

  
  void mousePressed(){
    if (back.mouseOver()){
      //set the page to home page
      manager.page = "home";
    }
    
  }
  
  
  
}
