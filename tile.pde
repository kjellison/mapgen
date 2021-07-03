class tile {
  ArrayList<tile> nbrs = new ArrayList<tile>();

  int x, y, id;
  color fillColor;
  color floorC = color(100);
  color wallC = color(0);
  color selectC = color (255, 0, 0);
  color floodC = color(255, 255, 0);
  color pathC = color(255,255,0);
  float drawX, drawY, drawSizeX, drawSizeY, offX, offY;
  boolean isFloor = false;
  boolean isSelected = false;
  boolean flood = false;
  
  
  grid pGrid;
  
  //a*
  int g, h;
  tile parent;
  boolean isPath = false;
  
  //Marching Squares
  int clVal;

  tile(int _x, int _y, float _offX, float _offY, float _drawSizeX, float _drawSizeY, int _id, grid _pGrid) {
    x = _x;
    y = _y;
    drawSizeX = _drawSizeX;
    drawSizeY = _drawSizeY;
    offX = _offX;
    offY = _offY;
    drawX = x*drawSizeX+offX;
    drawY = y*drawSizeY+offY;
    fillColor = color(wallC);
    id = _id;
    pGrid = _pGrid;
  }
  
  
  int fCost() {
    return g+h;
  }
  
  void popNbrs() {
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) {
          continue;
        } else {
          if (x+j < 0 || x+j > gridX-1 || y+i < 0 || y+i >gridY-1) {
            nbrs.add(null);
          } else {
            int nid = (x+j)+(y+i)*gridX;
            nbrs.add(pGrid.tiles.get(nid));
          }
        }
      }
    }
  }
  
  tile getNbr(int dir) {
    return nbrs.get(dir);
  }


  boolean hasCursor() {
    if ((mouseX >= drawX) && (mouseX < drawX+drawSizeX) && (mouseY >= drawY) && (mouseY < drawY+drawSizeY)) {
      return true;
    } else {
      return false;
    }
  }


  void show() {
    if (isFloor) {
      fillColor = floorC;
    } else {
      fillColor = wallC;
    }

    if (flood) {
      fillColor = floodC;
    }

    if (isSelected) {
      fillColor = selectC;
    }
    
    if (isPath) {
      fillColor = pathC;
    }
    //stroke(0);
    //noStroke();
    //fill(fillColor);
    //rect(drawX, drawY, drawSizeX, drawSizeY);
  }
}
