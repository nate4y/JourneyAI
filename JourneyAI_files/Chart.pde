int chartX, chartY, chartW, chartH;

class Chart{
  float max, gens, min;
  
  Chart(){
    max = 0;
    min = 100000;
    gens = 0;
    chartX = GAME_WIDTH + 50;
    chartY = 150;
    chartW = width - chartX - 50;
    chartH = height - chartY - 150;
  }
  
  void show(){
    makeAxes();
    fill(0);
    stroke(0);
    line(chartX, chartY, chartX, chartH + chartY);
    line(chartX, chartH + chartY, chartX + chartW, chartH + chartY);
    drawLines();
  }
  
  void update(){
    if(gen == 1) getMin();
    getMax();
  }
  
  void drawLines(){
    if(gen < 2) return;
    getMax();
    
    for(int i = 0; i < scoresByGen.size(); i++){
      if(i == 0){
        for(int j = 0; j < scoresByGen.get(i).length; j++){
          stroke(colors[j]);
          line(chartX, chartH + chartY, chartX + ((float)(i + 1) / (gen - 1) * chartW), chartY + (1 - (scoresByGen.get(i)[j] / max)) * chartH);
          //line(chartX, chartH + chartY, chartX + ((float)(i + 1) / (gen) * chartW), chartY + (1 - (scoresByGen.get(i)[j] / max)) * chartH);
        }
      }else if (i > 0){
        for(int j = 0; j < scoresByGen.get(i).length; j++){
          stroke(colors[j]);
          line(chartX + ((float)(i) / (gen - 1) * chartW), chartY + (1 - (scoresByGen.get(i - 1)[j] / max)) * chartH, chartX + ((float)(i + 1) / (gen - 1) * chartW), chartY + (1 - (scoresByGen.get(i)[j] / max)) * chartH);
        }
      }
    }
    stroke(0);
  }
  
  void makeAxes(){
    PFont f = createFont("Arial", 16, true);
    textFont(f, 16);
    text("Generation", (GAME_WIDTH + chartX + chartW)/2 + 75, chartY + chartH + 15);
    text(gen - 1, chartX + chartW, chartY + chartH + 5);
    
    text("Score", chartX - 25, chartY + 100);
    text(nf(max, 4, 0), chartX - 25, chartY);
    
    textFont(f, 64);
    text("Progress", chartX + 150, chartY - 100);
  }
  
  void getMin(){
    for(int i = 0; i < scoresByGen.get(0).length; i++)
      if(min > scoresByGen.get(0)[i]) min = scoresByGen.get(0)[i];
  }
  
  void getMax(){
    for(int i = 0; i < scoresByGen.size(); i++){
      for(int j = 0; j < scoresByGen.get(i).length; j++){
        if(scoresByGen.get(i)[j] > max) max = scoresByGen.get(i)[j];
      }
    }
  }
}
