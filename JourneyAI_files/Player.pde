class Player{
  PVector p;
  PVector v;
  PVector a;
  
  Brain b;
  boolean dead, isBest;
  int timeFit;
  float fitness;
  float mr;
  
  color c;
  float l;
  
  Player(float m, color co, float lim){
    b = new Brain(7000, m);
    mr = m;
    
    p = new PVector(GAME_WIDTH / 2, height - 100);
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    
    dead = false;
    isBest = false;
    c = co;
    l = lim;
  }
  
  void show(){
    stroke(0, 0, 0, 0);
    if(dead) return;
    if(isBest){
      fill(c);
      rect(p.x, p.y, 15, 15);
    }else{
      fill(c, 64);
      rect(p.x, p.y, 15, 15);
    }
    stroke(0);
  }
  
  void update(){
    if(!dead){
      move();
      timeFit++;
      dead = Collision();
    }
  }
  
  boolean Collision(){
    //check if hit side walls
    if(p.x <= 0 || p.x > GAME_WIDTH - 15 || p.y <= 0 || p.y > height - 15) return true;
    
    for(int i = 0; i < walls.walls.size(); i++){
      if(p.x < walls.walls.get(i).x1 + walls.walls.get(i).w1 && p.x > walls.walls.get(i).x1 && p.y > walls.walls.get(i).y1 - 15 && p.y < walls.walls.get(i).y1 + 20) return true; //check if hit left barrier
      if(p.x < walls.walls.get(i).x2 + walls.walls.get(i).w2 && p.x > walls.walls.get(i).x2 && p.y > walls.walls.get(i).y2 - 15 && p.y < walls.walls.get(i).y2 + 20) return true; //check if hit right barrier
    }
    
    return false;
  }
  
  void move(){
    
    if(b.directions.length > b.step){
      a = b.directions[b.step];
      b.step++;
    }
    
    v.add(a);
    v.limit(l);
    p.add(v);
  }
  
  Player getBaby(){
    Player pl = new Player(mr, c, l);
    pl.b = b.clone();
    return pl;
  }
}
