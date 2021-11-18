class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  int rad;
  
  Particle(){
    //initialises random position
    pos = new PVector(random(10,width-10), random(10,height-10));
    //initialises random velocity
    vel = PVector.random2D();
    acc = new PVector(0,0);
    rad = 5;
  }
  
  void update(){
    // collision detection
    //bounces of the walls
    
    //left hand wall
    if (pos.x - rad <= 0){
      pos.x = rad + 1;
      vel.x *= -1;
    }
    //right hand wall
    if (pos.x + rad >= width){
      pos.x = width - rad - 1;
      vel.x *= -1;
    }
    //top wall
    if (pos.y - rad <=0){
      pos.y = rad + 1;
      vel.y *= -1;
    }
    //bottom wall
    if (pos.y + rad >= height){
      pos.y = height - rad - 1;
      vel.y *= -1;
    }
    
    //increases velocity
    vel.add(acc);
    //limits velocity
    vel.limit(10);
    //damping
    vel.mult(0.999999);
    //moves the particles
    pos.add(vel);
    
  }
  
  void draw(){
    //draws particle in white
    fill(255);
    circle(pos.x, pos.y,rad*2);
  }
  
  
}
