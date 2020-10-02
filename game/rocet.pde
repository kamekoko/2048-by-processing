/*ロケットのアニメーション*/

void rocet() {

  pushMatrix() ;
  pushStyle() ;
  noStroke() ;
  translate(width / 2 , y) ;
  if (frameCount > 200) {
    translate(frameCount - 200, 0) ;
    rotate(radians((frameCount -200) / 2.5)) ;
  }
  triangle(0, -90, -10, -60, 10, -60) ;
  rect(-10, -60, 20, 30) ;
  rect(-7, -30, 14, 100) ;
  triangle(-7, 70, -14, 90, 0, 90) ;
  triangle(-7, 70, 0, 90, 7, 70) ;
  triangle(7, 70, 0, 90, 14, 90) ;
  stroke(200, 100, 0) ;
  for(int i = 0 ; i < 50 ; i++) {
    line(random(-10, 10), 90, random(-15, 15), 120 + random(-10, 10)) ;
  }
  popStyle() ;
  popMatrix() ;

  if (frameCount > 100 && frameCount % 30 == 0) v++ ;
  y -= v ;

}


void rocet2() {

  pushMatrix() ;
  pushStyle() ;
  noStroke() ;
  translate(width / 2 , y2) ;
  if (frameCount > 200 && frameCount < 320) {
    translate(frameCount - 200, 0) ;
    rotate(radians((frameCount -200) / 2.5)) ;
  }
  else if (frameCount >= 320 && frameCount < 440) {
    translate(120 - (frameCount - 320), 0) ;
    rotate(radians(120 / 2.5 - (frameCount -320) / 2.5)) ;
  }
  triangle(-20, 0, -28, 20, -12, 20) ;
  rect(-28, 20, 16, 50) ;
  triangle(-14, 70, -21, 90, -7, 90) ;
  triangle(-14, 70, -21, 90, -28, 70) ;
  triangle(-28, 70, -21, 90, -35, 90) ;
  triangle(20, 0, 28, 20, 12, 20) ;
  rect(12, 20, 16, 50) ;
  triangle(14, 70, 21, 90, 7, 90) ;
  triangle(14, 70, 21, 90, 28, 70) ;
  triangle(28, 70, 21, 90, 35, 90) ;
  stroke(200, 100, 0) ;
  if (frameCount < 320 || frameCount > 440) {
    for(int i = 0 ; i < 50 ; i++) {
      line(random(10, 30), 90, random(2, 37), 120 + random(-10, 10)) ;
      line(random(-30, -10), 90, random(-37, -2), 120 + random(-10, 10)) ;
    }
  }
  popStyle() ;
  popMatrix() ;

  if (frameCount > 360 && frameCount < 400) a2 = 1 ;
  else if (frameCount >= 400 && frameCount < 460) a2 = 0.5 ;
  else if (frameCount >= 460 && frameCount < 500) a2 = 0.2 ;
  if (frameCount > 100 && frameCount < 240 && frameCount % 30 == 0) v2++ ;
  if (frameCount > 240 && frameCount < 500 && frameCount % 20 == 0) v2 -= a2 ;
  if (frameCount < 500) y2 -= v2 ;
  else if (frameCount == 500) y2 = 500 ;
}
