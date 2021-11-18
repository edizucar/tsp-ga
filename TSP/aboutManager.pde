

class AboutManager{
  Manager manager;
  Button back;
  PImage title;
  Button tsp;
  Button ga;
  Button other;
  
  AboutManager(Manager m){
    manager = m;

  }
  
  void setup(){
    //initialise back button
    PImage backImg = loadImage("images/back.png");
    backImg.resize(75,0);
    
    PImage backImgHov = loadImage("images/backHover.png");
    backImgHov.resize(75,0);
    
    back = new Button(new PVector(10,10), backImg, backImgHov);
    
    //initialise TSP button 
    PImage tspImg = loadImage("images/about/tsp.png");
    tspImg.resize(400,65);
    
    PImage tspImgHov = loadImage("images/about/tspHover.png");
    tspImgHov.resize(400,65);
    
    tsp = new Button(new PVector(280,300),tspImg,tspImgHov);
    
    
    //initialise GA button
    PImage gaImg = loadImage("images/about/ga.png");
    gaImg.resize(400,65);
    
    PImage gaImgHov = loadImage("images/about/gaHover.png");
    gaImgHov.resize(400,65);
    
    ga = new Button(new PVector(75,400),gaImg,gaImgHov);
    
    
    //initialises other approaches button
    PImage otherImg = loadImage("images/about/other.png");
    otherImg.resize(400,65);
    
    PImage otherImgHov = loadImage("images/about/otherHover.png");
    otherImgHov.resize(400,65);
    
    other = new Button(new PVector(525,400),otherImg,otherImgHov);
    
    //load title image
    title = loadImage("images/about/title.png");
    title.resize(0,100);

  }
  
  void draw(){
    background(0);
    //draw title
    image(title, 250, 100);
    
    //draw buttons
    tsp.draw();
    ga.draw();
    other.draw();
    
    //draw back button
    back.draw(); 
  }
    
  
  void mousePressed(){
    if (back.mouseOver()){
      //change page to home page
      manager.page = "home";
    }
    
    if (tsp.mouseOver()){
      //change page to TSP about page
      manager.page = "tspabo"; 
    }
    if (ga.mouseOver()){
      //change page to GA about page
      manager.page = "gaabo"; 
    }
    if (other.mouseOver()){
      //change page to other approaches about page
      manager.page = "otherabo"; 
    }

    
  }
  
  
  
}
