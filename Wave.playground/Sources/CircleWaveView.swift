// CircleWave.swift
//
// Copyright (c) 2015 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class CircleWaveView: BaseDisplayView {

  public override func setup() {
    super.setup()
    self.backgroundColor = UIColor.clear

    self.circleLayer1.strokeColor = UIColor(white: 1, alpha: 0.9).cgColor
    self.circleLayer1.fillColor = UIColor.clear.cgColor

    self.circleLayer2.strokeColor = UIColor(white: 1, alpha: 0.9).cgColor
    self.circleLayer2.fillColor = UIColor.clear.cgColor

    self.layer.addSublayer(self.circleLayer1)
    self.layer.addSublayer(self.circleLayer2)
  }

  public let speed: CGFloat = 0.01

  public override func update() {
    let path1 = UIBezierPath()
    let path2 = UIBezierPath()

    let amplitude: CGFloat = 1000

    let firstPoint1 = self.circleWave(angle: 0, step: step, amplitude: amplitude, n: 4)
    path1.move(to: firstPoint1)
    let firstPoint2 = self.circleWave(angle: 0, step: step, amplitude: -amplitude, n: 4)
    path2.move(to: firstPoint2)

    for i in stride(from: CGFloat(0), to: CGFloat(360), by: circleResolution) {
      let point1 = self.circleWave(angle: i, step: step, amplitude: amplitude, n: 4)
      path1.addLine(to: point1)
      let point2 = self.circleWave(angle: i, step: step, amplitude: -amplitude, n: 4)
      path2.addLine(to: point2)
      step += 1
    }

    self.circleLayer1.path = path1.cgPath
    self.circleLayer2.path = path2.cgPath
  }

  // MARK: - Private
  private let circleLayer1 = CAShapeLayer()
  private let circleLayer2 = CAShapeLayer()

  private var step: UInt64 = 0

  private let circleResolution: CGFloat = 0.5

  private let rad = CGFloat(CGFloat.pi/180)

  private func circleWave(angle: CGFloat, step: UInt64, amplitude: CGFloat, n: CGFloat) -> CGPoint {

    let frame = self.frame.insetBy(dx: 30, dy: 30)

    let radian = angle * rad
    let radius = frame.width/2
    let rate = (1 - cos(((CGFloat(step)) * (circleResolution - speed)) * rad ))/40
    let _radius = radius + (((sin(CGFloat(step) * n * rad)) * amplitude) * (rate))
    var x = cos(radian) * _radius
    var y = sin(radian) * _radius
    x += self.frame.width / 2
    y += self.frame.height / 2
    return CGPoint(x: x,y: y)
  }
}

