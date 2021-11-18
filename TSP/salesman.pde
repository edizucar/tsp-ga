class Salesman{
  int[] path;
  Network network;
  int progress = 0;
  PVector pos;
  PVector startNode,endNode,movementVec;
  boolean running = false;
  float movementSpeed = random(3,4);
  
  Salesman(Network n) {
    network = n;
    //initialising path to empty array
    path = new int[network.numberOfNodes];
  }
  
  
  float getPathLength(){
    //finds the path length
    float len = 0;
    for (int i=0;i <network.numberOfNodes-1;i++){
      //adds length between each node to accumulator
        len += network.distanceBetween(path[i], path[i+1]);
    }
    return len;
    
  }
  
  void randomPathInit(){
    path = new int[network.numberOfNodes];
    // generate unit array from 0 to n-1 e.g. 0,1,2,3,4,5 for n=6
    for (int i=0;i < network.numberOfNodes;i++){
      path[i] = i;
    }    
    
    // shuffle list by swapping each item in the array with a random other item
    for (int i=0;i < network.numberOfNodes;i++){
      int temp,rand=int(random(network.numberOfNodes-1));
      temp = path[i];
      path[i] = path[rand];
      path[rand] = temp;
    }
    
    
  }
  
  void moveToNext(){
    //incrument progress
    progress++;
  }
  
  void displayPath(){
    //prints out the path array in a nice format
    String s = "";
    for (int i=0;i<network.numberOfNodes;i++){
      s += " " + path[i] + " ";
    }
    println(s);
  }
  
  void update(){
    if (progress < network.numberOfNodes - 1){
      //moves along by the movement vector
      pos.add(movementVec);
      
      if (PVector.sub(pos,endNode).mag() < 5){
        // goes to the next node
        moveToNext();
        
        if (progress < network.numberOfNodes - 1){
          //updating the start and end nodes
          startNode = network.cities.get(path[progress]).copy();
          endNode = network.cities.get(path[progress + 1]).copy();
          //changes the direction in which the salesman moves in
          movementVec = PVector.sub(endNode,startNode).setMag(movementSpeed);
        
          pos = startNode.copy();          
        }
        
        
      }
    }
    else{
      // if the salesman reaches the end of the path, end the simulation
      running = false;
    }
    
  }
  
  void startSimulation(){
    //initialises all variables necessary for simulation to start
    progress = 0;
    startNode = network.cities.get(path[0]).copy();
    endNode = network.cities.get(path[1]).copy();
    movementVec = PVector.sub(endNode,startNode).setMag(movementSpeed);
    
    pos = startNode.copy();
    //set running to true to trigger simulation
    running = true;
    
  }
  
  void setSpeed(){
    //sets magnitude of salesmans movement vector
    movementVec.setMag(movementSpeed);
  }
  
  void draw(){
    //draws green circle at location of salesman
    fill(69,200,69);
    stroke(0);
    circle(pos.x,pos.y,10);
  }
  
  void mutate(float mutationIntensity){
    //similar to randomised initialisation code but only performs swaps on certain items of the array
    for (int i=0;i<network.numberOfNodes;i++){ 
      //only random number of genes are swapped
      if (random(0,1) <= mutationIntensity){
        int temp,rand=int(random(network.numberOfNodes - 1 + 0.999));
        //swapping genes
        temp = path[i];
        path[i] = path[rand];
        path[rand] = temp;
      }
      
    }
  }
  
  void setPath(int[] p){
    //sets path
    path = p;
  }
  
  void drawPath(){
    for (int i=0;i<network.numberOfNodes-1;i++){
      //set line to red
      stroke(255,0,0);
      //draw line between adjacent nodes
      line(network.cities.get(path[i]).x,network.cities.get(path[i]).y,network.cities.get(path[i+1]).x,network.cities.get(path[i+1]).y);
    }
  }
  
  
}
