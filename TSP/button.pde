class Button{
  
  PVector pos;
  PImage img, imgHover;
  boolean active = true;
  
  Button (PVector position,PImage image, PImage imageHover){
    // initialising position and images
    pos = position;
    img = image;
    imgHover = imageHover;
    
  }
  
  void draw(){
    //draws normal image if the mouse isnt over it
    if (!this.mouseOver() && active){
      image(img, pos.x,pos.y);
    }
    else if (this.mouseOver() && active){
      //draws its 'hover' image when the mouse is hovering over it
      image(imgHover,pos.x,pos.y);
    }
    
    
  }
  
  boolean mouseOver(){
    // returns true if co-ords of mouse are inside the area of the button and the button is active
    return ((mouseX >= pos.x) && (mouseX <= (pos.x + img.width)) && (mouseY >= pos.y) && (mouseY <= (pos.y + img.height)) && (active));    
  }
  
  void on(){
   active = true; 
  }
  void off(){
    active = false;  
  }
  
  
  
  
}
