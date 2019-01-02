class Brain{
  PVector[] directions;
  int step = 0;
  float r;
  
  Brain(int size, float rate){
    directions = new PVector[size];
    randomize();
    r = rate;
  }
  
  void randomize(){
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }  
  
  Brain clone(){
    Brain clone = new Brain(directions.length, r);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }
  
  void mutate() {
    float mutationRate = r;//chance that any vector in directions gets changed
    for (int i =0; i< directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //set this direction as a random direction 
         float randomAngle = random(2*PI);
         directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
