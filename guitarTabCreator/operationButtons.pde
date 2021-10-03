class OperationButtons{
  
  float[][] cOperationButtons;

  OperationButtons() {
    cOperationButtons = new float[10][4];
  }
  
  void drawOperationButtons(float x, float y) {
    float rectY = y-30;
    float rectW = 87;
    float rectH = 45;
    int sum = 0;
    pushStyle();
    for (String cb : controlButtons) {
      float rectX = x + sum * 96;
      noStroke();
      fill(#3E7AB9, 200);
      rectMode(CENTER);
      textSize(12);
      textAlign(CENTER, CENTER);
      cOperationButtons[sum][0] = rectX+rectW/2;
      cOperationButtons[sum][1] = rectY-rectH/2;
      cOperationButtons[sum][2] = rectX-rectW/2;
      cOperationButtons[sum][3] = rectY+rectH/2;
      if ((rectX+rectW/2 > mouseX)&&(rectY-rectH/2 < mouseY)&&(rectX-rectW/2 < mouseX)&&(rectY+rectH/2 > mouseY)) {
        if (mousePressed){
          rect(rectX, rectY, rectW+5, rectH+5);
        } else {
          rect(rectX, rectY, rectW, rectH);
        }
        fill(#ED654A);
        switch (sum) {
          case 0:
            triangle(rectX+rectW/6, rectY-rectH/4, rectX-rectW/5, rectY, rectX+rectW/6, rectY+rectH/4);
            break;
          case 1:
            fill(#3E7AB9);
            ellipse(rectX, rectY, rectW/2.5, rectW/2.5);
            fill(#ED654A);
            ellipse(rectX, rectY, rectW/4, rectW/4);
            break;
          case 2:
            triangle(rectX-rectW/6, rectY-rectH/4, rectX+rectW/5, rectY, rectX-rectW/6, rectY+rectH/4);
            break;
          case 3:
            strokeWeight(6);
            stroke(#ED654A);
            line(rectX, rectY-rectH/3, rectX, rectY+rectH/3);
            triangle(rectX-rectW/10, rectY+rectH/10, rectX+rectW/10, rectY+rectH/10, rectX, rectY+rectH/3);
            break;
          case 4:
            strokeWeight(6);
            stroke(#ED654A);
            line(rectX, rectY-rectH/3, rectX, rectY+rectH/3);
            triangle(rectX-rectW/10, rectY-rectH/10, rectX+rectW/10, rectY-rectH/10, rectX, rectY-rectH/3);
            break;
        }
        
      } else {
        fill(#1F0F04);
        rect(rectX, rectY, rectW, rectH);
        fill(#BC9C3D);
        text(cb, rectX, rectY);
      }
      sum++;
    }
    popStyle();
    
    sum = 0;
    
    pushStyle();
    for (String nd : noteDurations.keySet()) {
      float rectX = x + sum * 96 + 480;
      
      noStroke();
      fill(#3E7AB9, 200);
      rectMode(CENTER);
      textSize(12);
      textAlign(CENTER, CENTER);
      cOperationButtons[sum+5][0] = rectX+rectW/2;
      cOperationButtons[sum+5][1] = rectY-rectH/2;
      cOperationButtons[sum+5][2] = rectX-rectW/2;
      cOperationButtons[sum+5][3] = rectY+rectH/2;
      if ((rectX+rectW/2 > mouseX)&&(rectY-rectH/2 < mouseY)&&(rectX-rectW/2 < mouseX)&&(rectY+rectH/2 > mouseY)) {
        if (mousePressed) {
          rect(rectX, rectY, rectW+5, rectH+5);
        } else {
          rect(rectX, rectY, rectW, rectH);
        }
        fill(#ED654A);
        switch (noteDurations.get(nd)) {
          case 1:
            ellipse(rectX, rectY, 30, 18);
            pushMatrix();
            pushStyle();
            translate(rectX, rectY);
            rotate(-PI/1.5);
            fill(#3E7AB9, 200);
            ellipse(0, 0, 18, 15);
            popStyle();
            popMatrix();
            break;
          case 2:
            pushMatrix();
            pushStyle();
            translate(rectX-5, rectY+10);
            strokeWeight(3);
            stroke(#ED654A);
            line(8,-5,8,-rectH/1.6);
            rotate(-PI/0.9);
            noStroke();
            fill(#ED654A);
            ellipse(0, 0, 20, 15);
            fill(#3E7AB9, 200);
            ellipse(0, 0, 19, 8);
            popStyle();
            popMatrix();
            break;
          case 4:
            pushMatrix();
            pushStyle();
            translate(rectX-5, rectY+10);
            strokeWeight(3);
            stroke(#ED654A);
            line(8,-5,8,-rectH/1.6);
            rotate(-PI/0.9);
            noStroke();
            fill(#ED654A);
            ellipse(0, 0, 20, 15);
            popStyle();
            popMatrix();
            break;
          case 8:
            pushMatrix();
            pushStyle();
            translate(rectX-5, rectY+10);
            strokeWeight(3);
            stroke(#ED654A);
            line(8,-5,8,-rectH/1.6);
            line(8,-rectH/1.6,20,-rectH/1.6);
            rotate(-PI/0.9);
            noStroke();
            fill(#ED654A);
            ellipse(0, 0, 20, 15);
            popStyle();
            popMatrix();
            break;
          case 16:
            pushMatrix();
            pushStyle();
            translate(rectX-5, rectY+10);
            strokeWeight(3);
            stroke(#ED654A);
            line(8,-5,8,-rectH/1.6);
            line(8,-rectH/1.6,20,-rectH/1.6);
            line(8,-rectH/1.9,20,-rectH/1.9);
            rotate(-PI/0.9);
            noStroke();
            fill(#ED654A);
            ellipse(0, 0, 20, 15);
            popStyle();
            popMatrix();
            break;
        }
      } else {
        fill(#1F0F04);
        rect(rectX, rectY, rectW, rectH);
        fill(#BC9C3D);
        text(nd, rectX, rectY);
      }
      sum++;
    }
    popStyle();
     
  }
 
}
