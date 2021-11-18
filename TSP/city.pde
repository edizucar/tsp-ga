class City extends PVector{
  City(float x, float y){
    //initialises location to (x,y)
    super(x,y);
    
  }
  void draw(){
    // draws city in brown
    stroke(255);
    fill(122,50,0);
    circle(this.x,this.y,25);
  }
}
