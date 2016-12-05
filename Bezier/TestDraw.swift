//[iPhone] UIBezierPath 図形の描画 (Swift)
import UIKit
import Darwin
import Swift

class TestDraw: UIView{
    override func draw(_ rect: CGRect) {
// draw line
//      self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 90 / 180.0))
      let line    = UIBezierPath()
      line.move(to: CGPoint(x: 50, y: 50))
      line.addLine(to: CGPoint(x: 220, y: 350))
      UIColor.red.setStroke()
      line.lineWidth = 3
      line.stroke()
// draw box
      let box0 = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 100, height: 100))
      UIColor.red.setStroke()
      box0.stroke()
      // CGPath の宣言
      let path:CGMutablePath = CGMutablePath()
      // 始点を決定
//      CGPathMoveToPoint(path, nil, 50.0, 50.0)
      path.move(to: CGPoint(x:50.0, y:50.0))
      // ラインを追加
      path.addLine(to: CGPoint(x: 130.0, y: 300.0))
      path.addLine(to: CGPoint(x: 50.0, y: 300.0))
//      CGPathAddLineToPoint(path, nil, 130.0, 300.0)
// 1     CGPathAddLineToPoint(path, nil, 50.0, 300.0)
      // CGPath を閉じる
      path.closeSubpath()
      box0.cgPath = path
      UIColor.green.setStroke()
      box0.stroke()
      
      let     scWidth = Int(UIScreen.main.bounds.size.width)
      print("scWidth = \(scWidth)")
      let     scHeight = Int(UIScreen.main.bounds.size.height)
      print("scHeight = \(scHeight)")
      print(rect.size.height)
      print(rect.size.width)
// draw candles
      var result: [[String]] = []
      guard let csvPath = Bundle.main.path(forResource: "TEST_StockCR", ofType: "csv")
        else { print("file not found") ; return }
      do {
      let csvString = try NSString(contentsOfFile: csvPath,
                                 encoding: String.Encoding.utf8.rawValue) as String
        csvString.enumerateLines { (line, stop) -> () in
            result.append(line.components(separatedBy: ","))
        }
      } catch let errBundle { print(errBundle.localizedDescription) }
// ref.      http://llcc.hatenablog.com/entry/2015/06/16/235054
      print("#of rows = \(result.count)") // about 6000
// taking last 10 elements
      let numCandle = 30
      let r: CountableRange<Int> = 0..<result.count - numCandle
      result.removeSubrange(r)
      for (idx, e) in result.enumerated() {
        print("\(idx) : \(e)")
      }
      var ar: [[Double]] = []
      let tMinMax = minmax(result, ar: &ar)
      print("min, max = \(tMinMax)")
      let candle: [[Double]] = logiToScreen(ar, tap: tMinMax)
      
      for (idx, e) in candle.enumerated() {
        print("\(idx) : \(e)")
      }
      let wRate: CGFloat = rect.size.width/CGFloat(numCandle)
// here drawing
      for (idx, e) in candle.enumerated() {
// white candle body
        if e[0] > e[3] {
          let x: CGFloat = wRate*CGFloat(idx)
          let y: CGFloat = CGFloat(e[3])
          let w: CGFloat = wRate
          let h: CGFloat = CGFloat(e[0]-e[3])
          
          let box = UIBezierPath(rect: CGRect(x: x, y: y, width: w, height: h))
          UIColor.blue.setStroke()
          box.lineWidth = 1
          box.stroke()
        } else {
          let x: CGFloat = wRate*CGFloat(idx)
          let y: CGFloat = CGFloat(e[0])
          let w: CGFloat = wRate
          let h: CGFloat = -1.0*CGFloat(e[0]-e[3])

          let box = UIBezierPath(rect: CGRect(x: x, y: y, width: w, height: h))
          UIColor.blue.setFill()
          box.fill()
          UIColor.blue.setStroke()
          box.lineWidth = 1
          box.stroke()
        }
// white candle upper mustache
        if e[1] < min(e[0], e[3]) {
          let x: CGFloat = wRate*(CGFloat(idx+1)-0.5)
          let y: CGFloat = CGFloat(min(e[0], e[3]))
          let y0: CGFloat = CGFloat(e[1])
          let line = UIBezierPath()
          line.move(to: CGPoint(x: x, y: y))
          line.addLine(to: CGPoint(x: x, y: y0))
          UIColor.blue.setStroke()
          line.lineWidth = 1
          line.stroke()
        }
// white candle lower mustache
        if e[2] > max(e[0], e[3]) {
          let x: CGFloat = wRate*(CGFloat(idx+1)-0.5)
          let y: CGFloat = CGFloat(max(e[0], e[3]))
          let y0: CGFloat = CGFloat(e[2])
          let line = UIBezierPath()
          line.move(to: CGPoint(x: x, y: y))
          line.addLine(to: CGPoint(x: x, y: y0))
          UIColor.blue.setStroke()
          line.lineWidth = 1
          line.stroke()
        }
      }
      TopLevelFunction()
    }
}
