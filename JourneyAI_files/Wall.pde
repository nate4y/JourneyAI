class Wall{
  float x1, y1, w1;
  float x2, y2, w2;
  
  float v, a;
  
  Wall(float x){
    x1 = 0;
    y1 = 0;
    w1 = x;
    x2 = x1 + w1 + 150;
    y2 = 0;
    w2 = GAME_WIDTH - x2;
    v = 1;
    a = .095;
  }
  
  void show(){
    fill(0, 0, 255);
    rect(x1, y1, w1, 20);
    rect(x2, y2, w2, 20);
  }
  
  void update(){
    y1 += v;
    y2 += v;
    
    if(frames % 150 == 0) v += a;
  }
  
}
