//
//  FavoritesVC.swift
//  SpiroArt
//
//  Created by YueXiao on 2019/3/31.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    var text: String = "" {
        didSet { favoritesTextView?.text = text }
    }
    
    @IBOutlet weak var favoritesTextView: UITextView! {
        didSet { favoritesTextView.text = text}
    }
    
    override var preferredContentSize: CGSize {
        get {
            if favoritesTextView != nil  && presentingViewController != nil {
                return favoritesTextView.sizeThatFits(presentingViewController!.view.bounds.size) } else {
                return super.preferredContentSize
            }
        } set {
            super.preferredContentSize = newValue
        }
    }
}
