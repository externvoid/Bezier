import Foundation
// CGPath の宣言
let path:CGMutablePath = CGPathCreateMutable()
// 始点を決定
CGPathMoveToPoint(path, nil, -130.0, 300.0)
// ラインを追加
CGPathAddLineToPoint(path, nil, 130.0, 300.0)
CGPathAddLineToPoint(path, nil, -130.0, 300.0)
// CGPath を閉じる
CGPathCloseSubpath(path)
println(path)
