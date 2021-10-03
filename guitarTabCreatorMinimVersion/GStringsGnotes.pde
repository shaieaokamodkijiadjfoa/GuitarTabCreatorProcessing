class GStringsGNotes{
  int guitarStringNum;
  PVector[] fretsAndNotes;
  float[][] circleRange;
  boolean[] fretClicked;

  boolean checkMute = false;
  boolean checkResetEach = false;
  boolean displayEachNotes = false;
  int checkTheJNum;


  String[] theObjNotesArray;


  GStringsGNotes(int designationNum){
    guitarStringNum = designationNum;
    fretsAndNotes = new PVector[spacingRatioOfFrets.length];
    circleRange = new float[spacingRatioOfFrets.length][4];
    fretClicked = new boolean[spacingRatioOfFrets.length];
    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      fretClicked[j] = false;
    }

    theObjNotesArray = new String[spacingRatioOfFrets.length];
    theObjNotesArray = standardTuning[guitarStringNum];
  }
  
  void drawStrings(){
    
    pushStyle();
    if (guitarStringNum==0||guitarStringNum==1) {
      stroke(#504829);
    } else if (guitarStringNum==2) {
      stroke(#48432D);
    } else {
      stroke(#716740);
    }
    strokeWeight(1.3+(guitarStringNum * 0.4));
    line(leftX, topLeftY+(headSideLength/14)*(guitarStringNum+1), rightX, topRightY+(bodySideLength/14)*(guitarStringNum+1));
    popStyle();


    float sum = 0;
    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      sum = sum + spacingRatioOfFrets[j];
      float angle = atan2((topRightY+((bodySideLength/14)*(guitarStringNum+1))) - (topLeftY+((headSideLength/14)*(guitarStringNum+1))), rightX - leftX);
      float len = dist(leftX, topLeftY+((headSideLength/14)*(guitarStringNum+1)), rightX, topRightY+((bodySideLength/14)*(guitarStringNum+1)));
      float x = leftX + cos(angle) * (len * (sum/45.5));
      float y = topLeftY+((headSideLength/14)*(guitarStringNum+1)) + sin(angle) * (len * (sum/45.5));
      fretsAndNotes[j] = new PVector(x, y);
    }
     
  }
  
   
  void darwGuitarNotes(){

    if (toggleResetAll) {
      initFretClicked();
    }

    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      float x = fretsAndNotes[j].x;
      float y = fretsAndNotes[j].y;
      String note = theObjNotesArray[j];
      float xr = 50;
      float yr = 18;
      float spacing = 24.0;

      pushStyle();
      noStroke();
      fill(#3E7AB9, 120);
      textAlign(CENTER, CENTER);
      textSize(20);

      if (j>6&&j<10) {
        xr = 45;
        yr = 17;
        spacing = 20;
        textSize(18);
      }
      if (j>=10&&j<13) {
        xr = 40;
        yr = 17;
        spacing = 19;
        textSize(16);
      }
      if (j>=13&&j<17) {
        xr = 35;
        yr = 16;
        spacing = 18;
        textSize(14);
      }
      if (j>=17&&j<20) {
        xr = 30;
        yr = 16;
        spacing = 17;
        textSize(13);
      }
      if (j>=20) {
        xr = 25;
        yr = 15;
        spacing = 12;
        textSize(12);
      }
      
      circleRange[j][0] = x - spacing - xr/2;
      circleRange[j][1] = y - yr/2;
      circleRange[j][2] = x - spacing + xr/2;
      circleRange[j][3] = y + yr/2;

      if (!checkMute) {

        if (fretClicked[j] && !checkResetEach) {
          pushStyle();
          if (j==0){
            textSize(23);
          } else {
            ellipse(x - spacing, y, xr, yr);
          }
          
          strokeWeight(1.3+(guitarStringNum * 0.4));
          stroke(#ED654A);
          line(x, y, fretsAndNotes[fretsAndNotes.length-1].x, fretsAndNotes[fretsAndNotes.length-1].y);
          fill(#ED654A);
          text(note, x - spacing, y - 3);

          popStyle();
        } else {
          
          if (toggleDisplayNotes) {

            pushStyle();
            if (j==0){
              fill(#FFEDBC);
              textSize(23);
            } else {
              ellipse(x - spacing, y, xr, yr);
              fill(#BC9C3D);
            }
            text(note, x - spacing, y - 3);
            popStyle();
          }
        }
      }
      popStyle();

    }

  }

  void determineClicked(){

    for (int j = 0; j < spacingRatioOfFrets.length; j++) {
      float left = circleRange[j][0];
      float top = circleRange[j][1];
      float right = circleRange[j][2];
      float bottom = circleRange[j][3];
      
      if ((left < mouseX) && (top < mouseY) && (mouseX < right) && (bottom > mouseY) && (mousePressed)) {
        
        initFretClicked();

        if (toggleMute && j==0) {
          checkMute = true;
        } else {
          checkMute = false;
        }

        if (resetEach && j==0) {
          checkResetEach = true;
        } else {
          checkResetEach = false;
        }

        if (toggleDisplayNotes) {
          displayEachNotes = false;
        } else {
          displayEachNotes = true;
          checkTheJNum = j;
        }
        
        fretClicked[j] = true;
        
      }

    }
    
  }

  void initFretClicked(){
    for (int i = 0; i < spacingRatioOfFrets.length; i++) {
      fretClicked[i] = false;
    }
    checkMute = false;
    displayEachNotes = true;
    checkResetEach = false;
  }
  

}
