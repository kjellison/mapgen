ArrayList<creature> creatures = new ArrayList<creature>(); //<>//
grid map;

int gridX = 50;
int gridY = 50;


void setup() {
  size(800, 800);
  if (width/gridX < 2) {
    gridX = width/2;
  }
  if (height/gridX < 2) {
    gridY = height/2;
  }
  map = new grid(gridX, gridY, width, height, 0, 0);
}


void draw() {
  background(0);
  map.show();
  for (creature c : creatures) {
    if (c.target != null) {
      c.hunt();
      delay(50);
    }
    c.show();
  }
}
void addCreature() {
  creatures.add(new creature(map.selectedTile, color(random(0, 200), 0, 200), map));
}

void reset() {
  map.reset();
  creatures.clear();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    map.mouseSelect();
  } else if (mouseButton == RIGHT) {
    map.deSelect();
  }
}

void keyPressed() {
  if (key == 'r') {
    reset();
  }
  if (key == 'c') {
    map.iterateCell();
  }
  if (key == 'f') {
    map.flood();
  }
  if (key == 'q') {
    map.removeNonFlood();
  }
  if (key == 'w') {
    map.clearFlood();
  }
  if (key == 's') {
    reset();
    map.autoGenCel();
  }
  if (key == 't') {
    addCreature();
  }
  if (key == 'o') {
    creatures.get(0).target = creatures.get(1);
  }
  switch (keyCode) {
  case LEFT:
    for (creature c : creatures) {
      c.move("lt");
    }
    break;
  case UP:
    for (creature c : creatures) {
      c.move("up");
    }
    break;
  case RIGHT:
    for (creature c : creatures) {
      c.move("rt");
    }
    break;
  case DOWN:
    for (creature c : creatures) {
      c.move("dn");
    }
    break;
  }

  switch(key) {
  case 'l':
    for (creature c : creatures) {
      c.move("ur");
    }
    break;
  case 'k':
    for (creature c : creatures) {
      c.move("ul");
    }
    break;
  case '.':
    for (creature c : creatures) {
      c.move("dr");
    }
    break;
  case ',':
    for (creature c : creatures) {
      c.move("dl");
    }
    break;
  }
}
