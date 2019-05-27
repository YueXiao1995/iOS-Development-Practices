//
//  ViewController.swift
//  SpiroArt
//
//  Created by YueXiao on 2019/3/28.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {
    
    enum StroyboardIdentifiers: String {
        case artwork1 = "showArtwork1"
        case artwork2 = "showArtwork2"
        case artwork3 = "showArtwork3"
        case custom = "showCustom"
        
        init?(_ segue: UIStoryboardSegue) {
            self.init(rawValue: segue.identifier!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navigationVC = segue.destination as? UINavigationController {
            destinationVC = navigationVC.visibleViewController!
        }
        
        switch StroyboardIdentifiers(segue)! {
        case .artwork1:
            if let spirographVC = destinationVC as? SpirographVC {
                spirographVC.spirographModel = SpirographModel(M: 144, N: 64, F: 0.9)
            }
        case .artwork2:
            if let spirographVC = destinationVC as? SpirographVC {
                spirographVC.spirographModel = SpirographModel(M: 150, N: 42, F: 0.8)
            }
        case .artwork3:
            if let spirographVC = destinationVC as? SpirographVC {
                spirographVC.spirographModel = SpirographModel(M: 105, N: 80, F: 1.0)
            }
        case .custom:
            if let spirographVC = destinationVC as? SpirographVC {
                spirographVC.spirographModel = SpirographModel(M: 144, N: 64, F: 0.9)
            }
        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

