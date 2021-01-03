PImage origin;

int cols = 20;
int rows = 20;

int x_side, y_side;
int t=0;
int img_pointer = 0;

String[] imgs = {"M.png", "k.png", "S.png", "R.png"};

String[][] tiles = {
  {"s4", "s3", "s2", "s1", "s0"},
  {"t4", "t3", "t2", "t1", "t0"},
  {"u4", "u3", "u2", "u1", "u0"},
  {"v4", "v3", "v2", "v1", "v0"}
};

PShape[] tileShape = new PShape[5];
int tileSet = 0;

void setup() {
  size(300, 300);  
  initTileSet();
}

void draw() {
  
    origin = loadImage("./img/"+imgs[img_pointer]);
    origin.loadPixels();
    t++;    
    x_side = int(width/cols);
    y_side = int(height/rows);
    
    background(255);
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {      
        int value = processTile(i,j);
        drawPixels(i,j, value);
      }  
    }
    if (t == 100) t = 0;
}

int processTile(int i, int j) {
  
  int accum = 0; 
  for (int t=j*y_side; t<(j+1)*y_side; t++) {
    for (int s=i*x_side; s<(i+1)*x_side; s++) {
      color c = origin.pixels[s+t*width];
      accum += brightness(c);
    }
  }
  int result = int(accum/(x_side*y_side)); // Saco la media: todo lo acumulado entre el número de pixels del tile
  return result;
}

void drawPixels(int i, int j, int value) {
    PShape s;
    fill(0);
    noStroke();
    strokeWeight(3);
    
    int value_gap = int(255 / tileShape.length)+1;
    fill(0);
    s = tileShape[int(value/value_gap)];
    shape(s, i*y_side, j*x_side, x_side, y_side);
}

void initTileSet() {
  for (int i=0; i<tiles[tileSet].length; i++) {
    tileShape[i] = loadShape("./tiles/"+tiles[tileSet][i]+".svg");
    tileShape[i].disableStyle();
  }  
}

void mouseClicked() {
  img_pointer++;
  if (img_pointer >= imgs.length) img_pointer = 0;
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 49) {
    tileSet = 0;
    initTileSet();
  } else if (keyCode == 50){
    tileSet = 1;    
    initTileSet();
  } else if (keyCode == 51){
    tileSet = 2;    
    initTileSet();
  } else if (keyCode == 52){
    tileSet = 3;    
    initTileSet();
} else if (keyCode == 38){
    rows++;
    cols++;
  } else if (keyCode == 40){
    rows--;
    cols--;    
  } else if (keyCode == 32){
    img_pointer++;
    if (img_pointer >= imgs.length) img_pointer = 0;    
  }
}
