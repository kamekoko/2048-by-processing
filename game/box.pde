/*ゲームの状態*/

class Box {
  int value ; //数値
  int address ; //アドレス
  boolean isAlreadyUpdated ; //ステータス（キー操作時に既に更新されたブロックであるかどうか）（ブロック間の結合の可否の判定に使用）

  Box(int v, int a) {
    value = v ;
    address = a ;
    isAlreadyUpdated = false ;
  }

  boolean combine(Box b) { //bと結合可能なら自身のデータを更新
    if (isAlreadyUpdated) return false ;
    if (value != b.value) return false ;
    isAlreadyUpdated = true ;
    value *= 2 ;
    return true ;
  }

  void show(int size) { //ブロックと数値の表示
    pushStyle() ;
    textSize(30) ;
    fill(240, max(0, 240 - 4 * value), 0) ;
    int x = address % 4 * 100 + 100 ;
    int y = address / 4 * 100 + 100 ;
    rect(x, y, 100, 100) ;
    fill(0) ;
    text(value, 35 + x, 75 + y) ;
    popStyle() ;
  }
}

class Boxes extends ArrayList<Box> {
  int max ; //ブロックの最大値
  boolean[] isUsed ; //各ブロックが埋まっているか，または選択されているか

  Boxes() { //ゲームの初期設定
    max = 2 ;
    isUsed = new boolean[fieldSize * fieldSize] ;
    int randomAddress = (int)random(fieldSize * fieldSize) ;
    isUsed[randomAddress] = true ;
    Box b = new Box(2, randomAddress) ;
    this.add(b) ;
    randomAddress = (int)random(fieldSize * fieldSize) ;
    while (isUsed[randomAddress]) randomAddress = (int)random(fieldSize * fieldSize) ;
    isUsed[randomAddress] = true ;
    Box b2 = new Box(2, randomAddress) ;
    this.add(b2) ;
  }

  boolean filled() { //ゲームオーバー条件（全部埋まる && 隣のブロックと結合不可能）
    for (int i = 0 ; i < isUsed.length ; i++) {
      if (!isUsed[i]) return false ;
    }
    for (int i = 0 ; i < isUsed.length - 1 ; i++) {
      Box b = getBox(i) ;
      if (i % fieldSize != fieldSize - 1 && i < fieldSize * (fieldSize - 1)) {
        if (b.value == getBox(i + 1).value) return false ;
        if (b.value == getBox(i + fieldSize).value) return false ;
      }
      else if (i % fieldSize == fieldSize - 1) {
        if (b.value == getBox(i + fieldSize).value) return false ;
      }
      else if (i >= fieldSize * (fieldSize - 1)) {
        if (b.value == getBox(i + 1).value) return false ;
      }
    }
    for (Box b : this) {
      score += b.value ;
    }
    return true ;
  }

  boolean goal() { //ゲームクリア条件
    return (max == 2048) ? true : false ;
  }

  void clearAll() { //ゲーム初期化
    this.clear() ;
    max = 0 ;
    isUsed = new boolean[fieldSize * fieldSize] ;
  }

  void remove(Box b) { //ブロック削除（ブロック結合時に使用）
    isUsed[b.address] = false ;
    super.remove(b) ;
  }

  Box getBox(int ad) { //特定のアドレスのブロックを取得
    for (Box b : this) {
      if (b.address == ad) return b ;
    }
    return null ;
  }

  void setAddress(Box b, int ad) { //ブロックのアドレスを更新
    isUsed[b.address] = false ;
    b.address = ad ;
    isUsed[ad] = true ;
  }

  void createBox() { //新規ブロック作成
    int randomAddress = (int)random(isUsed.length) ;
    while (isUsed[randomAddress]) randomAddress = (int)random(isUsed.length) ;
    isUsed[randomAddress] = true ;
    if (max <= 2) add(new Box(2, randomAddress)) ;
    else {
      double r = random(1) ;
      if (r > 0.7) add(new Box(4, randomAddress)) ;
      else add(new Box(2, randomAddress)) ;
    }
  }

  void resetUpdateTag() { //各キー操作後のブロックのステータスをリセット
    for (Box b : this) {
      b.isAlreadyUpdated = false ;
    }
  }

  void show() {
    for (Box b : this) {
      b.show(fieldSize) ;
    }
  }
}
