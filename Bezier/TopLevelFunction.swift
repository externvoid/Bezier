//
//  TopLevelFunction.swift
//  Bezier
//
//  Created by AppWizard on 2015/04/20.
//  Copyright (c) 2015年 htanaka. All rights reserved.
//

//import Foundation
//クラスの外で定義した関数は、何処からでも呼び出せるみたい。試しに、
//TestDrawクラス内の、drawRectメソッド内で動かしてみた。
import UIKit
import Darwin
func TopLevelFunction() {
  print("Top Level Function")
  print("OK")
}

func minmax(result: [[String]], inout ar: [[Double]]) -> (Double, Double) {
  //  taking part of Array
  let result0 = result.map( {Array($0[1...4])} )
  ar = result0.map({$0.map({atof($0)})})
  var max: Double = -1.0, min: Double = 1.0e38
  for e in ar {
    max = e.reduce(max, combine: {$0>$1 ? $0 : $1})
    min = e.reduce(min, combine: {$0<$1 ? $0 : $1})
  }
  return (min, max)
}

func logiToScreen(ar: [[Double]], tap: (Double, Double)) -> [[Double]] {
  let h:Double = tap.1 - tap.0,scH:Double = 480.0 //Double(
//                                   UIScreen.mainScreen().bounds.size.height)
  print("shH=\(scH)")
  let scW:Double = Double(UIScreen.mainScreen().bounds.size.width)
  print("shW=\(scW)")

  let b:Double = -scH/h, oy: Double = tap.0
  // only y-value converting
  var candle: [[Double]] = []
  candle = ar.map({$0.map({ b*($0-oy)+scH })})
  
  return candle
}
