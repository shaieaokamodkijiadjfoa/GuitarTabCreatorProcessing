////////////////////////////////////////////////
//ProcessingのSoundライブラリをインポートする。
//Import the Processing Sound library.
//import processing.sound.*;
// * minimバージョンです。
// * This is the minim version.
// * Windows10ではSoundライブラリのエラーが起こるので、別のサウンドライブラリminimを使用してください。
// * The Sound library fails in Windows 10, so use a different sound library, minim.
// * ウィンドウの[ツール]タブから、[ツールを追加]を選択し、[Libraries]を選択し、[filter]ウィンドウで[Minim]と検索してインストールします。
// * From the Tools tab of the window, select [Add Tool], select [Libraries], and search for [Minim] in the [filter] window, and install it.
// * 但し、このライブラリの詳しい使い方が分からなかったので、ドゥレーションについては各自で調べて実装してみてください。
// * However, I didn't know the details of how to use this library, so please check and implement it yourself.
// * ちゃんと音は鳴ります。なので、音を鳴らす時はブログや動画で説明している通り、ギターサウンドのスイッチをONにしてキーボードの[P]か左横のサウンドボタンを押すだけです。
// * The sound plays properly. So when you want to play a sound, just turn on the guitar sound switch and press P on the keyboard or the sound button on the left side, as explained in my blog or video.
// * しかし、このアプリケーションに関しては、実際の演奏は人間かDTMソフトが行うことが前提の仕様ですので、それほど気にしなくても構まわないと個人的に思います。
// * However, for this application, the actual performance is assumed to be performed by a human or DTM software, so I personally don't think you need to worry too much.
// * 最後に、サウンドライブラリminimの作者達(Damien Di Fede and Anderson Mills)に感謝します。
// * Finally, thanks to the creators of the minim sound library (Damien Di Fede and Anderson Mills).

import ddf.minim.*;

//SoundFile[] sfiles;
Minim minim;
AudioPlayer[] sfiles;

//前回用意した変数を定義していく。
//Define the variables you prepared last time.
//メインファイル内で重複している変数は削除する。
//Delete duplicate variables in the main file.
String[] twtoneChromaticScale = {"e", "f", "fs", "g", "gs", "a", "as", "b", "c", "cs", "d", "ds"};


float[] durationsRatio;
float currentDuration;
/////////////////////////////////////////////////


float leftX, rightX, topLeftY, bottomLeftY, topRightY, bottomRightY;
float widthSpacing;
float heightSpacing;
float boardLength;
float headSideLength;
float bodySideLength;
float boardRatio;
float headSideRatio;
float bodySideRatio;
float[] spacingRatioOfFrets = {0, 3.4, 3.4, 3.4, 3.1, 2.8, 2.6, 2.6, 2.2, 2.2, 2.1, 2.0, 1.8, 1.8, 1.6, 1.6, 1.5, 1.4, 1.3, 1.3, 1.3, 1.1, 1};


String[][] standardTuning = {{"E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", "C6", "C#6", "D6"}, 
  {"B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5"}, 
  {"G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5", "D5", "D#5", "E5", "F5"}, 
  {"D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5"}, 
  {"A2", "A#2", "B2", "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4"}, 
  {"E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4"}};
  

FretBoard fb;

GStringsGNotes[] sns;

StaffTAB st;

NotesFretNums[] nfns;

GuitarCCButtons gccb;


OperationButtons obs;

int checkNoteDuration;

boolean downS;
boolean upS;

int editedLine;
int editableLine;
boolean[] editedLines;

boolean switchRecord;

String[] ledgerLineNotes = {"D6", "C6", "B5", "A5", "G5", "F5", "E5", "D5", "C5", "B4", "A4", "G4", "F4", "E4", "D4", "C4", "B3", "A3", "G3", "F3", "E3", "D3", "C3", "B2", "A2", "G2", "F2", "E2"};

String[] notes = {"E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2", "C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5", "C6", "C#6", "D6"};

String dChordName = "";

int sixStrings;

PFont font;

import java.util.Calendar;

import java.util.Map;
import java.util.LinkedHashMap;
Map<String,Integer> noteDurations = new LinkedHashMap<String,Integer>(){
  {
    put("Whole note", 1);
    put("Half note", 2);
    put("Quarter note", 4);
    put("8th note", 8);
    put("16th note", 16);
  }
};

String[] controlButtons = {"Backward","Record","Forward","Down Stroke","Up Stroke"};

int imageNumber;


import controlP5.*;
ControlP5 cp5;

boolean toggleDisplayNotes = false;

boolean toggleMute = false;

boolean resetEach = false;

boolean toggleResetAll = false;



void setup() {
  size(1920, 1080);
  
  font = createFont("Meiryo", 15, true);
  textFont(font);
  
  checkNoteDuration = 1;
  editableLine = 0;
  editedLine = 0;
  
  editedLines = new boolean[16];
  for (int i = 0; i < 16; i++) {
    editedLines[i] = false;
  }
  
  downS = true;
  upS = false;
  switchRecord = false;
  
  imageNumber = 1;

  widthSpacing = width/10;
  heightSpacing = height/10;

  boardRatio = 0.91;
  headSideRatio = 0.45;
  bodySideRatio = 0.6;

  boardLength = (width-widthSpacing)*boardRatio;
  headSideLength = (height-heightSpacing)*headSideRatio;
  bodySideLength = (height-heightSpacing)*bodySideRatio;

  leftX = widthSpacing;
  rightX = widthSpacing + boardLength;
  topLeftY = (height/4)-(headSideLength/4);
  bottomLeftY = (height/4)+(headSideLength/4);
  topRightY = (height/4)-(bodySideLength/4);
  bottomRightY = (height/4)+(bodySideLength/4);

  sixStrings = 6;
  
  st = new StaffTAB(-150, height/2-60, -150, height/2+40); 
  
  
  nfns = new NotesFretNums[16];
  for (int i =0 ; i < 16; i++) {
    nfns[i] = new NotesFretNums(i, -150, height/2-60, -150, height/2+40);
  }
  
  sns = new GStringsGNotes[sixStrings];
  for (int i = 0; i < sixStrings; i++){
    sns[i] = new GStringsGNotes(i);
  }
  
  fb = new FretBoard();
  
  gccb = new GuitarCCButtons();
  
  obs = new OperationButtons();

  smooth();
  cp5 = new ControlP5(this);
  
  
  cp5.addToggle("toggleNotes")
     .setSize(100,30)
     .setPosition(50,50)
     .setValue(true)
     .setColorBackground(#1F0F04)
     .setColorActive(#3E7AB9)
     .setCaptionLabel("Show:Notes/Hide:Notes")
     .setColorCaptionLabel(#BC9C3D)
     .setMode(ControlP5.SWITCH);

  cp5.addToggle("mute")
     .setSize(50,30)
     .setPosition(200,50)
     .setValue(false)
     .setColorBackground(#1F0F04)
     .setColorActive(#3E7AB9)
     .setCaptionLabel("toggle:Mute")
     .setColorCaptionLabel(#BC9C3D)
     .setMode(ControlP5.SWITCH);

  cp5.addToggle("toggleResetEach")
     .setSize(75,30)
     .setPosition(300,50)
     .setValue(false)
     .setColorBackground(#1F0F04)
     .setColorActive(#3E7AB9)
     .setCaptionLabel("toggle:reset:each")
     .setColorCaptionLabel(#BC9C3D)
     .setMode(ControlP5.SWITCH);

  cp5.addToggle("resetAll")
     .setSize(63,30)
     .setPosition(425,50)
     .setValue(false)
     .setColorBackground(#1F0F04)
     .setColorActive(#3E7AB9)
     .setColorCaptionLabel(#BC9C3D)
     .setCaptionLabel("toggle:rest:all")
     .setMode(ControlP5.SWITCH);
     
  //サウンドファイルの読み込みに時間がかかります。アプリを起動してから最低でも10秒は何も反応しない時間があります。
  //The sound file takes longer to load.There is a minimum of 10 seconds of no response time after starting the application.
  //前回の変数の初期化と設定を加える
  //Initialize and set previous variables
  currentDuration = 0;
  //sfiles = new SoundFile[47];
  minim = new Minim(this);
  sfiles = new AudioPlayer[47];
  durationsRatio = new float[noteDurations.size()];
  
  for (int i = 1; i < 5; i++) {
    int offset = 12;
    for (int j = 0; j < twtoneChromaticScale.length; j++) {
      if (i == 1) {
        offset = i * j;
      } else {
        offset = 12 * (i-1) + j;
      }
      if (j <= 7) {
        //sfiles[offset] = new SoundFile(this, twtoneChromaticScale[j] + i + ".wav");
        sfiles[offset] = minim.loadFile(twtoneChromaticScale[j] + i + ".wav");
      } else {
        if (i==4 && j==11) {
          break;
        } else {
          //sfiles[offset] = new SoundFile(this, twtoneChromaticScale[j] + str(i+1) + ".wav");
          sfiles[offset] = minim.loadFile(twtoneChromaticScale[j] + str(i+1) + ".wav");
        }
      }
    }
  }
  
  //for (int k = 0; k < noteDurations.size(); k++) {
  //  durationsRatio[k] = sfiles[0].duration() * (pow(2, k)-1)/pow(2, k);
  //}
  for (int k = 0; k < noteDurations.size(); k++) {
    durationsRatio[k] = sfiles[0].length() * (pow(2, k)-1)/pow(2, k);
  }
  ////////////////////////////////////

  ////////////////////////////////////////////////
  /*
  そして新たにGuitarSound関数をMainファイル内で作り、音を鳴らしていきます。
  You then create a new GuitarSound function in the Main file to play the sound.
  ここでDraw関数内でGStringsGNotesクラスのオブジェクトと音を鳴らす関数を連動させると音がなり続けたりする不具合に遭遇します。
  But, you may encounter a bug if in which an object of the GStringsGNotes class and a sound generating function are linked in the Draw function, and the sound continues to be generated.
  また、MousePressed関数やKeyPressed関数内でそのままオブジェクトと連動させると動作が一つ遅れてしまうといった不具合が発生してしまいます。
  Also, if you use it in the MousePressed function or KeyPressed function in conjunction with an object, the operation will be delayed by one.
  そこで苦肉の策として、ボタンとKey操作によって、一旦音を出す機能をTrueかFalseにしてから、オブジェクトと連動させることにしました。
  Therefore, the solution is to use buttons and Key operations to change the sound function to True or False, and then use it in conjunction with the guitar note object.
  */
  

  cp5.addToggle("toggleSound")
     .setPosition(525, 50)
     .setSize(63,30)
     .setValue(false)
     .setColorBackground(#1F0F04)
     .setColorActive(#3E7AB9)
     .setColorCaptionLabel(#BC9C3D)
     .setCaptionLabel("toggle:sound")
     .setMode(ControlP5.SWITCH);

  ////////////////////////////////////////////////
}


void draw() {
  background(#1F2A36);

  fb.drawBoard();
  fb.drawFrets();
  fb.drawFretMarkers();
  

  for (GStringsGNotes sn : sns) {
    sn.drawStrings();
    sn.darwGuitarNotes();
    sn.determineClicked();
  }
  
  gccb.drawChordChart(width/2-50, height/2 + 40);
  
  obs.drawOperationButtons(width/2-42, height/2);


  st.drawStaffNotation();
  st.drawTABNotation();
  
  nfns[editableLine].drawStaffNotes();
  nfns[editableLine].drawTABFretNums();
  nfns[editableLine].storeNotes();
  for (int i=0; i < 16; i++) {
    if (editedLines[i]){
      nfns[i].drawStaffNotes();
      nfns[i].drawTABFretNums();
    }
  }
  
  snapShot();

  ///////////
  guitarSound();
  ///////////

}



void toggleNotes(boolean theFlag){
  if(theFlag==true) {
    toggleDisplayNotes = true;
  } else {
    toggleDisplayNotes = false;
  }
}

void mute(boolean theFlag){
  if(theFlag==true) {
    toggleMute = true;
  } else {
    toggleMute = false;
  }
}

void toggleResetEach(boolean theFlag){
  if(theFlag==true) {
    resetEach = true;
  } else {
    resetEach = false;
  }
}

void resetAll(boolean theFlag){
  if(theFlag==true) {
    toggleResetAll = true;
    checkNoteDuration = 1;
    dChordName = "";
    initNfns();
  } else {
    toggleResetAll = false;
  }
}

/////////////////////////////

boolean checkSound = false;
void toggleSound(boolean theFlag){
  if(theFlag==true) {
    checkSound = true;
  } else {
    checkSound = false;
  }
}
/*
guitarSound関数はsnapShot関数をコピーして改良します。
The guitarSound function copies and improves on the snapShot function.
*/
void guitarSound(){
  float x = widthSpacing/2 - 10;
  float ey = heightSpacing/2 + 265;
  float ty = heightSpacing/2 + 295;
  float r = 30;
  pushStyle();
  noStroke();
  textAlign(CENTER,CENTER);
  fill(#C0C0C0);
  /*
  マウスでボタンを押すか、キーボードの「P」が押されると音が鳴るようにIf文の判定方法を変える。
  To change a determination method of an If sentence so as to make a sound when a button is pressed with a mouse or a 'P' of a keyboard is pressed.
  */
  if (((mousePressed) && (x+r/2 > mouseX)&&(ey-r/2 < mouseY)&&(x-r/2 < mouseX)&&(ey+r/2 > mouseY))  || (keyPressed && (key=='p' || key=='P'))) {
    fill(#ED654A);
    r = 36;
    /*
    checkSoundがTrueになっていると、For文とSwitchCase文を使い、音を鳴らせる処理をします。
    If checkSound is True, the For and SwitchCase statements are used to make sounds.
    */
    if (checkSound) {
      for (int i = 0; i < sixStrings; i++) {
        for (int k = 0; k < sns[i].theObjNotesArray.length; k++) {
          /*
          sns[i].fretClicked[k]のiは、どのギターの弦かを表し、kはどのフレットかを表しています。
          "i" in "sns[i].fretClicked[k]" corresponds to the guitar string number and "k" corresponds to the fret number.
          */
          if (sns[i].fretClicked[k] && !(sns[i].checkMute)) {
            /*
            それぞれの弦の開放弦に対応するノート番号をオフセットに設定します。
そして、cueメソッドに現在の音の長さを引数として入れて、再生ヘッドの位置を変えます。
最後にplayメソッドで音を再生させた後、break文でSwitch文を脱出して、次のiの処理を続けます。
            Sets the note number corresponding to the open chord of each chord to the offset.
It then changes the position of the playhead by passing the current sound length as an argument to the cue method.
Finally, after playing the sound with the play method, use the break statement to escape the Switch statement and proceed to the next i.
            */
            switch(i){
              case 0:
                //sfiles[24 + k].cue(currentDuration);
                //sfiles[24 + k].play(1.0, 1.0);
                sfiles[24 + k].play(1);
                break;
              case 1:
                //sfiles[19 + k].cue(currentDuration);
                //sfiles[19 + k].play(1.0, 1.0);
                sfiles[19 + k].play(1);
                break;
              case 2:
                //sfiles[15 + k].cue(currentDuration);
                //sfiles[15 + k].play(1.0, 1.0);
                sfiles[15 + k].play(1);
                break;
              case 3:
                //sfiles[10 + k].cue(currentDuration);
                //sfiles[10 + k].play(1.0, 1.0);
                sfiles[10 + k].play(1);
                break;
              case 4:
                //sfiles[5 + k].cue(currentDuration);
                //sfiles[5 + k].play(1.0, 1.0);
                sfiles[5 + k].play(1);
                break;
              case 5:
                //sfiles[k].cue(currentDuration);
                //sfiles[k].play(1.0, 1.0);
                sfiles[k].play(1);
                break;
            }
            
          }
        }
      }
    }
    
  }
  ellipse(x,ey,r,r);
  text("Sound",x,ty);
  popStyle();
}
/////////////////////////////


void snapShot(){
  float x = widthSpacing/2 - 10;
  float ey = heightSpacing/2 + 170;
  float ty = heightSpacing/2 + 200;
  float r = 30;
  pushStyle();
  noStroke();
  textAlign(CENTER,CENTER);
  fill(#BC9C3D);
  if ((x+r/2 > mouseX)&&(ey-r/2 < mouseY)&&(x-r/2 < mouseX)&&(ey+r/2 > mouseY)) {
    if (mousePressed){
      fill(#ED654A);
      r = 36;
      String in = nf(imageNumber, 3);
      save("images/"+in+".png");
      imageNumber++;
    } else {
      fill(#C0C0C0);
      r = 33;
    }
  }
  ellipse(x,ey,r,r);
  text("Snapshot",x,ty);
  popStyle();
}

void initNfns() {
  editableLine = 0;
  editedLine = 0;
  for (int i = 0; i < 16; i++) {
    editedLines[i] = false;
  }
  for (int i =0 ; i < 16; i++) {
    nfns[i] = new NotesFretNums(i, -150, height/2-60, -150, height/2+40);
  }
}

void determineChord(int[] theArray){
  for (GStringsGNotes sn : sns) {
    sn.initFretClicked();
  }
  for (int k = 0; k < theArray.length; k++) {
    if (theArray[k] == -1) {
      sns[k].checkMute = true;
    } else {
      sns[k].fretClicked[theArray[k]] = true;

    }
  }
}

void mousePressed(){
  
  if ((obs.cOperationButtons[0][0] > mouseX)&&(obs.cOperationButtons[0][1] < mouseY)&&(obs.cOperationButtons[0][2] < mouseX)&&(obs.cOperationButtons[0][3] > mouseY)){
    
    
    for (int i = 15; i >= 0; i--) {
      if (editedLines[i]) {
        editableLine = editedLine;
        editedLines[editedLine] = false;
        break;
      }
    }
    
    for (int i = 15; i >= 0; i--) {
      if (editedLines[i]) {
        editedLine = i;
        break;
      }
    }
    
    nfns[editableLine].storeNotes();
    
    if (editableLine < editedLine) {
      initNfns();
    }

  }
  
  if ((obs.cOperationButtons[1][0] > mouseX)&&(obs.cOperationButtons[1][1] < mouseY)&&(obs.cOperationButtons[1][2] < mouseX)&&(obs.cOperationButtons[1][3] > mouseY)){
    if (switchRecord) {
      switchRecord = false;
    } else {
      switchRecord = true;
    }
  }
  
  if ((obs.cOperationButtons[2][0] > mouseX)&&(obs.cOperationButtons[2][1] < mouseY)&&(obs.cOperationButtons[2][2] < mouseX)&&(obs.cOperationButtons[2][3] > mouseY)){
    
    editedLine = editableLine;
    editedLines[editedLine] = true;
    
    switch(checkNoteDuration){
      case 1:
       editableLine = (editedLine + 16) % 16;
       break;
      case 2:
       editableLine = (editedLine + 8) % 16;
       break;
      case 4:
       editableLine = (editedLine + 4) % 16;
       break;    
      case 8:
       editableLine = (editedLine + 2) % 16;
       break;
      case 16:
       editableLine = (editedLine + 1) % 16;
       break;
    }
    
    nfns[editedLine].storeNotes();
    

    if (editableLine < editedLine) {
      if (switchRecord) {
        String in = nf(imageNumber, 3);
        save("images/"+in+".png");
        imageNumber++;
      }
      initNfns();
    }
    
  }
  
  
  if ((obs.cOperationButtons[3][0] > mouseX)&&(obs.cOperationButtons[3][1] < mouseY)&&(obs.cOperationButtons[3][2] < mouseX)&&(obs.cOperationButtons[3][3] > mouseY)){
    downS = true;
    upS = false;

  }
  
  if ((obs.cOperationButtons[4][0] > mouseX)&&(obs.cOperationButtons[4][1] < mouseY)&&(obs.cOperationButtons[4][2] < mouseX)&&(obs.cOperationButtons[4][3] > mouseY)){
    upS = true;
    downS = false;

  }
  
  /*
  仕上げに現在のcheckNoteDurationの値に合わせて、currentDurationに対応するサウンドの長さを代入します。
  To finish, we assign the length of the sound corresponding to currentDuration to match the current checkNoteDuration value.
  */
  
  if ((obs.cOperationButtons[5][0] > mouseX)&&(obs.cOperationButtons[5][1] < mouseY)&&(obs.cOperationButtons[5][2] < mouseX)&&(obs.cOperationButtons[5][3] > mouseY)){
        checkNoteDuration = 1;
        //
        currentDuration = durationsRatio[0];
      }
  if ((obs.cOperationButtons[6][0] > mouseX)&&(obs.cOperationButtons[6][1] < mouseY)&&(obs.cOperationButtons[6][2] < mouseX)&&(obs.cOperationButtons[6][3] > mouseY)){
        checkNoteDuration = 2;
        //
        currentDuration = durationsRatio[1];
      }
  if ((obs.cOperationButtons[7][0] > mouseX)&&(obs.cOperationButtons[7][1] < mouseY)&&(obs.cOperationButtons[7][2] < mouseX)&&(obs.cOperationButtons[7][3] > mouseY)){
        checkNoteDuration = 4;
        //
        currentDuration = durationsRatio[2];
      }
  if ((obs.cOperationButtons[8][0] > mouseX)&&(obs.cOperationButtons[8][1] < mouseY)&&(obs.cOperationButtons[8][2] < mouseX)&&(obs.cOperationButtons[8][3] > mouseY)){
        checkNoteDuration = 8;
        //
        currentDuration = durationsRatio[3];
      }
  if ((obs.cOperationButtons[9][0] > mouseX)&&(obs.cOperationButtons[9][1] < mouseY)&&(obs.cOperationButtons[9][2] < mouseX)&&(obs.cOperationButtons[9][3] > mouseY)){
        checkNoteDuration = 16;
        //
        currentDuration = durationsRatio[4];
      }
      
}

/*
プログラムを動かします。
Run the program.
このアプリの実際の使い方は、まずギターコードや単音をアプリで再生して確認しながら、簡単な譜面を作ります。
To actually use the app, you first create a simple musical score by playing and checking guitar chords and single notes in the app.
そして、その後Sunvox等のソフトウェアを使い、擬似的なギターの音を作っていくか、もしくは逆の使い方でも良いと思います。
You can then use Sunvox or other software to create the sound, or vice versa.
*/
/*
ここで行っているSunvoxの操作のやり方は前回の動画やブログで説明してますので、省略します。
I have already explained How to operate Sunvox here in the previous video and blog, so I will omit it.
*/
/*
五線譜に対応する音符を確認しながら作業できます。
You can check the notes corresponding to the staff notation.
TABを押せば楽に横に移動できます。
You can move sideways easily by pressing TAB.
*/
/*
以上でこの動画シリーズは終了です。
改善する場所は山程ありますが、それは各自で行ってください。
いつかもっと分かりやすい動画にしてもう一度やり直すかもしれません。
それでは。
That's all for this video series.
There are many places to improve, but please do it by yourself.
Someday, I may make a video that is easier to understand and try again.
Bye.
*/
