class Walls{
 ArrayList<Wall> walls;
 int d, maxCount;
 int size, curr;
 
 Walls(int denom){
   walls = new ArrayList<Wall>();
   d = denom;
   curr = 1;
 }
 
  void add(Wall wall){
    walls.add(wall);
  }
 
 void add(){
   if(walls.get(walls.size()-1).y1 >= height / d){
     add(new Wall(wallGaps[curr]));
     curr++;
   }
 }
 
 void show(){
   for(int i = 0; i < walls.size(); i++)
     walls.get(i).show();
 }
 
 void update(){
   for(int i = 0; i < walls.size(); i++)
     walls.get(i).update();
     
     add();
 }
 
 void reset(){
   walls.get(0).y1 = 0;
   walls.get(0).y2 = 0;
   curr = 1;
   for(Wall w: walls){
     w.v = 1;
   }
 }
}
