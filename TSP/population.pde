

class Population{
  Network network;
  ArrayList<Salesman> pop = new ArrayList<Salesman>();
  
  float elitismRate = 0.025;
  float mutationRate = 0.5;
  float mutationIntensity = 0.1;
  int numberOfGenerations = 50;
  int currentGeneration = 51;
  float[] fitnesses;
  int populationSize = 2;
  float currentShortestLength = -1;
  Salesman currentBestSalesman;
  
  
  Population(Network n){
    network = n;
  }
  
  int getNumberOfActiveSalesmen(){
    //counting the number of active salesmen
    int count = 0;
    for(Salesman s : pop){
      count += int(s.running);
    }
    return count;
  }

  void randomInit(){
    //randomly initialises all the salesmen
    for (int i=0;i<populationSize;i++){
      Salesman s = new Salesman(network);
      s.randomPathInit();
      pop.add(s);
    }
  }
  
  void clearPop(){
    // clears the population array
    pop = new ArrayList<Salesman>();  
  }
  
  
  void addSalesman(Salesman s){
    //adds a salesman to the population array
    pop.add(s);
    
  }
  
  void removeSalesman(int i){
    //removes the i-th salesman from the population
    pop.remove(i);
  }
  
  void displayPaths(int numberOfPaths){
    //checks that an invalid number of paths hasn't been entered
    if (numberOfPaths <= 0 || numberOfPaths > pop.size()){
      numberOfPaths = pop.size();
    }
    
    //displays the first n paths
    for(int i=0;i<numberOfPaths;i++){
      print(i+1+":   ");
      pop.get(i).displayPath();
    }
    
  }
  
  void update(float currentSpeed){
    if (!isDone()){
      
      if (!isRunning()){
        // move to the next generation if the current generation is finished
        nextGeneration(currentSpeed);
      }
      
      else{
        //if the generation is currently running
        // update all the salesmen who are running
        for (Salesman s : pop){
          if (s.running){
            s.update(); 
          }
        }
      }
      
      
    }
    
  }


  void startSimulation(){
    //starting the simulation for all salesmen
    for (Salesman s : pop){
      s.startSimulation();  
    }
  }
  
  void draw(){
    //draws all salesmen who are currently running
    for (Salesman s : pop){
      if (s.running){
        s.draw();
      }
    }
  }
  
  boolean isRunning(){
    //returns true if there are any salesmen still running
    boolean running  = false;
    for (Salesman s : pop){
      running = running || s.running;
    }
    return running;
  }
  
  boolean isDone(){
    //checks whether simulation is finished
    return currentGeneration > numberOfGenerations;
  }
  
  void stopSimulation(){
    //stop the salesmen from doing the simulation
    for (Salesman s : pop){
      s.running = false;
    }
    //reset all settings
    currentGeneration = numberOfGenerations + 1;
    currentShortestLength = -1;
    currentBestSalesman = null;
    
  }
  
  void mutate(){
    //mutates salesmen at random rate
    for (Salesman s : pop){
      if (random(0,1) <= mutationRate){
        s.mutate(mutationIntensity);
      }
      
    }  
  }
  
  ArrayList<Salesman> SUS(float numPointers){
    float[] fitness = new float[pop.size()];
    float[] accFitness = new float[pop.size()];
    float interval;
    float longestPath = 0;
    //putting path lengths into fitness array & finding longest path
    for (int i=0;i<pop.size();i++){
      fitness[i] = pop.get(i).getPathLength();
      
      if (fitness[i] > longestPath){
        longestPath = fitness[i];
      }
      
    }
    
    // finding the accumulated fitnesses of the salesmen
    float totalFitness = 0;
    for (int i=0;i<pop.size();i++){
      fitness[i] = sqrt(longestPath - fitness[i]);
      totalFitness += fitness[i];
      accFitness[i] = totalFitness;
    }
    
    interval = totalFitness/numPointers;
  
    float curr = random(0,interval);
    
    ArrayList<Salesman> keep = new ArrayList<Salesman>();
    
    int j;
    //perform the Stochastic Universal Sampling Algorithm
    for (int i=0;i<numPointers;i++){
      j=0;
      while (accFitness[j] < curr){
        j++;
        if (j >= accFitness.length){
          j = accFitness.length - 1;
          break;
        }
      }
      keep.add(pop.get(j));
      curr += interval;
    }
    //return the parent population
    return keep;
  }
  
  void setSpeed(float multiplier){
    //changes the current speed of the salesmen
    for (Salesman s : pop){
      s.movementSpeed = random(3*multiplier,4*multiplier);
      s.setSpeed();
    }
  }
  
  void nextGeneration(float currentSpeed){
    //finds the pool of parents with SUS
    ArrayList<Salesman> parents = new ArrayList<Salesman>(), offspring = new ArrayList<Salesman>();
    parents = SUS(pop.size());
    
    Salesman[] elites = getElites();
    
    // creating new population by performing crossover on 'parents'
    while(offspring.size()<pop.size()){
      Salesman[] o = new Salesman[2];
      o = PMX(parents.get(int(random(0,parents.size()))),parents.get(int(random(0,parents.size()))));
      offspring.add(o[0]);
      offspring.add(o[1]);
    }
    
    //shuffles the offspring array and set it to the population
    shuffle(offspring);
    pop = offspring;
    //mutate population
    mutate();
    
    //adding elites to the population
    for(int i=0;i<elites.length;i++){
      offspring.remove(0);
      offspring.add(elites[i]);
    }
    
    
    //incrument the current generation
    currentGeneration++;
    //start simulation
    startSimulation();
    //update the shortest length
    updateShortestLength();
    //set the speed of the salemen
    setSpeed(currentSpeed);
    
    //stop the salesmen if simulation is done
    if (isDone()){
      stopSimulation();
    }
    
  }
  
  void displayPop(){
    //display the paths of the entire population
    print("\n\n\n");
     for (int i=0;i<pop.size();i++){
       pop.get(i).displayPath();
     }
  }

  void runAlgorithm(){
    // initialises and runs the simulation
    currentGeneration = 1;
    startSimulation();
  }
  
  void updateShortestLength(){
    int shortestLengthIndex = 0;
    float shortestLength = pop.get(0).getPathLength();
    float fitness = -1;
    
    //finiding the salesmen with the shortest path
    // in the population
    for (int i=0;i<pop.size();i++){
      fitness = pop.get(i).getPathLength();
      if (fitness < shortestLength){
        shortestLength = fitness;
        shortestLengthIndex = i;
      }
    }
    
    
    // updating these variables
    currentBestSalesman = pop.get(shortestLengthIndex);
    currentShortestLength = shortestLength;
    
  }
  
  Salesman[] getElites(){
    
    int numberToCopy = int(pop.size()*elitismRate);
    Salesman[] elites = new Salesman[numberToCopy];
    //sort population in order of fitness
    sortPop();
    
    //get only the best n salesmen
    for(int i=0;i<numberToCopy;i++){
      elites[i] = pop.get(i);
    }
    
    //returns array of the elites
    return elites;
  }
  
  void sortPop(){
    //performing a basic bubble sort
    int n = pop.size();  
    Salesman temp;  
    
    
    for(int i=0; i < n; i++){
      for(int j=1; j < (n-i); j++){  
        //comparison is done based on path length
        // puts them in ascending order
        if(pop.get(j-1).getPathLength() > pop.get(j).getPathLength()){   
          //swap elements  
          temp = pop.get(j-1);
          pop.set(j-1,pop.get(j));
          pop.set(j,temp);  

        }  
 
      }  
    }  
  }
  
  void setPopSize(int n){
    //sets population size
    populationSize = n;
  }
  

}
