import UIKit
import PlaygroundSupport

let a = CircleWaveView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
a.layer.contentsScale = 10

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = a
