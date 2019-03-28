//
//  SpirographModel.swift
//  Spirograph
//
//  Created by YueXiao on 2019/3/27.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import Foundation
import CoreGraphics



class SpirographModel {
    var M: Int = 38 { didSet { M = min(max(M, 3), 80)}}
    var N: Int = 12 { didSet { N = min(max(N, 3), 80)}}
    var F: Float = 0.95 { didSet { F = min(max(F, 0.0), 1.0)}}
    
    struct Constants {
        static let rotorInterpolationPoints = 38
        static let vertexRadius: CGFloat = 2.5
    }
    
    convenience init(M: Int, N: Int, F: Float) {
        self.init()
        self.M = M
        self.N = N
        self.F = F
    }
    
    func vertices(atCenter center: CGPoint, forRadius radius: CGFloat) -> [CGPoint] {
        var vertices = [CGPoint]()
        let GCD = M.gcd(N)
        let numberOfVertices = CGFloat(Constants.rotorInterpolationPoints * N / GCD)
        let towNPiGCD = CGFloat(N) * 2 * CGFloat.pi / CGFloat(GCD)
        let NoverM = CGFloat(N) / CGFloat(M)
        let MoverN = 1 / NoverM
        
        for t in stride(from: 0.0, to: towNPiGCD, by: towNPiGCD / numberOfVertices) {
            var point = center
            point.x += radius * (1.0 - NoverM) * cos(t)
            point.x += radius * CGFloat(F) * NoverM * cos((MoverN - 1) * t)
            point.y += radius * (1.0 - NoverM) * sin(t)
            point.y -= radius * CGFloat(F) * NoverM * sin((MoverN - 1) * t)
            vertices.append(point)
        }
        return vertices
    }
}
