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
        self.backgroundColor = UIColor.clearColor()
        
        self.circleLayer1.strokeColor = UIColor(white: 1, alpha: 0.9).CGColor
        self.circleLayer1.fillColor = UIColor.clearColor().CGColor
        
        self.circleLayer2.strokeColor = UIColor(white: 1, alpha: 0.9).CGColor
        self.circleLayer2.fillColor = UIColor.clearColor().CGColor
        
        self.layer.addSublayer(self.circleLayer1)
        self.layer.addSublayer(self.circleLayer2)
    }
    
    public let speed: CGFloat = 0.01
    
    public override func update() {
        let path1 = UIBezierPath()
        let path2 = UIBezierPath()
        
        let amplitude: CGFloat = 50
        
        let firstPoint1 = self.circleWave(0, step: step, amplitude: amplitude, n: 4)
        path1.moveToPoint(firstPoint1)
        let firstPoint2 = self.circleWave(0, step: step, amplitude: -amplitude, n: 4)
        path2.moveToPoint(firstPoint2)
        
        for i in CGFloat(0).stride(to: 360, by: circleResolution) {
            let point1 = self.circleWave(i, step: step, amplitude: amplitude, n: 4)
            path1.addLineToPoint(point1)
            let point2 = self.circleWave(i, step: step, amplitude: -amplitude, n: 4)
            path2.addLineToPoint(point2)
            step += 1
        }
        
        self.circleLayer1.path = path1.CGPath
        self.circleLayer2.path = path2.CGPath
    }
    
    // MARK: - Private
    private let circleLayer1 = CAShapeLayer()
    private let circleLayer2 = CAShapeLayer()
    
    private var step: UInt64 = 0
    
    private let circleResolution: CGFloat = 0.5
    
    private let rad = CGFloat(M_PI/180)
    
    private func circleWave(angle: CGFloat, step: UInt64, amplitude: CGFloat, n: CGFloat) -> CGPoint {
        
        let frame = CGRectInset(self.frame, 30, 30)
        
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

