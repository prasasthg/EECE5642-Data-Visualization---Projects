class Edge {
  Node from; 
  Node to; 
  float minutes;
  color edgeColor;
  
  Edge(Node from, Node to, float minutes, String col) {
    this.from = from; 
    this.to = to; 
    this.minutes = minutes;
    this.edgeColor = getColor(col);
  }
  
  Node getFromNode() {
    return from;
  }
  
  Node getToNode() {
    return to;
  }
  
  float getMinutes() {
    return minutes;
  }
  
  color getColor(String col) {
    switch(col.charAt(0)) {
      case 'r':
        return color(230, 19, 16);
      case 'g':
        return color(1, 104, 66);
      case 'b':
        return color(0, 48, 140);
      case 'o':
        return color(255, 131, 5);
      default:
        return color(0); // Default color
    }
  }
  
  void draw() {
    stroke(edgeColor); 
    strokeWeight(2);
    line(from.x, from.y, to.x, to.y);
  }
}  
