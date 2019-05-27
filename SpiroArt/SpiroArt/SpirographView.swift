//
//  SpirographView.swift
//  Spirograph
//
//  Created by YueXiao on 2019/3/27.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit
protocol SpirographViewDataSource: class {
    func vertices(forSpirographView spirographView: SpirographView) -> [CGPoint]?
    var vertexRadius: CGFloat { get }
}

@IBDesignable class SpirographView: UIView {
    @IBInspectable private var fillColor: UIColor = UIColor.clear
    @IBInspectable private var strokeColor: UIColor = UIColor.black
    @IBInspectable private var lineWidth: CGFloat = 0.5
    
    //private var strokeColor: UIColor = UIColor.green
    //private var lineWidth: CGFloat = 1.5
    var spirographScale: CGFloat = 0.88 { didSet { setNeedsDisplay() } }
    var spirographCenter: CGPoint { return convert(center, from: superview)}
    var spirographRadius: CGFloat { return min(bounds.size.width, bounds.size.height)/2 * spirographScale}
    
    //@IBInspectable var M: Int = 38 { didSet { M = min(max(M, 3), 80)}}
    //@IBInspectable var N: Int = 12 { didSet { N = min(max(N, 3), 80)}}
    //@IBInspectable var F: Float = 0.95 { didSet { F = min(max(F, 0.0), 1.0)}}
    weak var dataSource: SpirographViewDataSource?

    @objc func scaleView(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            spirographScale *= gesture.scale
            gesture.scale = 1.0
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath(arcCenter: spirographCenter, radius: spirographRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        UIColor(white: 0.5, alpha: 1).setStroke()
        path.lineWidth = lineWidth
        path.stroke()
        
        if let vertices = dataSource?.vertices(forSpirographView: self) {
            path = UIBezierPath()
            for vertex in vertices {
                path.append(UIBezierPath(arcCenter: vertex, radius: dataSource!.vertexRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true))
            }
            fillColor.setFill()
            path.fill()
            
            path = UIBezierPath()
            path.move(to: vertices[0])
            for vertex in vertices[1..<vertices.count] {
                path.addLine(to: vertex)
            }
            //path.close()
            strokeColor.setStroke()
            path.lineWidth = CGFloat(lineWidth)
            path.stroke()
        }
    }
}
extension Int {
    func gcd(_ number: Int) -> Int {
        var a = abs(self)
        var b = abs(number)
        if b > a { (a, b) = (b, a) }
        while b > 0 {
            (a, b) = (b, a % b)
        }
        return a
    }
}
