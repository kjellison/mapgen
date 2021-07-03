class mSquare {
  ArrayList<tile> shTiles = new ArrayList<tile>();
  tile tlTile;
  grid mMap;
  float drawX, drawY, drawSizeX, drawSizeY, halfX, halfY;
  int clVal;
  color strokeColor, fillColor, floorColor, wallColor;
  PShape shp0, shp1, shp2, shp3, shp4, shp5, shp6, shp7, shp8, shp9, shp10, shp11, shp12, shp13, shp14, shp15;

  mSquare(tile _tlTile, grid _mMap) {
    tlTile = _tlTile;
    mMap = _mMap;
    popTiles();
    drawX = tlTile.drawX+tlTile.drawSizeX/2;
    drawY = tlTile.drawY+tlTile.drawSizeY/2;
    drawSizeX = tlTile.drawSizeX;
    drawSizeY = tlTile.drawSizeY;
    halfX = drawSizeX/2;
    halfY = drawSizeY/2;
    clVal();
    strokeColor = color(0, 200, 0);
    floorColor = color(200);
    wallColor = color(0);
  }

  void update() {
    tlTile = mMap.tiles.get(tlTile.id);
    shTiles.clear();
    popTiles();
    clVal();
    //8421
  }

  void popTiles() {
    shTiles.add(tlTile); //TL
    shTiles.add(mMap.tiles.get(tlTile.id+1)); //TR
    shTiles.add(mMap.tiles.get(tlTile.id+mMap.sizeX+1)); //BR
    shTiles.add(mMap.tiles.get(tlTile.id+mMap.sizeX));  //BL
    //8421
  }

  void clVal() {
    clVal = 0;
    int temp = 0;
    for (int i = 0; i < 4; i++) {
      temp = temp << 1;
      tile t = shTiles.get(i);
      int tBit = 0;
      if (!t.isFloor) {
        tBit = 1;
      }
      temp = temp | tBit;
    }
    clVal = temp;
  }


  void show() {

    /*
    bottomleft line(drawX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
     bottomrite line(drawX+drawSizeX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
     horizontal line(drawX, drawY+halfY, drawX+drawSizeX, drawY+halfY);
     vertical-- line(drawX+halfX, drawY, drawX+halfX, drawY+drawSizeY);
     topright-- line(drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY);
     topleft--- line(drawX, drawY+halfY, drawX+halfX, drawY);
     */
    //stroke(255);
    //noFill();
    //square(drawX, drawY, drawSizeX);
    //fill(255);
    //textSize(20);
    //textAlign(CENTER, CENTER);
    //text(clVal, drawX+halfX, drawY+halfY);
    
    switch (clVal) {
    case 0:
      shp0();
      break;
    case 1:
      shp1();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 2:
      shp2();
      stroke(strokeColor);
      line(drawX+drawSizeX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 3:
      shp3();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+drawSizeX, drawY+halfY);
      break;
    case 4:
      shp4();
      stroke(strokeColor);
      line(drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY);
      break;
    case 5:
      shp5();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+halfX, drawY);
      line(drawX+drawSizeX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 6:
      shp6();
      stroke(strokeColor);
      line(drawX+halfX, drawY, drawX+halfX, drawY+drawSizeY);
      break;
    case 7:
      shp7();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+halfX, drawY);
      break;
    case 8:
      shp8();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+halfX, drawY);
      break;
    case 9:
      shp9();
      stroke(strokeColor);
      line(drawX+halfX, drawY, drawX+halfX, drawY+drawSizeY);
      break;
    case 10:
      shp10();
      stroke(strokeColor);
      line(drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY);
      line(drawX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 11:
      shp11();
      stroke(strokeColor);
      line(drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY);
      break;
    case 12:
      shp12();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+drawSizeX, drawY+halfY);
      break;
    case 13:
      shp13();
      stroke(strokeColor);
      line(drawX+drawSizeX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 14:
      shp14();
      stroke(strokeColor);
      line(drawX, drawY+halfY, drawX+halfX, drawY+drawSizeY);
      break;
    case 15:
      shp15();
      break;
    }
  }

  void shp0() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
  }

  void shp1() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY);
    fill(wallColor);
    triangle(drawX, drawY+halfY, drawX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //Bottom Left
  }

  void shp2() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY);
    fill(wallColor);
    triangle(drawX+drawSizeX, drawY+halfY, drawX+drawSizeX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //Bottom Right
  }

  void shp3() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+halfY);
    fill(wallColor);
    rect(drawX, drawY+halfY, drawX+drawSizeX, drawY+drawSizeY);
  }

  void shp4() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY);
    fill(wallColor);
    triangle(drawX+drawSizeX, drawY, drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY); //Top Right
  }

  void shp5() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+halfY);
    triangle(drawX+drawSizeX, drawY+halfY, drawX+drawSizeX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //BottomRight
    triangle(drawX, drawY, drawX+halfX, drawY, drawX, drawY+halfY); //TopLeft
  }

  void shp6() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+halfX, drawY+drawSizeY); //Left
    fill(wallColor);
    rect(drawX+halfX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Right
  }

  void shp7() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(floorColor);
    triangle(drawX, drawY, drawX+halfX, drawY, drawX, drawY+halfY); //TopLeft
  }

  void shp8() {
    noStroke();
    fill(floorColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(wallColor);
    triangle(drawX, drawY, drawX+halfX, drawY, drawX, drawY+halfY); //TopLeft
  }

  void shp9() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+halfX, drawY+drawSizeY); //Left
    fill(floorColor);
    rect(drawX+halfX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Right
  }
  void shp10() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(floorColor);
    triangle(drawX+drawSizeX, drawY, drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY); //Top Right
    triangle(drawX, drawY+halfY, drawX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //Bottom Left
  }

  void shp11() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(floorColor);
    triangle(drawX+drawSizeX, drawY, drawX+halfX, drawY, drawX+drawSizeX, drawY+halfY); //Top Right
  }

  void shp12() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+halfY);
    fill(floorColor);
    rect(drawX, drawY+halfY, drawX+drawSizeX, drawY+drawSizeY);
  }

  void shp13() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(floorColor);
    triangle(drawX+drawSizeX, drawY+halfY, drawX+drawSizeX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //BottomRight
  }

  void shp14() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY); //Full
    fill(floorColor);
    triangle(drawX, drawY+halfY, drawX, drawY+drawSizeY, drawX+halfX, drawY+drawSizeY); //Bottom Left
  }

  void shp15() {
    noStroke();
    fill(wallColor);
    rect(drawX, drawY, drawX+drawSizeX, drawY+drawSizeY);
  }
}
