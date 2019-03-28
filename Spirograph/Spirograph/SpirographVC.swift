//
//  ViewController.swift
//  Spirograph
//
//  Created by YueXiao on 2019/3/27.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit

class SpirographVC: UIViewController, SpirographViewDataSource {
    
    func vertices(forSpirographView spirographView: SpirographView) -> [CGPoint]? {
        var vertices = spirographModel.vertices(atCenter: spirographView.spirographCenter, forRadius: spirographView.spirographRadius)
        
        let count = max(Int(Float(vertices.count) * completion), 1)
        vertices = Array(vertices[0..<count])
        if completion == 1.0 {
            vertices.append(vertices[0])
        }
        
        guard vertices.count > 1 else { return nil }
        return vertices
    }
    
    @IBAction func setStator(_ sender: UISlider) {
        spirographModel = SpirographModel(M: Int(sender.value), N: spirographModel.N, F: spirographModel.F)
    }
    
    @IBAction func setRotor(_ sender: UISlider) {
        spirographModel = SpirographModel(M: spirographModel.M, N: Int(sender.value), F: spirographModel.F)
    }
    
    
    @IBAction func setPenLocation(_ sender: UISlider) {
        spirographModel = SpirographModel(M: spirographModel.M, N: spirographModel.N, F: sender.value)
    }
    
    var vertexRadius: CGFloat { return SpirographModel.Constants.vertexRadius }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var spirographView: SpirographView! {
        didSet {
            spirographView.dataSource = self
            spirographView.addGestureRecognizer(UIPinchGestureRecognizer(target: spirographView, action: #selector(spirographView.scaleView(gesture:))))
        }
    }
    
    private var completion: Float = 1.0 {
        didSet {
            completion = min(max(completion, 0.0), 1.0)
            updateUI()
        }
    }
    
    @IBAction func drawCompletion(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended: fallthrough
        case .changed:
            let translation = sender.translation(in: spirographView)
            completion += Float(translation.x / spirographView.frame.size.width * 2.0)
            sender.setTranslation(CGPoint.zero, in: spirographView)
        default:
            break
        }
    }
    
    var spirographModel = SpirographModel() { didSet { updateUI() }}
    
    private func updateUI() {
        spirographView.setNeedsDisplay()
    }
    
}

