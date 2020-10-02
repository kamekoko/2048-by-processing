  /*ボタン操作（上下左右キー）*/

void keyPressed() {

  if (frameCount < 500) return ;

  if (gameStatus == 0) {
    gameStatus = 1 ;
    return ;
  }
  if (gameStatus == 1 && boxes.filled()) {
    gameStatus = 2 ;
    return ;
  }
  if (gameStatus == 2) {
    gameStatus = 3 ;
    return ;
  }
  if (gameStatus == 3) {
    gameStatus = 0 ;
    boxes.clearAll() ;
    boxes = new Boxes() ;
    return ;
  }
  if (boxes.goal()) {
    gameStatus = 4 ;
    return ;
  }
  if (gameStatus == 4) {
    gameStatus = 3 ;
    return ;
  }

  if (key == CODED) {

    boolean isUpdated = false ;

    /*ブロックの移動・更新*/
    if (keyCode == LEFT) {
      for (int i = 0 ; i < fieldSize ; i++) {
        for (int j = 1 ; j < fieldSize ; j++) {
          int address = fieldSize * i + j ;
          Box b = boxes.getBox(address) ;
          if (b == null) continue ;
          int k = address - 1 ;
          if (! boxes.isUsed[k]) {
            isUpdated = true ;
            while (! boxes.isUsed[k] && k % fieldSize != fieldSize - 1 && k != 0) {
              boxes.setAddress(b, k) ;
              k-- ;
            }
            if (k % fieldSize == fieldSize - 1) continue ;
            else if (k == 0 && ! boxes.isUsed[k]) {
              boxes.setAddress(b, k) ;
              continue ;
            }
          }
          Box bb = boxes.getBox(k) ;
          if (bb.combine(b)) {
            if (bb.value > boxes.max) boxes.max = bb.value ;
            boxes.remove(b) ;
            isUpdated = true ;
          }
        }
      }
    }

    else if (keyCode == RIGHT) {
      int adMax = fieldSize * fieldSize - 1 ;
      for (int i = 0 ; i < fieldSize ; i++) {
        for (int j = fieldSize - 2 ; j >= 0 ; j--) {
          int address = fieldSize * i + j ;
          Box b = boxes.getBox(address) ;
          if (b == null) continue ;
          int k = address + 1 ;
          if (! boxes.isUsed[k]) {
            isUpdated = true ;
            while (! boxes.isUsed[k] && k % fieldSize != 0 && k != adMax) {
              boxes.setAddress(b, k) ;
              k++ ;
            }
            if (k % fieldSize == 0) continue ;
            else if (k == adMax && ! boxes.isUsed[k]) {
              boxes.setAddress(b, k) ;
              continue ;
            }
          }
          Box bb = boxes.getBox(k) ;
          if (bb.combine(b)) {
            if (bb.value > boxes.max) boxes.max = bb.value ;
            boxes.remove(b) ;
            isUpdated = true ;
          }
        }
      }
    }

    else if (keyCode == UP) {
      for (int i = 1 ; i < fieldSize ; i++) {
        for (int j = 0 ; j < fieldSize ; j++) {
          int address = fieldSize * i + j ;
          Box b = boxes.getBox(address) ;
          if (b == null) continue ;
          int k = address - fieldSize ;
          if (! boxes.isUsed[k]) {
            isUpdated = true ;
            while (k >= 0 && ! boxes.isUsed[k]) {
              boxes.setAddress(b, k) ;
              k -= fieldSize ;
            }
            if (k < 0) {
              boxes.setAddress(b, k + fieldSize) ;
              continue ;
            }
          }
          Box bb = boxes.getBox(k) ;
          if (bb.combine(b)) {
            if (bb.value > boxes.max) boxes.max = bb.value ;
            boxes.remove(b) ;
            isUpdated = true ;
          }
        }
      }
    }

    else if (keyCode == DOWN) {
      int adMax = fieldSize * fieldSize - 1 ;
      for (int i = fieldSize - 2 ; i >= 0 ; i--) {
        for (int j = 0 ; j < fieldSize ; j++) {
          int address = fieldSize * i + j ;
          Box b = boxes.getBox(address) ;
          if (b == null) continue ;
          int k = address + fieldSize ;
          if (! boxes.isUsed[k]) {
            isUpdated = true ;
            while (k <= adMax && ! boxes.isUsed[k]) {
              boxes.setAddress(b, k) ;
              k += fieldSize ;
            }
            if (k > adMax) {
              boxes.setAddress(b, k - fieldSize) ;
              continue ;
            }
          }
          Box bb = boxes.getBox(k) ;
          if (bb.combine(b)) {
            if (bb.value > boxes.max) boxes.max = bb.value ;
            boxes.remove(b) ;
            isUpdated = true ;
          }
        }
      }
    }

    /*新しいブロックの出現*/
    if (isUpdated) boxes.createBox() ;

    /*整理*/
    boxes.resetUpdateTag() ;
  }
}
