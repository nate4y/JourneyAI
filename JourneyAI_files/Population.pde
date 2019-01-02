int gen = 1;

class Population{
  
  Player[] players;
  
  int fitnessSum;
  int bestPlayer = 0;
  color a, b;
  float m, lim;
  
  Population(int size, float mr, color all, color best, float l){
    players = new Player[size];
    a = all;
    b = best;
    m = mr;
    lim = l;
    for(int i = 0; i < size; i++) players[i] = new Player(mr, a, l);
  }
 
  void show(){
    for(int i = 0; i < players.length; i++) players[i].show();
  }
  
  void update(){
    for(int i = 0; i < players.length; i++) players[i].update();
  }
  
  boolean allDead(){
    for(int i = 0; i < players.length; i++){
      if(!players[i].dead) return false;
    }
    return true;
  }
  
  void calcSum(){
    fitnessSum = 0;
    for(int i = 0; i < players.length; i++){
      fitnessSum += players[i].timeFit;
    }
  }
  
  void natSel(){
    Player[] newPlayers = new Player[players.length];
    calcSum();
    setBest();
    
    newPlayers[0] = players[bestPlayer].getBaby();
    newPlayers[0].isBest = true;
    //newPlayers[0].c = b;
    for(int i = 1; i < newPlayers.length; i++){
      Player parent = selectParent();
      newPlayers[i] = parent.getBaby();
      newPlayers[i].c = a;
    }
    
    players = newPlayers.clone();
  }
  
  Player selectParent(){
    float rand = random(fitnessSum);
    float running = 0;
    
    for(int i = 0; i < players.length; i++){
      running += players[i].timeFit;
      if(running > rand) return players[i];
    }
    return null;
  }
  
  void mutateBabies(){
    for (int i = 1; i< players.length; i++) {
      players[i].b.mutate();
    }
  }
  
  void setBest(){
    int max = 0, index = 0;
    for(int i = 0; i < players.length; i++){
      if(players[i].timeFit > max){
        max = players[i].timeFit;
        index = i;
      }
    }
    
    bestPlayer = index;
  }
}
