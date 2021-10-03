class StaffTAB {
  
  float staffX, staffY;
  float tabX, tabY;

  StaffTAB(float sx, float sy, float tx, float ty){
    staffX = leftX + sx;
    staffY = sy;
    tabX = leftX + tx;
    tabY = ty;
  }


  void drawStaffNotation(){
    
    float offset = 21;
    for (int i = 0; i < ledgerLineNotes.length; i++) {
      float yoffset = i*offset;
      if (i>=0 && i<14) {
        pushStyle();
        strokeWeight(3);
        if (i<=5 || i>=11) {
          strokeWeight(1);
        }
        stroke(#93772B);
        line(staffX + offset, staffY + yoffset, staffX + boardLength/2 - offset, staffY + yoffset);
        popStyle();
      }
        
      pushStyle();
      textAlign(CENTER,CENTER);
      textSize(15);
      float textXoffset = 0;
      if (i%2==0) {
        fill(#93772B);
        textXoffset = -9;
      } else {
        fill(#C0C0C0);
        textXoffset = 12;
      }
      text(ledgerLineNotes[i], staffX - textXoffset, staffY + yoffset/2 -2);
      text(ledgerLineNotes[i], staffX + boardLength/2+textXoffset, staffY + yoffset/2 -2);
      popStyle();

      if (toggleDisplayNotes) {
      
        float xoffset = boardLength/2/31;
        pushStyle();
        noStroke();
        fill(#C0C0C0, 127);
        ellipse(staffX + boardLength/2 -((i+2)*xoffset), staffY + yoffset/2, 24, 18);
        popStyle(); 
      }
      
    }
  
    pushStyle();
    strokeWeight(3);
    stroke(#93772B);
    line(staffX + offset, staffY+12*offset/2, staffX + offset, staffY+20*offset/2);
    line(staffX + boardLength/2 - offset, staffY+12*offset/2, staffX + boardLength/2 - offset, staffY+20*offset/2);
    popStyle();
      
  }

  void drawTABNotation(){
    
    pushStyle();
    for (int i = 0; i < sixStrings; i++) {
      float yoffset = tabY + (i*30);
      noFill();
      strokeWeight(3);
      stroke(#C0C0C0);
      line(tabX, 250+yoffset, tabX + boardLength/2, 250+yoffset);
      
      fill(#C0C0C0);
      textAlign(CENTER, CENTER);
      textSize(15);
      String stringsName = "";
      if (i==0) {
        stringsName = "1st"; 
      }
      if (i==1) {
        stringsName = "2nd"; 
      }
      if (i==2) {
        stringsName = "3rd"; 
      }
      if (i>2) {
        stringsName = str(i+1) + "th"; 
      }
      text(stringsName, tabX-17, 247+yoffset);
      text(stringsName, tabX+17 + boardLength/2, 247+yoffset);
      
  
    }
  
    line(tabX, 250+tabY, tabX, 400+tabY);
    line(tabX + boardLength/2, 250+tabY, tabX + boardLength/2, 400+tabY);
    popStyle();
  }
    
}
