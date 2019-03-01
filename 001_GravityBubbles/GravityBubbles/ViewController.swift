//
//  ViewController.swift
//  GravityBubbles
//
//  Created by YueXiao on 2019/2/27.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Constants {
        static let BubbleSize = CGSize.init(width: 28, height: 28)
    }
    
    @IBOutlet var gameView: UIView!
    
    private var gravity = UIGravityBehavior()
    private var collider = UICollisionBehavior()
    private var animator: UIDynamicAnimator?
    
    private func dropBubble(){
        var frame = CGRect()
        frame.origin = CGPoint.zero
        frame.size = Constants.BubbleSize
        let x = gameView.bounds.width * CGFloat.random(in: 0..<1)
        frame.origin.x = x
        let bubbleView = EllispseView(frame: frame)
        //bubbleView.backgroundColor = UIColor.gray
        gameView.addSubview(bubbleView)
        collider.addItem(bubbleView)
        gravity.addItem(bubbleView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animator = UIDynamicAnimator(referenceView: self.gameView)
        self.animator?.addBehavior(self.gravity)
        self.collider.translatesReferenceBoundsIntoBoundary = true
        self.animator?.addBehavior(self.collider)
    }

    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("\(sender.location(in: self.gameView))")
        dropBubble()
    }
}

class EllispseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.randomColor
        layer.cornerRadius = frame.size.width/2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder): not implemented")
    }
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

extension UIColor {
    static var randomColor: UIColor {
        let randomHue = CGFloat.random(in: 0..<1)
        return UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 0.5)
    }
}

