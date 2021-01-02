PImage origin;

int cols = 12;
int rows = 12;

int x_side, y_side;
int t=0;
int img_pointer = 0;

String[] imgs = {"M.png", "k.png", "S.png", "R.png"};

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
  
}

void draw() {
  
    origin = loadImage(imgs[img_pointer]);
    origin.loadPixels();

    t++;    
    //int pix_size = int(t/5);
    int pix_size = 5;
    cols = int(t/2)+1;
    rows = int(t/2)+1;
    x_side = int(width/cols);
    y_side = int(height/rows);
    
    println("Iniciando ", t, cols, rows);
    background(255);
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {      
        //println(i+", "+j+": "+processTile(i,j));
        fill(processTile(i,j));
        noStroke();
        circle(i*y_side + y_side/2, j*x_side + x_side/2, pix_size);
      }  
    }
    if (t == 100) t = 0;

}

int processTile(int i, int j) {
  
  int accum = 0; 
  
  for (int t=j*y_side; t<(j+1)*y_side; t++) {
    for (int s=i*x_side; s<(i+1)*x_side; s++) {
      //println("Tile: ",i,j," Pixel: "+s,t);
      color c = origin.pixels[s+t*width];
      //color c = origin.get(s, t);
      //println(c, brightness(c), red(c), green(c), blue(c));
      accum += brightness(c);
    }
  }
  
  //println(accum, x_side, y_side, accum/(x_side*y_side));
  int result = int(accum/(x_side*y_side)); // Saco la media: todo lo acumulado entre el número de pixels del tile
  return result;
}

void mouseClicked() {
  img_pointer++;
  if (img_pointer >= imgs.length) img_pointer = 0;
}
