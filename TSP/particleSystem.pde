

class ParticleSystem{
  
  Particle[] particles;
  
  int num;
  
  ParticleSystem(int n){
    num = n;
    //initialise particle array
    particles = new Particle[num];
    
    for (int i=0;i<num;i++){
      //adds particles to array
      particles[i] = new Particle();
    }

  }
  
  void update(){
    //updates all particles
    for (Particle p: particles){
      //accelerate toward the mouse
      PVector mouseToP = PVector.sub(p.pos, new PVector(mouseX,mouseY));
      mouseToP.setMag(-0.3);
      p.acc = mouseToP;
      p.update();
    }
    
  }
  
  void draw(){
    for (int i=0;i<num;i++){
      //draws each particle
      particles[i].draw();
      //draws line between each particle
      stroke(255);
      line(particles[i].pos.x,particles[i].pos.y,particles[(i+1)%num].pos.x,particles[(i+1)%num].pos.y);
    }
  }
  
  
}
