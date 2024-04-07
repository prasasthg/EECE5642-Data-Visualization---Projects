import processing.pdf.*;

// nodes
int nodeCount; 
Node[] nodes = new Node[100];
HashMap nodeTable = new HashMap();

// selection
Node selection;

// record
boolean record; 

// edges
int edgeCount; 
Edge[] edges = new Edge[500];

// font
PFont font; 
Table connectionsTable;
Table locationsTable;

void setup() {
  size(560, 560);
  font = createFont("SansSerif", 10);
  loadData();
}

void loadData() {
  connectionsTable = new Table("connections.csv");
  locationsTable = new Table("locations.csv");

  for (int i = 1; i < connectionsTable.getRowCount(); i++) {
    String fromLabel = connectionsTable.getString(i, 1);
    String toLabel = connectionsTable.getString(i, 2);
    float minutes = connectionsTable.getFloat(i, 4);
    String col = connectionsTable.getString(i, 3);
    addEdge(fromLabel, toLabel, minutes, col);
  }
}

void addEdge(String fromLabel, String toLabel, float minutes, String col) {
  // find nodes
  Node from = findNode(fromLabel);
  Node to = findNode(toLabel);
  
  // old edge?
  for (int i = 0; i < edgeCount; i++) {
    if (edges[i].from == from && edges[i].to == to) {
      return; 
    }
  }
  
  // add edge
  Edge e = new Edge(from, to, minutes, col);
  if (edgeCount == edges.length) {
    edges = (Edge[]) expand(edges);
  }
  edges[edgeCount++] = e; 
}

Node findNode(String label) {
  Node n = (Node) nodeTable.get(label); // Explicitly cast the retrieved object to Node
  if (n == null) {
    return addNode(label);
  }
  return n;
}

Node addNode(String label) {
  float x = random(50, width - 50);
  float y = random(50, height - 50);
  int index = locationsTable.getRowIndex(label);
  if (index != -1) {
    x = locationsTable.getFloat(index, 1);
    y = locationsTable.getFloat(index, 2);
  }
  Node n = new Node(label, x, y, nodeCount);
  
  if (nodeCount == nodes.length) {
    nodes = (Node[]) expand(nodes);
  }
  
  // Add the new node to the array
  nodes[nodeCount++] = n;
  return n;
}
void draw() {
  if (record) {
    beginRecord(PDF, "output.pdf");
  }
  
  textFont(font); 
  smooth();
  
  background(255); 
  
  // draw the edges
  for (int i = 0; i < edgeCount; i++) {
    edges[i].draw();
  }
  
  // draw the nodes
  for (int i = 0; i < nodeCount; i++) {
    nodes[i].draw();
  }

  mouseHover();
  
  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    float closest = 5;
    for (int i = 0; i < nodeCount; i++) {
      Node n = nodes[i];
      float d = dist(mouseX, mouseY, n.x, n.y);
      if (d < closest) {
        selection = n;
        fill(5);
        textSize(15);
        textAlign(CENTER);
        text(n.label, 450, 40);
        closest = d;
      }
    }
  }
}

void mouseDragged() {
  if (selection != null) {
    selection.x = mouseX;
    selection.y = mouseY;
  }
}

void mouseReleased() {
  selection = null;
}

void keyPressed() {
  if (key == 'p') {
    record = true;
  }
}

void mouseHover() {
  for (int i = 0; i < nodeCount; i++) {
    Node n = nodes[i];
    float d = dist(mouseX, mouseY, n.x, n.y);
    if (d < 5) {
      fill(0);
      textAlign(RIGHT);
      text(n.label, width - 5, 15);
    }
  }
}
