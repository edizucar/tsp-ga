class GAAboutManager{
  Manager manager;
  PImage textBox;
  PImage img;
  Button back;
  
  GAAboutManager(Manager m) {
    manager = m;
  }
  void setup(){
    
    // loading in images for the back button (and for when it is hovered over)
    PImage backImg = loadImage("images/back.png");
    backImg.resize(75,0);
    
    PImage backImgHov = loadImage("images/backHover.png");
    backImgHov.resize(75,0);
    
    // instantiating the back button object
    back = new Button(new PVector(10,10), backImg, backImgHov);
    
    // loading in the text box as an image
    textBox = loadImage("images/about/ga/text.png");
    textBox.resize(500,0);
    
    // loading in the graphic as an image
    img = loadImage("images/about/ga/diagram.png");
    img.resize(350,0);
  }
  void draw(){
    // set background to black
    background(0);
    
    // drawing in textbox and graphic
    image(textBox,50,100);
    image(img, 600, 100);
    
    //drawing in the back button
    back.draw();
    
    
  }
  
  void mousePressed(){
    if (back.mouseOver()){ 
      // sets the current page to the about page if the back button is pressed
      manager.page = "about";
    }
  }
  
  
}
