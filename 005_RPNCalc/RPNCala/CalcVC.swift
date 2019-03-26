//
//  ViewController.swift
//  RPNCala
//
//  Created by YueXiao on 2019/3/25.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit

class CalcVC: UIViewController {

    @IBOutlet weak var calcDisplay: UILabel!
    private var inputMode = false
    
    private var calcModel = CalcModel()
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: calcDisplay.text!) as! Double
        }
        set {
            calcDisplay.text = "\(newValue)"
            inputMode = false
        }
    }
    
    // 切换到非输入状态，将当前显示数字存入stack
    @IBAction func pushOperand(_ sender: UIButton? = nil) {
        inputMode = false
        if let result = calcModel.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func digitalPressed(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            print("digit pressed = \(digit)")
            if inputMode {
                // 非输入模式下， 将新输入与旧输入拼接
                calcDisplay.text = calcDisplay.text! + digit
                
            } else {
                // 输入模式下
                calcDisplay.text = digit
                inputMode = true
            }
        }
    }
    

    

    @IBAction func operationPressed(_ sender: UIButton) {
        //let operation = sender.currentTitle!
        if inputMode {
            pushOperand()
        }
        if let operation = sender.currentTitle {
            if let result = calcModel.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

}

