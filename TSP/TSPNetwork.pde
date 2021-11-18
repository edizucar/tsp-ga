class Network{
  
  ArrayList<City> cities = new ArrayList<City>();
  int maxNodes;
  int numberOfNodes = 0;
  PGraphics graphic;
  CityInputManager cityInpMan;
  
  Network(int max){
    maxNodes = max;
    //draws graphic at the start
    drawGraphic();
  }
  
  void addNode(City city) {
    if (numberOfNodes < maxNodes){
      //adds city to city array
      cities.add(city);
      numberOfNodes++;
      //redraws graphic
      drawGraphic();
    }
  }
  
  float distanceBetween(int a, int b){
    //returns the distance between two cities in the network
    return PVector.sub(cities.get(a),cities.get(b)).mag();
  }
  
  PGraphics getGraphic(){
    //returns graphic of network
    return graphic;
  }
  
  void drawGraphic(){
    graphic = createGraphics(700,450);
    graphic.beginDraw();
    graphic.stroke(255);
    //draws cities in brown
    graphic.fill(122,50,0);
    for (int i=0;i<numberOfNodes;i++){
      PVector v = cities.get(i);
      
      for (int j=0;j<numberOfNodes;j++){
        PVector v1 = cities.get(j);
        //draws a line between each city
        graphic.line(v.x - 25,v.y - 25,v1.x - 25,v1.y - 25);
      }
    }
    
    for (int i=0;i<numberOfNodes;i++){
      PVector v = cities.get(i);
      //draws a circle at each city
      graphic.circle(v.x-25,v.y-25,25);
    }
    graphic.endDraw();
    
  }
  
  
  void randomInit(int numNodes){
    //initialises n random cities into the network
    for (int i=0;i<numNodes;i++){
      this.addNode(new City(random(25,700), random(25,450)));
    }
    
  }
  
  boolean mousePressed(){ // returns true if a city is picked up false otherwise
    
    if (cityInpMan.moving == false){
      for (int i = 0; i < numberOfNodes; i++) {
        if (PVector.sub(cities.get(i),new PVector(mouseX,mouseY)).mag() <= 10){
          //if a city is clicked on, set it to moving so that it can be dragged about
          cityInpMan.nextCity = new City(mouseX,mouseY);
          cityInpMan.moving = true;
          removeNode(i);
          return true;
        }
        
      }
      
    }
    return false;
  }
  
  void removeNode(int i){
    numberOfNodes--;
    //removes node from network
    cities.remove(i);
    //redraws graphic
    drawGraphic();
    
  }
}
