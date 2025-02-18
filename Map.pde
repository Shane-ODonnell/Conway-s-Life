
class Map {
  int size;
  int iterator = 0;
  Cell [] grid;
  int prevTime = millis();

  Map(int S) {
    size = S;
    grid = new Cell [size*size];
    w = width/size;

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        grid[iterator] = new Cell(i, j, iterator);         //initalise every tile in the grid
        iterator++;
      }
    }
  }//close constructor

  int getIndex(int i, int j) {                                 //provided a unique i and j value
    int it = 0;

    for (int ip = 0; ip < size; ip++) {
      for (int jp = 0; jp < size; jp++) {
        if (grid[it].i == i && grid[it].j == j) {
          return it;                                           //return the position of the tile with that i and j value
        }
        it++;
      }
    }

    return -1;                                                 // unless no such tile exists.
  }

  //-------------------------------------------------------------------------------------------

  void show() {
    for (int iterator = 0; iterator < size*size; iterator++) {
      grid[iterator].show();         //initalise every tile in the grid
    }
  }//close show

  //-------------------------------------------------------------------------------------------

  void rand() {
    int count = floor(random(size * size));
    for (int it = 0; it < count; it++) {
      grid[floor(random(size*size))].life();
    }
  }

  //-------------------------------------------------------------------------------------------

  void toggleCell() {
    int index = 0;
    while (!grid[index].mouseOver()) {
      //increase index till weve found the right cell
      index++;
    }
    grid[index].alive = !grid[index].alive;
  }

  //-------------------------------------------------------------------------------------------
  
  void refresh() {
    int neighbours;
    int i, j;
    boolean next[] = new boolean [size*size];

    if ((millis() - prevTime) > 300) {
      prevTime = millis();

      for (int it = 0; it < iterator; it++) {
        neighbours = 0;
        i = grid[it].i;
        j = grid[it].j;

        //iterate through every cell and
        //then for every cell iterate through the sorrounding cells and count the number of live ones.

        for (int iPos = i - 1; iPos <= i + 1; iPos++) {
          for (int jPos = j - 1; jPos <= j + 1; jPos++) { //------ iterate through the 8 tiles around the bomb
            int dex = getIndex(iPos, jPos); //-------------------- store position of tile under inspection
            if (dex != -1 && dex != it) {//---------------------- if the position exists and not containing the bomb
              if (grid[dex].alive)
                neighbours++;//-------------------------------- increase value of tile at index
            }
          }// close j loop
        }// and close i loop


        //then depending on the number of sorrounding live cells, either kill or bring to life the cell under inspection
        if (start) {
          if (neighbours > 3  ||  neighbours < 2) // death by under or overpopulation
            next[it] = false;
          else if ( neighbours == 3) { // reproduction
            next[it] = true;
          }
          if (neighbours == 2 && grid[it].alive)
            next[it] = true;
        }// state change processed
      }
      if (start)
        for (int it = 0; it <iterator; it++) {
          if ( next[it])
            grid[it].life();
          else
            grid[it].dead();
        }
    }
    show();
  }//close refresh
}
