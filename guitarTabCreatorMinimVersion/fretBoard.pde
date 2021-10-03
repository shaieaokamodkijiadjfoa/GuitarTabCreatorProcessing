class FretBoard {
  FretBoard(){
    
  }
  
  void drawBoard(){
    pushStyle();
    beginShape();
    noStroke();
    fill(#1F0F04);
    vertex(leftX, topLeftY);
    vertex(rightX, topRightY);
    vertex(rightX, bottomRightY);
    vertex(leftX, bottomLeftY);
    endShape();
    popStyle();
  }
  
  void drawFrets(){
    float sum = 0;
    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      sum = sum + spacingRatioOfFrets[j];
      float angleRight = atan2(topRightY-topLeftY, rightX-leftX);
      float angleLeft = atan2(bottomRightY-bottomLeftY, rightX-leftX);
      float len = dist(leftX, topLeftY, rightX, topRightY);
      float rx = leftX + cos(angleRight) * (len * (sum/45.5));
      float ry = topLeftY + sin(angleRight) * (len * (sum/45.5));
      float lx = leftX + cos(angleLeft) * (len * (sum/45.5));
      float ly = bottomLeftY + sin(angleLeft) * (len * (sum/45.5));
      pushStyle();
      stroke(#1F0F04);
      strokeWeight(4);
      textAlign(CENTER, BOTTOM);
      textSize(21);
      if (j==3||j==5||j==7||j==9||j==12||j==15||j==17||j==19||j==22) {      
        stroke(#DBC682);
        line(rx, ry+6, lx, ly-6);
        fill(#DBC682);
        text(j, rx, ry);
        textAlign(CENTER, TOP);
        text(j, lx, ly);
      } else if (j!=0){
        stroke(#BC9C3D);
        line(rx, ry+6, lx, ly-6);
        fill(#BC9C3D);
        text(j, rx, ry);
        textAlign(CENTER, TOP);
        text(j, lx, ly);
      } else {
        stroke(#FFEDBC);
        line(rx, ry+3, lx, ly-3);
        fill(#FFEDBC);
        text(j, rx, ry);
        textAlign(CENTER, TOP);
        text(j, lx, ly);
      }
      popStyle();
    }
  }
    
  void drawFretMarkers(){
    float sum = 0;
    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      sum = sum + spacingRatioOfFrets[j];
      if (j!=0) {
        float x = leftX + (boardLength * (sum/45.5));
        float px = leftX + (boardLength * ((sum-spacingRatioOfFrets[j-1])/45.5));
        float cy = topLeftY + (headSideLength/4);
        float cx = (x+px)/2;
  
        pushStyle();
        if (j==3||j==5||j==7||j==9||j==15||j==17||j==19) {
          fill(#C1B387, 222);
          noStroke();
          ellipse(cx, cy, 15, 15);
        }
        if (j==12) {
  
          fill(#C1B387, 222);
          noStroke();
          ellipse(cx, cy + 55, 15, 15);
          ellipse(cx, cy - 55, 15, 15);
        }
        popStyle();
      }
    }
  }
}
