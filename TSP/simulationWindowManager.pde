

class SimulationWindowManager{
  Manager manager;
  Button back;
  Button run;
  Button speedOne;
  Button speedHalf;
  Button speedTwo;
  Button skip;
  Network network;
  CityInputManager cityInpMan;
  Population population;
  float currentSpeed = 1;
  
  // Initialising sliders
  Slider populationSizeSlider = cp5.addSlider("populationSize").setRange(2,300).setValue(2).setPosition(755,50).setSize(100,10)
  .setCaptionLabel("Population Size").setDecimalPrecision(0);
  Slider mutationRateSlider = cp5.addSlider("mutationRate").setRange(0,100).setValue(50).setPosition(755,100).setSize(100,10)
  .setCaptionLabel("Mutation Rate");
  Slider mutationIntensitySlider = cp5.addSlider("mutationIntensity").setRange(0,100).setValue(50).setPosition(755,150)
  .setSize(100,10).setCaptionLabel("Mutation Intensity");
  Slider numberOfGenerationsSlider = cp5.addSlider("numberOfGenerations").setRange(2,100).setValue(2).setPosition(755,200)
  .setSize(100,10).setCaptionLabel("Number Of Generations").setDecimalPrecision(0);
  Slider elitismRateSlider = cp5.addSlider("elitismRate").setRange(0,100).setValue(50).setPosition(755,250).setSize(100,10)
  .setCaptionLabel("Elitism Rate");
  
  
  
  SimulationWindowManager(Manager m) {
    manager = m;
    
  }
  
  void setup(){
    //initialising the back button
    PImage backImg = loadImage("images/back.png");
    backImg.resize(75,0);
    
    PImage backImgHov = loadImage("images/backHover.png");
    backImgHov.resize(75,0);
    
    back = new Button(new PVector(10,10), backImg, backImgHov);
    
    //initialising the run button
    PImage runImg = loadImage("images/simulationWindow/run.png");
    runImg.resize(200,0);
    
    PImage runImgHov = loadImage("images/simulationWindow/runHover.png");
    runImgHov.resize(200,0);
    
    run = new Button (new PVector(750,525), runImg, runImgHov);
    
    //initialising the network
    network = new Network(8);
    //initialising the population
    population = new Population(network);
    
    //initialising the city drag and drop
    cityInpMan = new CityInputManager(network);
    network.cityInpMan = cityInpMan;
    
    //position the labels of the sliders
    populationSizeSlider.getCaptionLabel().align(ControlP5.LEFT,ControlP5.TOP_OUTSIDE).setPaddingX(0);
    mutationRateSlider.getCaptionLabel().align(ControlP5.LEFT,ControlP5.TOP_OUTSIDE).setPaddingX(0);
    mutationIntensitySlider.getCaptionLabel().align(ControlP5.LEFT,ControlP5.TOP_OUTSIDE).setPaddingX(0);
    numberOfGenerationsSlider.getCaptionLabel().align(ControlP5.LEFT,ControlP5.TOP_OUTSIDE).setPaddingX(0);
    elitismRateSlider.getCaptionLabel().align(ControlP5.LEFT,ControlP5.TOP_OUTSIDE).setPaddingX(0);
    
    //speed buttons initialisation
    PImage halfImg = loadImage("images/simulationWindow/halfX.png");
    halfImg.resize(50,40);
    PImage oneImg = loadImage("images/simulationWindow/oneX.png");
    oneImg.resize(50,50);
    PImage twoImg = loadImage("images/simulationWindow/twoX.png");
    twoImg.resize(50,50);
    
    PImage halfImgHov = loadImage("images/simulationWindow/halfXHover.png");
    halfImgHov.resize(50,40);
    PImage oneImgHov = loadImage("images/simulationWindow/oneXHover.png");
    oneImgHov.resize(50,50);
    PImage twoImgHov = loadImage("images/simulationWindow/twoXHover.png");
    twoImgHov.resize(50,50);
    
    speedHalf = new Button(new PVector(350,552),halfImg,halfImgHov);
    speedOne = new Button(new PVector(400,550),oneImg,oneImgHov);
    speedTwo = new Button(new PVector(450,550),twoImg,twoImgHov);
    
    //skip button initialisation
    PImage skipImg = loadImage("images/simulationWindow/skip.png");
    skipImg.resize(130,0);
    PImage skipImgHov = loadImage("images/simulationWindow/skipHover.png");
    skipImgHov.resize(130,0);
    
    skip = new Button(new PVector(520,540),skipImg,skipImgHov);
    
  }
  
  void draw(){
    
    
    // drawing background
    background(40);
    
    // ---Drawing boxes where elements are---
    
    //draws simulation zone
    stroke(255);
    fill(175);
    rect(25,25,700,450);
    
    if (population.isDone()){
      //makes information bar dark grey
      fill(175);
      rect(750,25,200,450);
      //makes settings bar light grey
      fill(175,75);
      rect(25,500, 700, 175);
    }
    else{
      //makes information bar ligh grey
      fill(175,75);
      rect(750,25,200,450);
      //makes settings bar dark grey
      fill(175);
      rect(25,500, 700, 175);      
    }

    
    
    // draw network
    image(network.getGraphic(),25,25);
    
    //drawing tsp
    if (!population.isDone()){
      population.update(currentSpeed);
      population.draw();
    }
        

    //drawing back buttons    
    back.draw();
    
    if (!population.isDone()){
      //draws cancel button
      rect(750,525,200,100);
      drawText("Cancel",800,600,color(255,255,255),30);
      //hides sliders
      setWidgetsVisible(false);
    }
    else{
      //draws run button
      run.draw();
      //draws city drag and drop box
      cityInpMan.draw();
    }
    
    
    
    stroke(255,0,0);
    
    // displaying live data & speed buttons
    if (!population.isDone()){
      stroke(0);
      
      //Current Generation
      
      
      drawText("Generation:", 130,520,color(255,255,255),20);
      fill(255,0,0);
      rect(35,530,200,20);
      fill(0,255,0);
      //draws progress bar for the current generation
      rect(35,530,int(200*(float(population.currentGeneration-1)/float(population.numberOfGenerations))),20);
      drawText(population.currentGeneration-1+"/"+population.numberOfGenerations,130,548,color(255,255,255),20);
      
      //Current Shortest Length
      drawText("Shortest Length : " + round(population.currentShortestLength), 130, 600,color(255,255,255),20);
      
      //Current Shortest Path
      if (population.currentBestSalesman != null){
        population.currentBestSalesman.drawPath();
      }
      
      // Showing number of salesman currently moving
      drawText("Number Of Active Salesmen : " + population.getNumberOfActiveSalesmen(), 140,640,color(255,255,255),15);
      
      
      // ------ Speed Buttons -------
      speedHalf.draw();
      speedOne.draw();
      speedTwo.draw();
      //draws circle over the current speed
      int x = 425;
      if (currentSpeed == 0.5){
        x = 375;
      }
      if (currentSpeed == 1){
        x = 425;
      }
      if (currentSpeed == 2){
        x = 475;
      }
      fill(255,0,0);
      circle(x, 535, 10);
      
      // skip button
      skip.draw();
      
    }
    

  }
  

  void mousePressed(){
    
      
     //handling widgets
     if (population.isDone()){
       //sets settings of GA based on the sliders
       population.populationSize = int(populationSizeSlider.getValue());
     
       population.mutationRate = (mutationRateSlider.getValue()) / 100.0;

       population.mutationIntensity = (mutationIntensitySlider.getValue()) / 100.0;
     
       population.elitismRate = (elitismRateSlider.getValue()) / 100.0;
     
       population.numberOfGenerations = int(numberOfGenerationsSlider.getValue());
       population.currentGeneration = population.numberOfGenerations + 1;
       
       //triggers clicking of city input manager if the simulation zone is clicked
       if (mouseX > 25 && mouseY > 25 && mouseY < 450+25 && mouseX < 700+25){
         if (network.mousePressed() == false){
           cityInpMan.mousePressed();
         }
       }
     
     //triggers city drag and drop to work
     if (cityInpMan.mouseOver()){
       cityInpMan.mousePressed();
     } 
     
     }
     
     //setting current speeds when speed buttons are pressed
     if (!population.isDone()){
       if (speedHalf.mouseOver()){
         currentSpeed = 0.5;
       }
       if (speedOne.mouseOver()){
         currentSpeed = 1;
       }     
       if (speedTwo.mouseOver()){
         currentSpeed = 2;
       }
       
       population.setSpeed(currentSpeed);
       
       //skips generation
       if (skip.mouseOver()){
         population.nextGeneration(currentSpeed);
       }       
     }
     
     //goes back to home page if back button is pressed
     if (back.mouseOver()){
       manager.page = "home";
     }
     // runs/cancels simulation
     if (run.mouseOver()){
       if (network.numberOfNodes > 2 && population.isDone()){
         
         // reseting population and running simulation
         population.clearPop();
         population.randomInit();
         population.runAlgorithm();
       }
       else{
         //cancels simulation
         population.clearPop();
         population.stopSimulation();
         currentSpeed = 1;
       }
     }
     




  }
  
  
  void setWidgetsVisible(boolean b){
    //makes sliders visible/invisible
    populationSizeSlider.setVisible(b);
    mutationRateSlider.setVisible(b);
    mutationIntensitySlider.setVisible(b);
    numberOfGenerationsSlider.setVisible(b);
    elitismRateSlider.setVisible(b);
    
  }
  

  
  
}
