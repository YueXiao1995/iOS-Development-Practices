//
//  ViewController.swift
//  HelloWorld
//
//  Created by YueXiao on 2019/4/2.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var label1: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myString = "Successfully created my first iOS application."
        print(myString)
        
        //let frame = CGRect(x: 0, y: 0, width: 200, height: 21)
        //let label2 = UILabel(frame: frame)
        //label2.backgroundColor = .green
        //view1.addSubview(label2)
        
        label1.backgroundColor = UIColor.red
        label1.textColor = UIColor.green
        
    }

    
}

