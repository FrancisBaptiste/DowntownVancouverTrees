import processing.pdf.*;

Table table;
PFont font;

ArrayList<String> treeNames;

int[] treeTotals;

void setup(){
  
  //init the array
  treeNames = new ArrayList<String>();
  
  //set font
  font = createFont("Arial", 16, true);
  
  //get the data
  table = loadTable("StreetTrees_Downtown.csv", "header");
  
  //print to console the total rows of data
  println(table.getRowCount() + " total rows in table");
  
  //i for counting tree types
  int i = 0;
  
  //to through the data, save each unique tree type, print it to console
  for (TableRow row : table.rows()){
    String name = row.getString("COMMON_NAME");
    if( checkArray(name, treeNames) == false){
      treeNames.add(name);
      //println(name);
      i++;
    }
  }
  
  //init the list now that we know how many kinds of trees there are
  int totalTreeTypes = treeNames.size();
  treeTotals = new int[totalTreeTypes];
  
  //loop through each row again to count the row types
  for (TableRow row : table.rows()){
    String name = row.getString("COMMON_NAME");
    
    //loop through the treenames
    for(int ii = treeNames.size() - 1; ii >= 0; ii--){
      String thisTreeName = treeNames.get(ii);
      if( thisTreeName.equals(name) == true ){
        treeTotals[ii]++;
      }
    }
  }
  
  //what's the total tree types
  println(i + " different types of trees in downtown vancouver");
  
  //set some drawing info
  noLoop();
  size(800,800,PDF, "trees.pdf");
  stroke(0);
  fill(0);
  textFont(font,9);
  background(255, 255, 255);  
}

void draw(){
  background(255,255,255);  
  
  //make the origin the center of the stage
  translate(width/2, height/2);
  
  //loop through the tree types
  for(int i = treeNames.size() - 1; i >= 0; i--){
    String thisTree = treeNames.get(i);
    float rad = radians(2);
    rotate(rad);
    stroke(230);
    line(50, 0, 230, 0);
    
    //for the reverse
    //line(0, 0, 230, 0);
    
    stroke(0, 150 + treeTotals[i], 0);
    line(50, 0, 50 + treeTotals[i]*2, 0);
    
    //reversed
    /*
    if(treeTotals[i]*3 > 230){
      line(230, 0, 0, 0);
    }else{
      line(230, 0, 230 - treeTotals[i]*3, 0);
    }
    */
    
    text(thisTree, 230, 0);
  }
  exit();
}

//for capturing the image
void mousePressed(){
  saveFrame("test-##.png");
  endRecord();
}

//this is a function for checking if a string exists in an array
boolean checkArray(String thisString, ArrayList<String> thisArray){ 
  for(int i = thisArray.size() - 1; i >= 0; i--){
    String thisVal = thisArray.get(i);
    if( thisVal.equals(thisString) == true ){
      return true;
    }
  }
  return false;
}