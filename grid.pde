class grid {
  ArrayList<tile> tiles = new ArrayList<tile>();
  ArrayList<tile> fStack = new ArrayList<tile>();
  ArrayList<mSquare> mSquares = new ArrayList<mSquare>();
  int sizeX, sizeY;
  float drawSizeX, drawSizeY, drawPosX, drawPosY, tileSizeX, tileSizeY;
  color floorColor, wallColor;
  tile selectedTile;
  int noiseFloorPercentage = 40;
  

  grid(int _sizeX, int _sizeY, float _drawSizeX, float _drawSizeY, float _posX, float _posY) {
    sizeX = _sizeX;
    sizeY = _sizeY;
    drawSizeX = _drawSizeX;
    drawSizeY = _drawSizeY;
    drawPosX = _posX;
    drawPosY = _posY;
    tileSizeX = width/sizeX;
    tileSizeY = height/sizeY;
    floorColor = color(150, 150, 150);
    wallColor = color(0, 0, 0);
    
    popGrid();
    noiseGen();
    popM();
  }

  void show() {
    for (tile t : tiles) {
      t.show();
    }
    for (tile t : tiles) {
      t.isPath = false;
    }
    for (mSquare m : mSquares) {
      m.update();
      m.show();
    }
  }
  
  void popM() {
    for(int i = 0; i < gridY-1; i++) {
      for (int j = 0; j < gridX-1;j++) {
        mSquares.add(new mSquare(tiles.get(j+i*gridX), this));
      }
    }
  }

  void popGrid() {
    println("DrawPos: " + drawPosX);
    println("TileSize: " +tileSizeX);
    for (int i = 0; i < sizeY; i++) {
      for (int j = 0; j < sizeX; j++) {
        tile temp = new tile(j, i, drawPosX, drawPosY, tileSizeX, tileSizeY, i*sizeX+j, this);
        tiles.add(temp);
      }
    }
    
  }

  void noiseGen() {
    for (tile t : tiles) {
      int randFloor = floor(random(0, 100));
      if (randFloor < noiseFloorPercentage) {
        t.isFloor = true;
      } else {
        t.isFloor = false;
      }
    }
  }

  boolean cGenIsFloor(tile tileCheck) {
    boolean makeFloor;
    tileCheck.popNbrs();
    int wallCounter = 0;
    for (tile n : tileCheck.nbrs) {
      if (n == null) {
        //wallCounter++;
      } else {
        if (n.isFloor == false) {
          wallCounter++;
        }
      }
    }
    if (wallCounter > 4) {
      makeFloor = true;
    } else {
      makeFloor = false;
    }

    return makeFloor;
  }
  
  void iterateCell() {
    ArrayList<tile> temp = new ArrayList<tile>();
    temp = cellularGen(tiles);
    tiles = temp;
    for (tile t : tiles) {
      t.popNbrs();
    }
  }

  ArrayList<tile> cellularGen(ArrayList<tile> tGrid) {
    ArrayList<tile> cGen = new ArrayList<tile>();
    for (tile t : tGrid) {
      tile tempT = new tile(t.x, t.y, drawPosX, drawPosY, tileSizeX, tileSizeY, t.id, this);
      tempT.isFloor = cGenIsFloor(t);
      cGen.add(tempT);
    }
    return cGen;
  }
  
  void flood() {
    floodFill(selectedTile);
  }

  void floodFill(tile t) {
    fStack.add(t);
    tile current = t;
    while (fStack.size() > 0) {
      current = fStack.get(0);
      fStack.remove(current);
      if (!current.isFloor || current.flood) {
        continue;
      } else {
        current.flood = true;
        for (tile n : current.nbrs) {
          if (n != null) {
            if (n.isFloor) {
              fStack.add(n);
            }
          }
        }
      }
    }
    return;
  }

  void removeNonFlood() {
    for (tile t : tiles) {
      if (t.isFloor && !t.flood) {
        t.isFloor = false;
      }
    }
  }

  void clearFlood() {
    for (tile t : tiles) {
      t.flood = false;
    }
  }
  
  void mouseSelect() {
    for (tile t : tiles) {
      if (t.hasCursor()) {
        t.isSelected = true;
        println("id: " + t.id);
        selectedTile = t;
      } else {
        t.isSelected = false;
      }
    }
  }

  void select(tile _t) {
    selectedTile = _t;
    _t.isSelected = true;
  }

  void deSelect() {
    if (selectedTile != null) {
      selectedTile.isSelected = false;
      selectedTile = null;
    }
  }

  void autoGenCel() {
    noiseGen();
    for (int i = 0; i < 5; i++ ) {
      ArrayList<tile> temp = new ArrayList<tile>();
      temp = cellularGen(tiles);
      tiles = temp;
      for (tile t : tiles) {
        t.popNbrs();
      }
    }
    boolean valid = false;
    while (!valid) {
      int tsel = floor(random(sizeX*sizeY));
      if (tiles.get(tsel).isFloor) {
        select(tiles.get(tsel)); 
        valid = true;
      }
    }
    floodFill(selectedTile);
    removeNonFlood();
    clearFlood();
    deSelect();
  }
  
  tile getMouseTile() {
    for (tile t : tiles) {
      if (t.hasCursor()) {
        return t;
      }
    }
    return null;
  }

  void reset() {
    tiles.clear();
    popGrid();
    noiseGen();
    clearFlood();
  }
}
