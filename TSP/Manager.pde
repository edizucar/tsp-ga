

class Manager{
  HomeManager homeMan;
  SimulationWindowManager simWinMan;
  TutorialManager tutMan;
  AboutManager aboMan;
  TSPAboutManager tspAboMan;
  GAAboutManager gaAboMan;
  OtherAboutManager otherAboMan;

  // start on the home page
  String page = "home";
  
  Manager(){
    //initialising home manager
    homeMan = new HomeManager(this);
    homeMan.setup();
    
    //initialising the simulation window manager
    simWinMan = new SimulationWindowManager(this);
    simWinMan.setup();
    
    //initialing the tutorial manager
    tutMan = new TutorialManager(this);
    tutMan.setup();
    
    //initialising the about manager
    aboMan = new AboutManager(this);
    aboMan.setup();
    
    //initialising the TSP about manager
    tspAboMan = new TSPAboutManager(this);
    tspAboMan.setup();
    
    //initialising the GA about manager
    gaAboMan = new GAAboutManager(this);
    gaAboMan.setup();
    
    //initialising the Other about manager
    otherAboMan = new OtherAboutManager(this);
    otherAboMan.setup();

  }
  
  void update(){
    //set sliders on simulation page to invisible
    simWinMan.setWidgetsVisible(false);
    
    if (page == "home"){
      //updates and draws home page
      homeMan.update();
      homeMan.draw();
    }
    else if (page == "simulation"){
      // sets sliders to simulation page to visible
      simWinMan.setWidgetsVisible(true);
      //draws simulation page
      simWinMan.draw();
    }
    else if (page == "tutorial"){
      //draw tutorial page
      tutMan.draw();
    }
    else if (page == "about"){
      //draw about page
      aboMan.draw();
    }
    else if (page == "tspabo"){
      //draws TSP about page
       tspAboMan.draw();
    }
    else if (page == "gaabo"){
      //draws GA about page
      gaAboMan.draw();
    }
    else if (page == "otherabo"){
      // draws Other approaches about page
      otherAboMan.draw();
    }

    else{
      //draws a white screen if there is an error
      background(255);
    }
    
    
  }
  
  
  void mousePressed(){
    if (page == "home"){
      //triggers a click on the home page
      homeMan.mousePressed();
    }
    else if (page == "simulation"){
      //triggers a click on the simulation page
      simWinMan.mousePressed();
    }
    else if (page == "tutorial"){
      //triggers a click on the tutorial page
      tutMan.mousePressed();
    }
    else if (page == "about"){
      //triggers a click on the about page
      aboMan.mousePressed();
    }
    else if (page == "tspabo"){
      //triggers a click on the TSP page
      tspAboMan.mousePressed();
    }
    else if (page == "gaabo"){
      //triggers a click on the GA about page
      gaAboMan.mousePressed();
    }
    else if (page == "otherabo"){
      //triggers a click on the Other Approaches about page
      otherAboMan.mousePressed();
    }

    
  }
  
}
