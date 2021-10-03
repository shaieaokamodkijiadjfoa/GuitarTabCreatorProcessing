class NotesFretNums{
  PVector[] cStaffNotation;
  PVector[] cTABNotation;
  PVector[] cGNtoStaffNotation;
  float offset;
  float noteOffset;
  int lineNumber;
  

  float staffX,staffY,tabX,tabY;
  
  
  String thisChordName;
  int thisNoteDuration;
  int[] thisFretNums;
  String[] thisNotes;
  boolean thisDS;
  boolean thisUS;
  boolean[] thisFret;
  
  
  float strokeX;
  float strokeSY;
  float strokeEY;
  
  
  NotesFretNums(int num, float sx, float sy, float tx, float ty){
    
    staffX = leftX + sx;    
    staffY = sy;
    tabX = leftX + tx;    
    tabY = ty;
    
    strokeX = 0;
    strokeSY = 0;
    strokeEY = 0;
    
    
    cStaffNotation = new PVector[28];
    cTABNotation = new PVector[6];
    cGNtoStaffNotation = new PVector[notes.length];
    lineNumber = num;
    offset = 21;
    noteOffset = boardLength/2/17;
    
    thisChordName = "";
    thisNoteDuration = 0;
    thisFretNums = new int[sixStrings];
    thisFret = new boolean[sixStrings];
    
    thisNotes = new String[sixStrings];
    for (int i = 0; i < sixStrings; i++) {
      thisNotes[i] = "";
      thisFretNums[i] = -2;
      thisFret[i] = false;
    }
    
    thisDS = false;
    thisUS = false;
    
    for (int i = 0; i < ledgerLineNotes.length; i++) {
      float yoffset = staffY + (i*offset); 
      PVector coordinates = new PVector(staffX + noteOffset*(lineNumber+1), 240 + yoffset/2);
      cStaffNotation[i] = coordinates;
    }
    
    for (int i = 0; i < sixStrings; i++) {
      float tabyoffset = tabY + (i*30);
      PVector coordinates = new PVector(tabX + noteOffset*(lineNumber+1), 250 + tabyoffset); 
      cTABNotation[i] = coordinates;
    }
    
    int sum = 0;
    for (int m = 0; m < notes.length; m++) {
      int o = notes.length - (m+1);
      String tempNote = notes[o];
      char[] tempArr = tempNote.toCharArray();
      cGNtoStaffNotation[o] = cStaffNotation[sum];
      if (tempArr[1] != '#') {
        sum++;
      }
    }
    sum = 0;
    
  }
  
  void storeNotes(){
    thisNoteDuration = checkNoteDuration;
    
    for (int i = 0; i < sixStrings; i++) {
      for (int k = 0; k < sns[i].theObjNotesArray.length; k++) {
        if (sns[i].fretClicked[k]) {

            thisNotes[i] = sns[i].theObjNotesArray[k];

        }
      }
    }
    
    
    for (int i = 0; i < sixStrings; i++) {  
      for (int j = 0; j < 23; j++) {
          if(sns[i].checkMute) {
            thisFretNums[i] = -1;
          }
          if(sns[i].checkResetEach) {
            thisFretNums[i] = -2;
            thisFret[i] = false;
            thisNotes[i] = "";
            strokeX = 0;
            strokeSY = 0;
            strokeEY = 0;
          }
          if(sns[i].fretClicked[j]){
              thisFretNums[i] = j;
              thisFret[i] = true;
          }
        
      }
      
    }

        
    if (dChordName != "") {
      thisChordName = dChordName;
    }
    
    if (downS){
      thisDS = true;
      thisUS = false;
    }
    if (upS) {
      thisUS = true;
      thisDS = false;
    }
    
    for (int ss = 0; ss < sixStrings; ss++) {
      if (thisFret[ss] && thisFretNums[ss] >= 0){
        strokeX =  cTABNotation[ss].x;
        strokeSY = cTABNotation[ss].y;
        break;
      }
    }
    for (int ss = 5; ss >= 0; ss--) {
      if (thisFret[ss] && thisFretNums[ss] >= 0){
        strokeEY = cTABNotation[ss].y;
        break;
      }
    }
    

  }

  void drawStaffNotes(){
    
    
    pushStyle();
    if(editableLine == lineNumber){
      strokeWeight(3);
      stroke(#ED654A, 127);
    } else {
      strokeWeight(1);
      stroke(#C0C0C0, 127);
    }
    line(staffX + boardLength/2/17*(lineNumber+1), staffY, staffX + boardLength/2/17*(lineNumber+1), staffY + 294);
    popStyle();

            
    for (int j = 0; j < sixStrings; j++) {
      
      String tempNote = thisNotes[j];
      if (tempNote != "") {
        for (int l = 0; l < notes.length; l++) {
          char[] tempArr = tempNote.toCharArray();
          if (tempNote == notes[l] && !(resetEach && thisFretNums[j] == 0)) {
            
            pushStyle();
    
            switch(thisNoteDuration) {
              case 1:
                fill(#DBC682);
                noStroke();
                ellipse(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y, 30, 18);
                pushMatrix();
                translate(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y);
                rotate(-PI/1.5);
                fill(#1F2A36);
                ellipse(0, 0, 18, 15);
                popMatrix();
                break;
              case 2:
                pushMatrix();
                pushStyle();
                translate(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y);
                strokeWeight(3);
                stroke(#DBC682);
                line(10,-5,10,-30);
                rotate(-PI/0.9);
                noStroke();
                fill(#DBC682);
                ellipse(0, 0, 24, 18);
                fill(#1F2A36);
                ellipse(0, 0, 22, 11);
                popStyle();
                popMatrix();
                break;
              case 4:
                pushMatrix();
                pushStyle();
                translate(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y);
                strokeWeight(3);
                stroke(#DBC682);
                line(10,-5,10,-30);
                rotate(-PI/0.9);
                noStroke();
                fill(#DBC682);
                ellipse(0, 0, 24, 18);
                popStyle();
                popMatrix();
                break;  
              case 8:
                pushMatrix();
                pushStyle();
                translate(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y);
                strokeWeight(3);
                stroke(#DBC682);
                line(10,-5,10,-30);
                line(10,-30,20,-30);
                rotate(-PI/0.9);
                noStroke();
                fill(#DBC682);
                ellipse(0, 0, 24, 18);
                popStyle();
                popMatrix();
                break;
              case 16:
                pushMatrix();
                pushStyle();
                translate(cGNtoStaffNotation[l].x, cGNtoStaffNotation[l].y);
                strokeWeight(3);
                stroke(#DBC682);
                line(10,-5,10,-30);
                line(10,-30,20,-30);
                line(10,-25,20,-25);
                rotate(-PI/0.9);
                noStroke();
                fill(#DBC682);
                ellipse(0, 0, 24, 18);
                popStyle();
                popMatrix();
                break;
            }
            
            if (tempArr[1] == '#') {
              textAlign(CENTER, BOTTOM);
              textSize(18);
              fill(#DBC682);
              text("#", cGNtoStaffNotation[l].x + 21, cGNtoStaffNotation[l].y + 12);
            }
            
            popStyle();
          }
        }
      }
    }


      
  }
  
  // Draw simple Guitar TAB notation.
  void drawTABFretNums(){ 
    pushStyle();
    if (editableLine == lineNumber) {
      stroke(#ED654A, 127);
      strokeWeight(3);
    } else {
      stroke(#C0C0C0, 127);
      strokeWeight(1);
    }
    line(tabX + boardLength/2/17*(lineNumber+1), cTABNotation[0].y, tabX + boardLength/2/17*(lineNumber+1), cTABNotation[5].y);
    popStyle();
    
    pushStyle();
    noStroke();
    textAlign(CENTER,CENTER);
    textSize(18);
    for (int i = 0; i < sixStrings; i++) {
      
      if(thisFretNums[i] == -1) {
        fill(#BC9C3D);
        textSize(21);
        text("X", cTABNotation[i].x, cTABNotation[i].y-3);
      } else {
        if (thisFretNums[i] != -2 && !(resetEach && thisFretNums[i] == 0)) {
          fill(#1F0F04);
          ellipse(cTABNotation[i].x, cTABNotation[i].y, 27,27);
          fill(#BC9C3D);
          text(thisFretNums[i], cTABNotation[i].x, cTABNotation[i].y-3);
        }
        
        pushStyle();
        if (thisDS) {
          strokeWeight(3);
          stroke(#ED654A);
          line(strokeX + 20, strokeSY-3, strokeX + 20, strokeEY-3);
          triangle(strokeX + 15, strokeSY+3, strokeX + 20, strokeSY-3, strokeX + 25, strokeSY+3);
        }
        if (thisUS) {
          strokeWeight(3);
          stroke(#ED654A);
          line(strokeX + 20, strokeSY-3, strokeX + 20, strokeEY-3);
          triangle(strokeX + 15, strokeEY-3, strokeX + 20, strokeEY+3, strokeX + 25, strokeEY-3);
        }
        popStyle();
      
      }
        
      
    }
    popStyle();
   
   
    if (thisChordName != "") {
      
      float x = cTABNotation[0].x;
      float y = cTABNotation[0].y;
      pushStyle();
      textSize(15);
      textAlign(CENTER, CENTER);
      String tempStrings = thisChordName;
      char[] tempCharArry = tempStrings.toCharArray();
      fill(#BC9C3D);
      if (tempCharArry.length > 3) {
        for (int m = 0; m < 3; m++) {
          text(tempCharArry[m], x-12 + (m*11), y-45);
        }
        for (int m = 3; m < tempCharArry.length; m++) {
          text(tempCharArry[m], x-12 + ((m-3)*11), y-30);
        }
      } else {
        text(thisChordName, x, y-45);
      }
      popStyle();
    
    }
      

  
  }
  
}
