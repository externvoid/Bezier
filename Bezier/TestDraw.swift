//[iPhone] UIBezierPath 図形の描画 (Swift)
import UIKit
import Darwin
import Swift

class TestDraw: UIView{
    override func drawRect(rect: CGRect) {
// draw line
//      self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 90 / 180.0))
      var line    = UIBezierPath()
      line.moveToPoint(CGPointMake(50, 50))
      line.addLineToPoint(CGPointMake(220, 350))
      UIColor.redColor().setStroke()
      line.lineWidth = 3
      line.stroke()
// draw box
      var box0 = UIBezierPath(rect: CGRectMake(50, 50, 100, 100))
      UIColor.redColor().setStroke()
      box0.stroke()
      // CGPath の宣言
      let path:CGMutablePath = CGPathCreateMutable()
      // 始点を決定
      CGPathMoveToPoint(path, nil, 50.0, 50.0)
      // ラインを追加
      CGPathAddLineToPoint(path, nil, 130.0, 300.0)
      CGPathAddLineToPoint(path, nil, 50.0, 300.0)
      // CGPath を閉じる
      CGPathCloseSubpath(path)
      box0.CGPath = path
      UIColor.greenColor().setStroke()
      box0.stroke()
      
      let     scWidth = Int(UIScreen.mainScreen().bounds.size.width)
      print("scWidth = \(scWidth)")
      let     scHeight = Int(UIScreen.mainScreen().bounds.size.height)
      print("scHeight = \(scHeight)")
      print(rect.size.height)
      print(rect.size.width)
// draw candles
      var result: [[String]] = []
      var errBundle: NSError?
      if let csvPath: String? 
        = NSBundle.mainBundle().pathForResource("TEST_StockCR", ofType: "csv") {
        let csvString = (try! NSString(contentsOfFile: csvPath!,
                                 encoding: NSUTF8StringEncoding)) as String
        print(errBundle?.localizedDescription)
        csvString.enumerateLines { (line, stop) -> () in
            result.append(line.componentsSeparatedByString(","))
        }
      }
      print(result.count)
// taking last 10 elements
      let r: Range<Int> = 0..<result.count-10
      result.removeRange(r)
      for (idx, e) in result.enumerate() {
        print("\(idx) : \(e)")
      }
      var ar: [[Double]] = []
      let tap = minmax(result, ar: &ar)
      print(tap)
      var candle: [[Double]] = logiToScreen(ar, tap: tap)
      
      for (idx, e) in candle.enumerate() {
        print("\(idx) : \(e)")
      }
      let wRate: CGFloat = rect.size.width/10.0
// here drawing
      for (idx, e) in candle.enumerate() {
// white candle body
        if e[0] > e[3] {
          let x: CGFloat = wRate*CGFloat(idx)
          let y: CGFloat = CGFloat(e[3])
          let w: CGFloat = wRate
          let h: CGFloat = CGFloat(e[0]-e[3])
          
          var box = UIBezierPath(rect: CGRectMake(x, y, w, h))
          UIColor.blueColor().setStroke()
          box.lineWidth = 1
          box.stroke()
        } else {
          let x: CGFloat = wRate*CGFloat(idx)
          let y: CGFloat = CGFloat(e[0])
          let w: CGFloat = wRate
          let h: CGFloat = -1.0*CGFloat(e[0]-e[3])

          var box = UIBezierPath(rect: CGRectMake(x, y, w, h))
          UIColor.blueColor().setFill()
          box.fill()
          UIColor.blueColor().setStroke()
          box.lineWidth = 1
          box.stroke()
        }
// white candle upper mustache
        if e[1] < min(e[0], e[3]) {
          let x: CGFloat = wRate*(CGFloat(idx+1)-0.5)
          let y: CGFloat = CGFloat(min(e[0], e[3]))
          let y0: CGFloat = CGFloat(e[1])
          var line = UIBezierPath()
          line.moveToPoint(CGPointMake(x, y))
          line.addLineToPoint(CGPointMake(x, y0))
          UIColor.blueColor().setStroke()
          line.lineWidth = 1
          line.stroke()
        }
// white candle lower mustache
        if e[2] > max(e[0], e[3]) {
          let x: CGFloat = wRate*(CGFloat(idx+1)-0.5)
          let y: CGFloat = CGFloat(max(e[0], e[3]))
          let y0: CGFloat = CGFloat(e[2])
          var line = UIBezierPath()
          line.moveToPoint(CGPointMake(x, y))
          line.addLineToPoint(CGPointMake(x, y0))
          UIColor.blueColor().setStroke()
          line.lineWidth = 1
          line.stroke()
        }
      }
      TopLevelFunction()
    }
}
