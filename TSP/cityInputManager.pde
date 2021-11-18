
class CityInputManager{
  Network network;
  boolean full = false;
  boolean moving = false; // true if city is being dragged down by user
  City nextCity;
  PImage tip;
  
  CityInputManager(Network n){
    network = n;
    //initialise first city in the box
    nextCity = new City(800 + 50,365 + 50);
    //loading image from folder
    tip =  loadImage("images/simulationWindow/tip.png");
    //resize image
    tip.resize(150,0);
  }
  
  void draw(){
    full = network.numberOfNodes >= network.maxNodes;
    if (!full){
      //draws box in cyan if network not full
      stroke(0);
      fill(123,456,789);
      rect(800,365, 100,100,7);
      
      //if the city has been picked up set its location to the mouse
      if (moving){
        nextCity.x = mouseX;
        nextCity.y = mouseY;
        //draw city
        nextCity.draw();
      }
      else{
        //draw city in the drag and drop box
        nextCity.draw();
      }
      
    }
    else{
      //draw box in grey if network full
      stroke(0);
      fill(20,30,40);
      rect(800,365, 100,100,7);  
      
      if (mouseOver()){
        //drawing tool tip text
        stroke(0);
        fill(150,20,40);
        image(tip,mouseX,mouseY); 
      }
    }

    
    
  }
  
  boolean mouseOver(){
    //checks whether mouse is in the drag and drop box
    PVector mouse = new PVector(mouseX,mouseY);
    PVector point = new PVector(800 + 50,365 + 50);
    return (PVector.sub(mouse,point).mag() < 50);
  }
  
  void mousePressed(){
    if (moving){
      if (mouseX > 25 && mouseY > 25 && mouseY < 450+25 && mouseX < 700+25){
        //adds city to network at mouse postition
        network.addNode(new City(nextCity.x,nextCity.y));
      }
      //make a city at the drag and drop box
      nextCity = new City(800 + 50,365 + 50);
      moving = false;
    }
    else{
      if (mouseOver()){
        //picks up city
        moving = true;
      }
    }
  }
  
  
}
