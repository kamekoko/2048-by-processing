/*ゲーム用変数*/
int fieldSize = 4 ; //ゲームのフィールドのサイズ（固定）
Boxes boxes ; //ブロック集合
int gameStatus = 0 ; //ゲーム状態（0 = スタート画面, 1 = ゲーム中, 2 = ゲームオーバー, 3 = ゲームをリセット, 4 = ゲームクリア）
int score = 0 ; //ゲームスコア

/*Loading画面のアニメーション*/
double v = 0 ; //ロケットの速度
int y = 500 ; //ロケットの座標
double v2 = 0 ; //ブースターの速度
int y2 = 500 ; //ブースターの座標
double a2 =  1 ; //ブースターの加速度

void setup() {
  size(600, 600) ;
  frameRate(40) ;
  background(0) ;
  boxes = new Boxes() ;
}

void draw() {
  background(30) ;

  if (frameCount <= 600) {
    pushStyle() ;
    textSize(50) ;
    text("Loading...", 200, 200) ;
    popStyle() ;
    rocet() ;
    rocet2() ;
  }

  else {
    if (gameStatus == 0) {
      pushMatrix() ;
      pushStyle() ;
      translate(100, 100) ;
      textSize(70) ;
      text(2048, 150, 0) ;
      text("Game Start", 0, 200) ;
      popStyle() ;
      popMatrix() ;
    }

    if (gameStatus == 1) {
      pushMatrix() ;
      pushStyle() ;
      translate(100, 100) ;
      fill(255, 255, 255) ;
      rect(0, 0, 400, 400) ;
      for (int i = 1 ; i < fieldSize ; i++) {
        line(100 * i, 0, 100 * i, 400) ;
        line(0, 100 * i, 400, 100 * i) ;
      }
      popStyle() ;
      popMatrix() ;

      pushStyle() ;
      boxes.show() ;
      popStyle() ;
    }

    if (gameStatus == 2) {
      pushMatrix() ;
      pushStyle() ;
      translate(100, 100) ;
      textSize(70) ;
      text("Game Over", 0, 0) ;
      text("score : " + score, 0, 100) ;
      popStyle() ;
      popMatrix() ;
    }

    if (gameStatus == 3) {
      pushMatrix() ;
      pushStyle() ;
      translate(100, 100) ;
      textSize(70) ;
      fill(255, 0, 0) ;
      text("Re Start?", 0, 0) ;
      fill(255) ;
      text("score : " + score, 0, 100) ;
      popStyle() ;
      popMatrix() ;
    }

    if (gameStatus == 4) {

      pushStyle() ;
      textSize(50) ;
      text("クリア", 200, 200) ;
      text("beating", 200, 400) ;
      popStyle() ;

      pushMatrix() ;
      pushStyle() ;
      translate(100, 100) ;
      fill(255, 255, 255) ;
      rect(0, 0, 400, 400) ;
      for (int i = 1 ; i < fieldSize ; i++) {
        line(100 * i, 0, 100 * i, 400) ;
        line(0, 100 * i, 400, 100 * i) ;
      }
      popStyle() ;
      popMatrix() ;

      pushStyle() ;
      boxes.show() ;
      popStyle() ;
    }
  }
}
