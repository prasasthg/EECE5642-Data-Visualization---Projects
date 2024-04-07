PImage mapImage;
Table stationTable; // Renamed from nameTable

int currentRow = -1; 
PrintWriter writer; 

void setup() {
  size(560, 560);
  mapImage = loadImage("mbta-map.gif");
  stationTable = new Table("stations.csv"); // Changed file name
  writer = createWriter("locations.csv"); // Changed output file name
  cursor(CROSS);
  println("Click the mouse to begin.");
}

void draw() {
  image(mapImage, 0, 0);
}

void mousePressed() {
  if (currentRow != -1) {
    String stationName = stationTable.getString(currentRow, 1); // Get station name
    if (currentRow == 0) {
      writer.println(stationName + "," + "x" + "," + "y");
    } else {
      writer.println(stationName + "," + mouseX + "," + mouseY);
      println(mouseX, mouseY);
    }
  }

  currentRow++;
  if (currentRow == stationTable.getRowCount()) {
    writer.flush();
    writer.close();
    exit();
  } else {
    String stationName = stationTable.getString(currentRow, 1); // Get station name
    println("Choose location for " + stationName + ".");
  }
}
