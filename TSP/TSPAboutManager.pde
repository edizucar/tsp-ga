

class TSPAboutManager{
  Manager manager;
  PImage textBox;
  PImage img;
  Button back;
  
  TSPAboutManager(Manager m) {
    manager = m;
  }
  void setup(){
    //initialising back button
    PImage backImg = loadImage("images/back.png");
    backImg.resize(75,0);
    
    PImage backImgHov = loadImage("images/backHover.png");
    backImgHov.resize(75,0);
    
    back = new Button(new PVector(10,10), backImg, backImgHov);
    
    //loading text image
    textBox = loadImage("images/about/tsp/text.png");
    textBox.resize(350,0);
    
    //loading in diagram
    img = loadImage("images/about/tsp/diagram.png");
    img.resize(550,0);
  }
  void draw(){
    background(0);
    //draw text
    image(textBox,50,100);
    //draw diagram
    image(img, 425, 100);
    //draw back button
    back.draw();
    
    
  }
  
  void mousePressed(){
    if (back.mouseOver()){
      //changes page to about page
      manager.page = "about";
    }
  }
  
  
}
