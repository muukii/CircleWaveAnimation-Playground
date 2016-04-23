import UIKit
import XCPlayground

let a = CircleWaveView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
a.layer.contentsScale = 10
XCPlaygroundPage.currentPage.liveView = a