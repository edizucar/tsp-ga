Manager manager;
import java.util.Collections;
import controlP5.*;

ControlP5 cp5;

void setup(){
  
  //defining the starting variables
  cp5 = new ControlP5(this);
  size(1000,700);
  frameRate(60);
  manager = new Manager();
  
}

void draw() {
  
  // this is the drawing loop
  manager.update();
    

}


void mousePressed(){
  // if the mouse is pressed, this function is automatically called by processing
  manager.mousePressed();
}

void shuffle(ArrayList<?> s){
  //shuffles an array
  Collections.shuffle(s);
}

Salesman[] PMX(Salesman p1, Salesman p2){
  int n = p1.network.numberOfNodes;
  // generates 2 random separators
  int c1 = int(random(0,p1.path.length-1));
  int c2 = int(random(c1,p1.path.length));
  
  // initialises offspring
  Salesman o1 = new Salesman(p1.network);
  Salesman o2 = new Salesman(p2.network);
  

  // initialises offspring's paths
  for(int i=0;i<n;i++){
    o1.path[i] = -1;
    o2.path[i] = -1;
  }
  
  //swaps paths from parents
  for(int i=c1;i < c2;i++){
    o1.path[i] = p2.path[i];
    o2.path[i] = p1.path[i];
  }
  int x;
  // perform copying of genes from parents
  for (int i=0;i<n;i++){
    // uses mapping to swap any genes which overlap
    if (o1.path[i] == -1){
      x=p1.path[i];
      while(isIn(o1.path,x)){
        x = p1.path[linearSearch(p2.path,x)];
      }
      o1.path[i] = x;
    }
    
    //does the same for o2 as it does for o1 above
    if (o2.path[i] == -1){
      x=p2.path[i];
      while(isIn(o2.path,x)){
        x = p2.path[linearSearch(p1.path,x)];
      }
      o2.path[i] = x;
    }
  }
  // setting up array to return
  Salesman[] offspring = new Salesman[2];
  offspring[0] = o1;
  offspring[1] = o2;
  // return both offspring
  return offspring;
}

int sum(int[] arr){
  //finding the sum of an array of integers
  int total = 0;
  for (int i=0;i<arr.length;i++){
    total += arr[i];
  }
  return total;
}

boolean isIn(int[] arr,int item){
    // finds whether an array contains a specific item
    for (int i=0;i<arr.length;i++){
      if (arr[i] == item){
        return true;
      }
    }
    return false;
}

int linearSearch(int[] arr, int t){
        // if array is Null 
        if (arr == null) { 
            return -1; 
        } 
  
        // find length of array 
        int len = arr.length; 
        int i = 0; 
  
        // traverse in the array 
        while (i < len) { 
  
            // if the i-th element is t 
            // then return the index 
            if (arr[i] == t) { 
                return i; 
            } 
            else { 
                i = i + 1; 
            } 
        } 
        return -1;   
}

void drawText(String s, int x, int y, color colour, int size){
  //setting font up
  textFont(createFont("calibri",size));
  //setting colour
  fill(colour);
  textAlign(CENTER);
  //draws text on the screen
  text(s,x,y);
  
}
