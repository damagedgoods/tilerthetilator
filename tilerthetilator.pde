PImage origin;

int cols = 20;
int rows = 20;

int x_side, y_side;
int t=0;
int img_pointer = 0;

String[] imgs = {"M.png", "k.png", "S.png", "R.png", "gatini.png"};

String[][] tiles = {
  {"s4", "s3", "s2", "s1", "s0"},
  {"t4", "t3", "t2", "t1", "t0"}  
};

PShape[] tileShape = new PShape[5];

int tileSet = 0;

PShape s1, s2, s3, s4, t1, t2, t3, t4;

void setup() {
  size(300, 300);  
  
  //println("Iniciando: ",x_side,y_side);

  // Pinto la letra
  //image(origin, 0, 0);
  
  // Pinto el grid
  /*
  fill(204, 102, 0);
  for (int i=1; i<= cols; i++) {    
    rect(i*x_side, 0, 1, height);
  }
  for (int i=1; i<= rows; i++) {
    rect(0, i*y_side, width, 1);
  }
  */
  
  initTileSet();
}

void draw() {
  
    origin = loadImage(imgs[img_pointer]);
    origin.loadPixels();

    t++;    
    //cols = int(100*sin(t*10))+1;
    //rows = cols;
    x_side = int(width/cols);
    y_side = int(height/rows);
    
    background(255);
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {      
        int value = processTile(i,j);
        drawPixel3(i,j, value);
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

void drawPixel(int i, int j, int value) {
  noStroke();  
  fill(value);
  circle(i*y_side + y_side/2, j*x_side + x_side/2, 15); 
}

void drawPixel2(int i, int j, int value) {
    PShape s;
    fill(0);
    noStroke();
    strokeWeight(3);
    if (value < 64) {      
      fill(0);
      shape(s4, i*y_side, j*x_side, x_side, y_side);
    } else if (value < 128) {
      fill(100);
      shape(s3, i*y_side, j*x_side, x_side, y_side);
    } else if (value < 192) {
      fill(200);
      shape(s2, i*y_side, j*x_side, x_side, y_side);
    } else { 
    }
}

void drawPixel3(int i, int j, int value) {
    PShape s;
    fill(0);
    noStroke();
    strokeWeight(3);
    
    int value_gap = int(255 / tileShape.length)+1;
    //println(value, value_gap, int(value/value_gap));
    
    fill(0);
    s = tileShape[int(value/value_gap)];
    shape(s, i*y_side, j*x_side, x_side, y_side);
    
    /*
    if (value < 64) {      
      fill(0);
      shape(t4, i*y_side, j*x_side, x_side, y_side);
    } else if (value < 128) {
      fill(100);
      shape(t3, i*y_side, j*x_side, x_side, y_side);
    } else if (value < 192) {
      fill(200);
      shape(t2, i*y_side, j*x_side, x_side, y_side);
    } else { 
    }
    */
}

void initTileSet() {
  for (int i=0; i<tiles[tileSet].length; i++) {
    tileShape[i] = loadShape(tiles[tileSet][i]+".svg");
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
