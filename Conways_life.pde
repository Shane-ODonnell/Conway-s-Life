//conways game of life
int w;
boolean start;
Map map;

void setup() {
  size(800, 800);
  background(100);
  map = new Map(50);
  start = false;
}

void draw() {
  map.refresh();
}

void mousePressed() {
  map.toggleCell(); // uncomment once map is initalised
}

void keyPressed() {
  if (key == 's') {
    start = !start;
  } else if (key == 'c') {
    setup();
  }
  else if (key == 'r')
    map.rand();
}

//------------------------------------------------------------------------------------------------------------------------------------------------

class Cell {

  int i, j, index;
  boolean alive = false;

  Cell(int I, int J, int dex) {
    i = I;
    j = J;
    index = dex;
  }

  void show() {
    if (alive)
      fill(0, 200, 150);
    else
      fill(150);

    rect(i*w, j*w, w, w);
  }

  void life() {
    alive = true;
  }

  void dead() {
    alive = false;
  }

  boolean mouseOver() {
    int x1 = i*w;
    int x2 = x1 + w;

    int y1 = j*w;
    int y2 = y1 + w;

    if (x1 <= mouseX && mouseX <= x2 && y1 <= mouseY && mouseY <= y2)
      return true;

    return false;
  }
}
