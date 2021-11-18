


class HomeManager{
  Button startSimulation;
  Manager manager;
  PImage title;
  Button quit;
  Button tutorial;
  Button about;
  ParticleSystem partSys;
  
  HomeManager(Manager m){
    manager = m;
    //initialises particle system with 7 particles
    partSys = new ParticleSystem(7);    
  }
  
  void setup(){
    
    // setting up the start simulation button
    PImage simulImg = loadImage("images/homePage/startSimulation.png");
    simulImg.resize(300,0);  

    PImage simulImgHov = loadImage("images/homePage/startSimulationHover.png");
    simulImgHov.resize(300,0); 
    
    startSimulation = new Button(new PVector(width/2 - 150,height/2 - 100),simulImg,simulImgHov);
    
    // setting up quit button
    PImage quitImg = loadImage("images/homePage/quit.png");
    quitImg.resize(50,50);
    
    PImage quitImgHov = loadImage("images/homePage/quitHover.png");
    quitImgHov.resize(60,60);
    
    quit = new Button(new PVector(25,25),quitImg,quitImgHov);
    
    // setting up tutorial button
    PImage tutImg = loadImage("images/homePage/tutorial.png");
    tutImg.resize(145,0);
    
    PImage tutImgHov = loadImage("images/homePage/tutorialHover.png");
    tutImgHov.resize(145,0);
    
    tutorial = new Button(new PVector(width/2 - 150, height/2 + 10),tutImg,tutImgHov);    
    
    // setting up about button
    PImage aboutImg = loadImage("images/homePage/about.png");
    aboutImg.resize(145,0);
    
    PImage aboutImgHov = loadImage("images/homePage/aboutHover.png");
    aboutImgHov.resize(145,0);
    
    about = new Button(new PVector(width/2 +5, height/2+10),aboutImg,aboutImgHov);    
        
    
    
    // setting up the title
    title = loadImage("images/homePage/title.png");
    title.resize(500,0);
    
  }
  
  void draw(){
    // Draw Background black
    background(0);

    partSys.draw();
    // Drawing buttons
    
    startSimulation.draw();
    quit.draw();
    tutorial.draw();
    about.draw();
    
    // Drawing title
    image(title,width/2 - 250, 100);
  }
  void update(){
    partSys.update();

  }
  

  void mousePressed(){
     if (startSimulation.mouseOver()){
       //changing page to simulation page
       manager.page = "simulation";
     }
     if (tutorial.mouseOver()){
       //changing page to tutorial page
       manager.page = "tutorial";  
     }
     if (about.mouseOver()){
       //changing page to about page
       manager.page = "about";
     }
      
     if (quit.mouseOver()){
       //quit the program
       exit();
     }    
    
    
  }
  
}
