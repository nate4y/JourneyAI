int psize = 200, pops = 5;
Population[] p;
Wall wall;
Walls walls;
float[] wallGaps, s;
int frames, GAME_WIDTH;
ArrayList<float[]> scoresByGen, avgsByGen;
Chart chart;
color[] colors, bests;
float baseRate = 0.1;

void setup(){
  GAME_WIDTH = 800;
  size(1600, 600);
  frameRate(120);
  
  wall = new Wall((float)200);
  walls = new Walls(2);
  walls.add(wall);
  wallGaps = new float[10000];
  for(int i = 0; i < wallGaps.length; i++){
    wallGaps[i] = (random(GAME_WIDTH - 350) + 100);
  }
  
  p = new Population[pops];
  s = new float[pops];
  colors = new color[pops];
  bests = new color[pops];
  setRandColors();
  for(int i = 0; i < pops; i++){
    s[i] = 0;
    p[i] = new Population(psize, baseRate, colors[i], bests[i], 2 + (float)i/4);
    baseRate -= 0.02;
  }
  
  scoresByGen = new ArrayList<float[]>();
  avgsByGen = new ArrayList<float[]>();
  chart = new Chart();
  
  frames =  0;
}

void setRandColors(){
  for(int i = 0; i < pops; i++){
    colors[i] = color((int)random(255), (int)random(255), (int)random(255));
    bests[i] = color((int)random(255), (int)random(255), (int)random(255));
  }
}

boolean dead(Population[] pp){
  for(int i = 0; i < pp.length; i++) if(!pp[i].allDead()) return false;
  return true;
}

void draw(){  
  background(255);
 
  
  PFont f = createFont("Arial", 16, true);
  textFont(f, 724);
  textAlign(CENTER, CENTER);
  fill(0, 0, 0, 64);
  text(gen, GAME_WIDTH/2, height/2);
  textFont(f, 32);
  fill(0);
  textAlign(CENTER, TOP);
  text(frames, 70, 30);
  text("Wall Speed: " + nf(walls.walls.get(0).v, 1, 3), GAME_WIDTH - 200, 30);
  text("Frame Rate: " + nf(frameRate, 1, 1), width - 200, 30);
  
  line(0, 0, GAME_WIDTH, 0);
  line(GAME_WIDTH, 0, GAME_WIDTH, height);
  line(0, height, GAME_WIDTH, height);
  line(0, 0, 0, height);  
  
  if(!dead(p)){
    
    for(int i = 0; i < p.length; i++){
      p[i].show();
      p[i].update();
      if(!p[i].allDead()) s[i]++;
    }
    frames++;
    
    walls.show();
    walls.update();
    chart.show();
  }else{
    char t = 'A';
    float[] temp = new float[pops];
    for(int i = 0; i < pops; i++){
       p[i].calcSum();
       p[i].natSel();
       p[i].mutateBabies();
       
       float avg = p[i].fitnessSum / (float)psize;
       print("GEN " + t + gen + " || Highest score: " + nf(s[i], 4, 2));
       if(gen > 1) println(" || Average score: " + nf(avg, 4, 2) + " || Mutation Rate: " + nf(p[i].m, 1, 3) + " || Speed Limit: " + nf(p[i].lim, 2, 2) + " || Score Increase: " + nf(s[i] - scoresByGen.get(gen - 2)[i]));
       else println(" || Average score: " + nf(avg, 4, 2) + " || Mutation Rate: " + nf(p[i].m, 1, 3) + " || Speed Limit: " + nf(p[i].lim, 2, 2));
       
       t++;
       temp[i] = s[i];
    }
    println();
    
    
    scoresByGen.add(temp);
    
    chart.update();
   
    gen++;  
    
    frames = 0;
    
    for(int i = 0; i < pops; i++){
      s[i] = 0;
    }
    
    walls = new Walls(2);
    walls.add(wall);
    walls.reset();
  }
}
