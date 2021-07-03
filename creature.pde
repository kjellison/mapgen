class creature {
  tile location;
  boolean isAlive;
  color fillColor;
  int health;
  creature target;
  ArrayList<tile> path = new ArrayList<tile>();
  grid cMap;

  creature(tile _loc, color _fCol, grid _cMap) {
    location = _loc;
    isAlive = true;
    health = 255;
    fillColor = _fCol;
    cMap = _cMap;
  }

  void show() {
    noStroke();
    fill(fillColor);
    circle(location.drawX+location.drawSizeX/2, location.drawY+location.drawSizeY/2, location.drawSizeX);
  }

  void hunt() {
    if (location != target.location) {
      path.clear();
      path = aStar(location, target.location);
      if (path.size() > 0) {
        location = path.get(path.size()-1);
      }
    }
  }

  int getDist(tile a, tile b) {
    if (a != null && b != null) {
      int distX = abs(a.x - b.x);
      int distY = abs(a.y - b.y);

      if (distX > distY) {
        return 10*distY + 10*distX - distY;
      } else {
        return 10*distX + 10*distY - distX;
      }
    } else {
      return 0;
    }
  }

  ArrayList<tile> aStar(tile source, tile target) {
    for (tile t : cMap.tiles) {
      t.parent = null;
    }
    ArrayList<tile> _path = new ArrayList<tile>();
    ArrayList<tile> oSet = new ArrayList<tile>();
    ArrayList<tile> cSet = new ArrayList<tile>();
    oSet.add(source);
    while (oSet.size() > 0) {
      tile current = oSet.get(0);
      for (tile o : oSet) {
        if (o.fCost() < current.fCost() || (o.fCost() == current.fCost() && o.h < current.h)) {
          current = o;
        }
      }


      cSet.add(current);

      if (current == target) {
        _path = retrace(source, target);
        return _path;
      }
      for (tile n : current.nbrs) {
        if (n == null || !n.isFloor || cSet.contains(n)) {
          continue;
        }

        int newCost = current.g + getDist(current, n);
        if (newCost < n.g || !oSet.contains(n)) {
          n.g = newCost;
          n.h = getDist(n, target);
          n.parent = current;

          if (!oSet.contains(n)) {
            oSet.add(n);
          }
        }
      }
      oSet.remove(current);
    }
    return null;
  }

  ArrayList<tile> retrace(tile source, tile target) {
    ArrayList<tile> _p = new ArrayList<tile>();
    tile current = target;

    while (current != source) {
      _p.add(current.parent);
      current = current.parent;
    }

    _p.remove(_p.size()-1);

    //for (tile p : _p) {
    //  p.isPath = true;
    //}
    return _p;
  }

  

  boolean move(String dir) {
    int iDir = 0;
    switch (dir) {
    case "ul":
      iDir = 0;
      break;
    case "up":
      iDir = 1;
      break;
    case "ur":
      iDir = 2;
      break;
    case "rt":
      iDir = 4;
      break;
    case "dr":
      iDir = 7;
      break;
    case "dn":
      iDir = 6;
      break;
    case "dl":
      iDir = 5;
      break;
    case "lt":
      iDir = 3;
      break;
    }
    tile temp = location.getNbr(iDir);
    if (temp != null) {
      if (temp.isFloor) {
        location = temp;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
